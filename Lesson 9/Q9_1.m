clear all;
clc;
SNR_dB=[0 3 6 9 12];
N=10^5;
% Count_SER=zeros(1,length(SNR_dB));
Count_BER=zeros(1,length(SNR_dB));
codew=[0 0 ;0 1 ;1 1 ;1 0];
for n=1:length(SNR_dB)
    SNR=10^(SNR_dB(n)/10);
    N0=1/SNR;
    for t=1:N
        %-----------------------------------
        %generate received signal
        s=floor(rand(1)*4); % symbol={0, 1,2,3}
        phi=(pi/4)+s*(pi/2);
        x=exp(j*phi);
        b=codew((s+1),:);
        h=(randn(1)+j*randn(1))*sqrt(1/2);
        w=(randn(1)+j*randn(1))*sqrt(N0/2);
        y=h*x+w; % 接收訊號
        %-------------------------------------
        %Detection
        y_hat=y/h;
        if angle(y_hat)<0
            s_hat=floor(2*(angle(y_hat)+2*pi)/pi);
        else
            s_hat=floor(2*angle(y_hat)/pi);
        end
 
    b_hat=codew((s_hat+1),:);
    %  Count_SER(n)=Count_SER(n)+sign(abs(s_hat-s));
    Count_BER(n)=Count_BER(n)+sum(abs(b_hat-b));
    end
 end

% SER=Count_SER./N;
BER=Count_BER./(2*N);
% semilogy(SNR_dB,SER,'b-.o',SNR_dB,BER,'r-^');
semilogy(SNR_dB,BER,'r-');
xlabel('SNR (dB)');
% ylabel('Probability of errors');
ylabel('Probability of bit errors');
% legend('SER','BER');
legend('rayleigh fading BER');
hold on