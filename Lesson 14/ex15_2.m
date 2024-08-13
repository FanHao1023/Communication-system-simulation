clc;
clear;

% generate codew
G = [1 0 0 0 1 1 1 ;    %metrix G
     0 1 0 0 1 1 0 ;
     0 0 1 0 1 0 1 ;
     0 0 0 1 0 1 1 ];

U = [0 0 0 0 ;      %metrix U，4bits所有組合
     0 0 0 1 ;
     0 0 1 0 ;
     0 0 1 1 ;
     0 1 0 0 ;
     0 1 0 1 ;
     0 1 1 0 ;
     0 1 1 1 ;
     1 0 0 0 ;
     1 0 0 1 ;
     1 0 1 0 ;
     1 0 1 1 ;
     1 1 0 0 ;
     1 1 0 1 ;
     1 1 1 0 ;
     1 1 1 1 ];

 recodew = U*G;              
 codew = mod(recodew,2);    %將所有bits用1或0表示

 % BPSK 
 SNR_dB = 6;    %Eb/N0=6dB
 N = 10^5;     
 Count_BER = 0; 
 SNR = 10.^(SNR_dB/10);  %將dB值轉為數值
 N0 = 1/(SNR);    %傳送的7bits中，碼率為4/7

 for t = 1:N            %執行N次
    s = randperm(16,1)-1;  %generate 隨機整數0-15
    x = codew((s+1),:);    %產生輸出訊號x
        for i = 1:7         
            w = (randn(1))*sqrt(N0/2);  %產生雜訊w
            if x(i)==0  %BPSK，若x:1->-1、0->1
                x(i)=1;  
            else
                x(i)=-1;
            end   
            y(i) = x(i)+w;      %接收訊號為輸出訊號加上雜訊
        end  

% Detection

s_hat = hardlim(-y);   %hardlim of -y，即(-y)>0，則s_hat=1；(-y)<0，則s_hat=0
    for j = 1:16
        dH(j) = sum(xor(codew(j,:), s_hat));    %使用漢明距離公式檢查錯誤bits數
    end
    [M,I] = min(dH);    %尋找解調後錯誤bits最少的，即接收端認為是正確的數
    x_hat = dec2bin(I-1,4)-48;      %將解調後錯誤bits最少的位置-1後，直接轉為二進位數值，即解調為接收訊號
    bin_s = dec2bin(s,4)-48;        %將前面隨機產生的整數轉為二進位，即傳送端正確的數
    Count_BER = Count_BER + sum(abs(bin_s - x_hat));    %錯誤bits數=傳送端正確的數-解調後被認為是正確的數                                                       %為0，表示沒有錯的bits；不為0，則是有錯誤的bits
 end

 BER=Count_BER./(4*N);  %錯誤率=錯誤數/data數
 fprintf('BER = %f\n', BER);    
 
 