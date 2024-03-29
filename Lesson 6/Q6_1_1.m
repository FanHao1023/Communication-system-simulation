clear all;
clc;
SNR_dB=[-6 -3 0 3 6];
N=10^4;
Count_BERo=zeros(1,length(SNR_dB));
tho=zeros(1,length(SNR_dB));
for n=1:length(SNR_dB)
 SNR=10^(SNR_dB(n)/10);
 N0=1/SNR;
 tho(n)=qfunc(sqrt(1/N0));
 for t=1:N
 %-----------------------------------
 %generate received signal
%  bt=floor(rand(1)*2); % one-bit data
%  bf=abs(1-b1);
 wt=(randn(1))*sqrt(N0/2);
 wf=(randn(1))*sqrt(N0/2);
 yt=1+wt; % 接收訊號
 if yt<wf
    Count_BERo(n)=Count_BERo(n)+1;
 end
 end
end
 BERo=Count_BERo./N;
 

semilogy(SNR_dB,BERo,'r-');
hold on;
semilogy(SNR_dB,tho,'b-.');
%hold off;
xlabel('SNR (dB)');
ylabel('Probability of bit errors');
legend('orthogonal pratical','orthogonal thomery');