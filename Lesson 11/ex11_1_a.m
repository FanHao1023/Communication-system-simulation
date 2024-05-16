clear all;
clc;
SNR_dB=[-3 0 3 6 9];
Nr=[2 4 6 8];
Count_BER=zeros(length(Nr),length(SNR_dB));
N=zeros(length(Nr),length(SNR_dB));
for m=1:length(Nr)
for n=1:length(SNR_dB)
SNR=10^(SNR_dB(n)/10);
N0=1/SNR;
while(1)
if (Count_BER(m,n)>=10 && N(m,n)>=10^5)
    break
end
%-----------------------------------
%generate received signal
b=floor(rand(1)*4); % one-bit data
phi=(pi/4)+b*(pi/2);
 x=exp(j*phi);
h=(randn(Nr(m),1)+j*randn(Nr(m),1))*sqrt(1/2); % SIMO channel, Nr

w=(randn(Nr(m),1)+j*randn(Nr(m),1))*sqrt(N0/2); % AWGN r=[n1, n2, n3, n4]
y=x.*h+w; % Nr
%-------------------------------------%Detection
[maxi ind]=max(abs(h));
beta_sc=zeros(Nr(m),1);
beta_sc(ind)=1;
z_sc=sum(y.*beta_sc);
h_sc=sum(h.*beta_sc);
r=z_sc/h_sc;
if angle(r)<0
 b_hat=floor(2*(angle(r)+2*pi)/pi);
 else
 b_hat=floor(2*angle(r)/pi);
 end
b_hat2=de2bi(b_hat,2);
b2=de2bi(b,2);
Count_BER(m,n)=Count_BER(m,n)+sum(abs(b_hat2-b2));
N(m,n)=N(m,n)+1;
end
end
end
BER=Count_BER./(2*N);
semilogy(SNR_dB,BER(1,:),'b-.');
hold on
semilogy(SNR_dB,BER(2,:),'r-.');
semilogy(SNR_dB,BER(3,:),'g-.');
semilogy(SNR_dB,BER(4,:),'y-.');
legend('SC-L=2','SC-L=4','SC-L=6','SC-L=8');
xlabel('SNR (dB)');
ylabel('Probability of bit errors');
hold off