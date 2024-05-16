clear all;
SNR_dB=[-3 0 3 6 9 12];
Nt=10^4;% 試驗次數
Nc=64; % 子載波數量
Lcp=16; % 循環前綴數量
Nb=2;  % 每個符號的比特數量
Lch=5;  % 通道長度
Count_BER=zeros(1,length(SNR_dB));% 初始化錯誤計數
for n=1:length(SNR_dB)
 SNR=10^(SNR_dB(n)/10);
 N0=1/(Nc*SNR);% 噪聲功率譜密度
 for t=1:Nt
 %-----------------------------------
 % 生成發射信號
 b=floor(rand(1,Nc*Nb)*2); % two-bit data
 X_f=zeros(Nc,1);
 for ns=1:Nc
 X_f(ns)=j*(-1)^b(2*ns-1)+(-1)^b(2*ns); % 二進制轉QPSK
 end
 x_t = ifft(X_f);%轉換到時域
 % 插入循環前綴
 x_t_CP=[zeros(Lcp,1); x_t];
 %-----------------------------------
 % 生成通道係數
 h=zeros(Lch,1);
 for nch=1:Lch
 var_ch=(1-exp(-1))*exp(-nch+1)/(1-exp(-Lch));
 h(nch)=(randn(1)+j*randn(1))*sqrt(var_ch/2);
 end
 % 生成接收信號
 y_t_CP=conv(x_t_CP,h)+(randn(Nc+Lcp+Lch-1,1)+j*randn(Nc+Lcp+Lch-1,1))*sqrt(N0/2);
 %-------------------------------------
 % 移除循環前綴:
 y_t=y_t_CP(Lcp+1:Lcp+Nc)+[y_t_CP(Lcp+Nc+1:Lcp+Nc+Lch-1);zeros((Nc-Lch+1),1)];
 % 均衡和檢測 :
 Y_f=fft(y_t);%FFT為轉換到頻域
 H=fft(h, Nc); % 頻域通道響應
 Z_f=inv(diag(H))*Y_f;%通過除以頻域通道響應，進行均衡
 X_f_hat=sign(real(Z_f))+j.*sign(imag(Z_f));
 b_hat=zeros(1,Nc*Nb);
 for ns=1:Nc
 if imag(X_f_hat(ns))<0
 b_hat(2*ns-1)=1;
 end
 if real(X_f_hat(ns))<0
 b_hat(2*ns)=1;
 end
 end
 Count_BER(n)=Count_BER(n)+sum(abs(b_hat-b));
 end
end
BER=Count_BER./(Nb*Nc*Nt);
semilogy(SNR_dB,BER);
xlabel('SNR (dB)');
ylabel('Probability of errors');