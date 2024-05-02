clear all;
clc;
SNR_dB=[0 3 6 9 12];
k=[0.5 1 2 4];
N=10^5;
Count_SER=zeros(length(k),length(SNR_dB));
Count_BER=zeros(length(k),length(SNR_dB));
codew=[0 0 ;0 1 ;1 1 ;1 0];
 for m=1:length(k)
    for n=1:length(SNR_dB) 
        SNR=10^(SNR_dB(n)/10);
        N0=1/SNR;
        for t=1:N
            %-----------------------------------
            % generate received signal
            s=floor(rand(1)*4); % symbol={0, 1, 2, 3}
            phi=(pi/4)+s*(pi/2);
            x=exp(j*phi);
            b=codew((s+1),:);
            h=sqrt(k(m)/(k(m)+1))*exp(j*pi/4)+sqrt(1/(k(m)+1))*(randn(1)+j*randn(1))*sqrt(1/2);
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
            % fprintf('%.2f', b_hat);
            % Count_SER(k,n)=Count_SER(k,n)+sign(abs(s_hat-s));
            Count_BER(m,n)=Count_BER(m,n)+sum(abs(b_hat-b));
 
        end
    end
    BER=Count_BER(m,:)./(2*N);
    semilogy(SNR_dB,BER)
    hold on
 end



% semilogy(SNR_dB,BER(1,:),'b-',SNR_dB,BER(2,:),'y-',SNR_dB,BER(3,:),'g-',SNR_dB,BER(4,:),'k-',);
% semilogy(SNR_dB,BER(1,:),'b-')
xlabel('SNR (dB)');
ylabel('Probability of bit errors');
legend('k = 0.5 BER','k = 1 BER','k = 2 BER','k = 4 BER');
hold off