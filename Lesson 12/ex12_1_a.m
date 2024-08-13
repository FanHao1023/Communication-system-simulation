%%%%%---------------  EX13-1-1 ----------------%%%%%
% E[|x1|^2]=E[|x2|^2]=E[|x3|^2]=E[|x4|^2]=2，E=2*4=8，SNR=E/N0
%%(a)傳4筆不同資料
clc;
clear;
SNR_dB=[0 3 6 9 12];
N=10^5;
Nt=4;
E=2*Nt;
M=4;
Nr=[4,6,8,10];
Count_BER=zeros(length(Nr),length(SNR_dB));
for nr=1:length(Nr)
    for n=1:length(SNR_dB)
        SNR=10^(SNR_dB(n)/10);
        N0=E/SNR;%SNR=E/N0
        
        for t=1:N
            %------------------------------------------
            %generate channel
            H=(randn(Nr(nr),Nt)+j*randn(Nr(nr),Nt))*sqrt(1/2); % MIMO channel,Nr x Nt，Hij~CN(0,1)
            [U S V]=svd(H); 
            %-----------------------------------
            %generate tx & rx signal -- 2 bits*4(4個QPSK)
            s=floor(rand(Nt,1)*M); %symbol data
            phi=(pi/M)+s*(pi/(M/2));
            x=exp(j.*phi);
            b=zeros(Nt,2);
            
            for nn=1:Nt
                b(nn,1)=(imag(x(nn))<0); 
                b(nn,2)=(real(x(nn))<0);
            end
            
            s_tx=V*x;%傳送訊號
            %傳4筆不同的資料
            w_rx=(randn(Nr(nr),1)+j*randn(Nr(nr),1))*sqrt(N0/2); % AWGN
            y_rx=H*s_tx+w_rx; % Nr天線接收訊號           
            %-------------------------------------
            %Detection -2bits
            z_rx=U'*y_rx;
            sigma=diag(S);%將對角元素取出變為N*1的向量
            r_rx=z_rx(1:4)./sigma;%只取前4個訊號出來做消除通道影響
            
            b_hat=zeros(4,2);
            for nm=1:Nt
                b_hat_0=zeros(Nt,2);
                if(angle(r_rx(nm))>=0)                    
                    if(angle(r_rx(nm))>pi/2)
                        b_hat_0(nm,2)=1;
                    end
                else
                    b_hat_0=ones(Nt,2);
                    if(angle(r_rx(nm))>-pi/2)
                        b_hat_0(nm,2)=0;
                    end
                end
                b_hat(nm,:)=b_hat_0(nm,:);
            end
            %-----------------------------------------
            Count_BER(nr,n)=Count_BER(nr,n)+sum(sum(abs(b_hat-b)));
        end
    end
end
BER=Count_BER./(2*N*4);
semilogy(SNR_dB,BER(1,:),'r--');
hold on;
semilogy(SNR_dB,BER(2,:),'b--');
semilogy(SNR_dB,BER(3,:),'k--');
semilogy(SNR_dB,BER(4,:),'o--');
legend('SC-L Nr=4','SC-L Nr=6','SC-L Nr=8','SC-L Nr=10');
xlabel('SNR (dB)');
ylabel('Probability of bit errors');
title('MIMO system of QPSK of 4 different symbol');
hold off;