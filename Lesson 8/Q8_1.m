clear
N = 10^5; % 符号数量
M = 16;   % 星座大小
k = log2(M); % 每個符號的比特數

% 定義16-QAM星座點的坐標
alphaRe = [-(2*sqrt(M)/2-1):2:-1 1:2:2*sqrt(M)/2-1];
alphaIm = [-(2*sqrt(M)/2-1):2:-1 1:2:2*sqrt(M)/2-1];
k_16QAM = 1/sqrt(10);

Eb_N0_dB  = [0:15]; % 多個Es/N0值
Es_N0_dB  = Eb_N0_dB + 10*log10(k);

% 二進制到格雷碼的映射
ref = [0:k-1];
map = bitxor(ref,floor(ref/2));
[tt, ind] = sort(map);                                

% 初始化錯誤的符號和比特數量
num_errors_symbol = zeros(1, length(Eb_N0_dB));
num_errors_bit = zeros(1, length(Eb_N0_dB));

for ii = 1:length(Eb_N0_dB)
    
    % 符號生成
    ipBit = rand(1,N*k,1)>0.5; % 隨機0和1
    ipBitReshape = reshape(ipBit,k,N).';
    bin2DecMatrix = ones(N,1)*(2.^[(k/2-1):-1:0]) ; % 從二進制轉換為十進制
    % 實部
    ipBitRe =  ipBitReshape(:,[1:k/2]);
    ipDecRe = sum(ipBitRe.*bin2DecMatrix,2);
    ipGrayDecRe = bitxor(ipDecRe,floor(ipDecRe/2));
    % 虛部
    ipBitIm =  ipBitReshape(:,[k/2+1:k]);
    ipDecIm = sum(ipBitIm.*bin2DecMatrix,2);
    ipGrayDecIm = bitxor(ipDecIm,floor(ipDecIm/2)); 
    % 映射格雷碼符號到星座點
    modRe = alphaRe(ipGrayDecRe+1);
    modIm = alphaIm(ipGrayDecIm+1);
    % 複雜星座圖
    mod = modRe + 1j*modIm;
    s = k_16QAM*mod; % 將發射功率標準化為1 
    
    % 雜訊
    n = 1/sqrt(2)*[randn(1,N) + 1j*randn(1,N)]; % 白色高斯雜訊，0dB方差 
    
    y = s + 10^(-Es_N0_dB(ii)/20)*n; % 添加白色高斯雜訊

    % 解調
    y_re = real(y)/k_16QAM; % 實部
    y_im = imag(y)/k_16QAM; % 虛部

    % 四捨五入到最近的星座點
    ipHatRe = 2*floor(y_re/2)+1;
    ipHatRe(find(ipHatRe>max(alphaRe))) = max(alphaRe);
    ipHatRe(find(ipHatRe<min(alphaRe))) = min(alphaRe);
    ipHatIm = 2*floor(y_im/2)+1;
    ipHatIm(find(ipHatIm>max(alphaIm))) = max(alphaIm);
    ipHatIm(find(ipHatIm<min(alphaIm))) = min(alphaIm);

    % 星座點轉換為十進制
    ipDecHatRe = ind(floor((ipHatRe+4)/2+1))-1; % 基於LUT
    ipDecHatIm = ind(floor((ipHatIm+4)/2+1))-1; % 基於LUT

    % 將二進制字符串轉換為數字
    ipBinHatRe = dec2bin(ipDecHatRe,k/2);
    ipBinHatIm = dec2bin(ipDecHatIm,k/2);

    ipBinHatRe = ipBinHatRe.';
    ipBinHatRe = ipBinHatRe(1:end).';
    ipBinHatRe = reshape(str2num(ipBinHatRe).',k/2,N).' ;
    
    ipBinHatIm = ipBinHatIm.';
    ipBinHatIm = ipBinHatIm(1:end).';
    ipBinHatIm = reshape(str2num(ipBinHatIm).',k/2,N).' ;

    % 計算實部和虛部的錯誤數
    num_errors_symbol(ii) = size(find([ipGrayDecRe- ipDecHatRe]),1) + size(find([ipGrayDecIm - ipDecHatIm]),1) ;
    num_errors_bit(ii) = sum(sum([ipBitRe- ipBinHatRe])) + sum(sum([ipBitIm - ipBinHatIm])) ;

end 
simSer = num_errors_symbol/(N*k);
theoryBer = (1/k)*3/2*erfc(sqrt(k*0.1*(10.^(Eb_N0_dB/10))));

close all; figure
semilogy(Eb_N0_dB,theoryBer,'bs-','LineWidth',2);
hold on
semilogy(Eb_N0_dB,simBer,'mx-','LineWidth',2);
axis([0 15 10^-5 1])
grid on
legend('theory (BER)', 'simulation (BER)', 'simulation (SER)');
xlabel('Eb/No, dB')
ylabel('Error Rate')
title('Error probability curve for 16-QAM modulation')
