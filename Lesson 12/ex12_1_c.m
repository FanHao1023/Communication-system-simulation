%%%%%---------------  EX13-1-3 ----------------%%%%%
%都傳同筆資料
%%%傳1筆不同資料(x1,x1,x1,x1)
clear ;
SNR_dB=[0 3 6 9 12];
N=10^5;
Nt=4;
E=2*Nt;
M=4;
Nr=[4,6,8,10];%最多4筆data
Count_BER=zeros(length(Nr),length(SNR_dB));
for nr=1:length(Nr)
    for n=1:length(SNR_dB)
        SNR=10^(SNR_dB(n)/10);
        N0=E/SNR;%SNR=E/N0
        
        for t=1:N
            %------------------------------------------
            %generate channel
            H=(randn(Nr(nr),Nt)+j*randn(Nr(nr),Nt))*sqrt(1/2); % MIMO channel,Nr x Nt，Hij~CN(0,1)
            [U S V]=svd(H); %對H做SVD分解
            %-----------------------------------
            %generate tx & rx signal -- 2 bits*1(1個QPSK)
            s=floor(rand(1,1)*M); %symbol data
            phi=(pi/M)+s*(pi/(M/2));
            x=exp(j.*phi);
            b=zeros(1,2);        
            b(1)=(imag(x)<0); 
            b(2)=(real(x)<0);
            
            
            s_tx=V*[x;x;x;x];%傳送訊號[x1,x1,x1,x1]
            %傳4筆相同的資料
            w_rx=(randn(Nr(nr),1)+j*randn(Nr(nr),1))*sqrt(N0/2); % AWGN
            y_rx=H*s_tx+w_rx; % Nr天線接收訊號           
            %-------------------------------------
            %Detection -2bits
            z_rx=U'*y_rx;
            sigma=diag(S);%將對角元素取出變為N*1的向量
            %r_rx=z_rx(1:4)./sigma;%只取前4個訊號出來做消除通道影響
            
            %---------------MRC
            h_mrc=[sigma(1)+sigma(3)+sigma(2)+sigma(4)];%1*1              
            z_mrc=[sum(z_rx(1)+z_rx(3))+sum(z_rx(2)+z_rx(4))];%1*1                       
            r_rx=z_mrc./h_mrc;    %消除通道影響,1*1            
            
            b_hat_0=zeros(1,2);
            if(angle(r_rx)>=0)
                if(angle(r_rx)>pi/2 && angle(r_rx)<pi)
                    b_hat_0(2)=1;
                end
            else
                b_hat_0=ones(1,2);
                if(angle(r_rx)>-pi/2)
                    b_hat_0(2)=0;
                end
            end
            b_hat=b_hat_0;
            
            %-----------------------------------------
            Count_BER(nr,n)=Count_BER(nr,n)+sum(sum(abs(b_hat-b)));
        end
    end
end
BER=Count_BER./(2*N*4);
semilogy(SNR_dB,BER(1,:),'r--');
hold on;
semilogy(SNR_dB,BER(2,:),'b--');
semilogy(SNR_dB,BER(3,:),'g--');
semilogy(SNR_dB,BER(4,:),'o--');
legend('SC-L Nr=4','SC-L Nr=6','SC-L Nr=8','SC-L Nr=10');
xlabel('SNR (dB)');
ylabel('Probability of bit errors');
title('MIMO system of QPSK of 1 different symbol');
hold off;