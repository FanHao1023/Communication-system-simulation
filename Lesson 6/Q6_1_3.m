clear all;
SNR_dB=[-3 0 3 6 9];
N=10^4;
Count_BER=zeros(1,length(SNR_dB));
tho=zeros(1,length(SNR_dB));
 
 for n=1:length(SNR_dB)
 SNR=10^(SNR_dB(n)/10);
 N0=1/SNR;
 tho(n)=qfunc(sqrt(1/(2*N0)));
 for t=1:N
 %-----------------------------------
 %generate received signal
 %b=floor(rand(1)*2); % one-bit data
 w=(randn(1))*sqrt(N0/2);
 y=1+w; % 接收訊號
 %-------------------------------------
 %Detection
 if y<0.5
 Count_BER(n)=Count_BER(n)+1;
 end
 end
 end
 BER=Count_BER./N;
 
 
semilogy(SNR_dB,BER,'r-');
hold on;
semilogy(SNR_dB,tho,'b-.');
hold off;
xlabel('SNR (dB)');
ylabel('Probability of bit errors');
legend('on-off pratical','on-off thomery');