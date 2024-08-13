clc;
clear;

G = [1 0 0 0 1 1 1 ;    %題目給的4X7 metrix G
     0 1 0 0 1 1 0 ;
     0 0 1 0 1 0 1 ;
     0 0 0 1 0 1 1 ];

U = zeros(16,4);  %設U為16X4的空矩陣

for i=0:15      %4bits二進位值的範圍為十進位的0-15
    u = dec2bin(i,4)-48;    %將十進位的值轉換成二進位
    U((i+1),:) = u;         %並將結果排成16X4metrix U
end

recodew = U*G;            
codew = mod(recodew,2)     %使原來的metrics保持只有0跟1，0->0、1->1、2->0、3->1
