clear all;
clc;
SNR_dB=[0 3 6 9 12];
k=[0 0.5 1 2 4];
N=10^6;
Count_stop=zeros(length(k),length(SNR_dB));
for m=1:length(k) 
    for n=1:length(SNR_dB)
        SNR=10^(SNR_dB(n)/10);
        N0=1/SNR;
        for t=1:N
            %-----------------------------------
            %generate received signal
            h=sqrt(k(m)/(k(m)+1))*exp(j*pi/4)+sqrt(1/(k(m)+1))*(randn(1)+j*randn(1))*sqrt(1/2);
            p=2/N0*abs(h)^2;
 
            %-------------------------------------
            %Detection
            if p<3
                Count_stop(m,n)=Count_stop(m,n)+1;
            end
            %  Count_SER(k,n)=Count_SER(k,n)+sign(abs(s_hat-s));
 
        end
    end
    stop=Count_stop(m,:)./(N);
    semilogy(SNR_dB,stop)
    hold on
 end


% semilogy(SNR_dB,BER(1,:),'b-',SNR_dB,BER(2,:),'y-',SNR_dB,BER(3,:),'g-.o',SNR_dB,BER(4,:),'k-.o',);

xlabel('SNR (dB)');
ylabel('Probability of bit errors');
legend('k = 0 BER','k = 0.5 BER','k = 1 BER','k = 2 BER','k = 4 BER');
hold off