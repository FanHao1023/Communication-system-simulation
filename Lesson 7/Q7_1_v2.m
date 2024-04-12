% 8-PAM SER/BER in AWGN Channel
% Eav=1, Eavb=1/2
clear all;

SNR_dB = [-6 -3 0 3 6];
N = 10^6;
Count_SER = zeros(1, length(SNR_dB));
Count_BER = zeros(1, length(SNR_dB));

for n = 1:length(SNR_dB)
    SNR = 10^(SNR_dB(n) / 10);
    N0 = 1 / (2 * SNR);

    for t = 1:N
        % -----------------------------------
        % 生成接收信号
        s = floor(rand(1) * 8); % symbol={0, 1, 2, ..., 7}
        x = linspace(-3, 3, 8);
        y = x(s + 1) + sqrt(N0/2) * randn; % 接收信号
        % -------------------------------------

        % 解调
        s_hat = round(y); % 四舍五入
        Count_SER(n) = Count_SER(n) + (s_hat ~= s);

        % 计算位错误率
        b = dec2bin(s, 3) - '0'; % 将符号映射到3位二进制
        b_hat = dec2bin(s_hat, 3) - '0';
        % 零填充以确保大小一致
        b = [zeros(1, 3 - length(b)), b];
        b_hat = [zeros(1, 3 - length(b_hat)), b_hat];
        Count_BER(n) = Count_BER(n) + sum(abs(b_hat - b));
    end
end

SER = Count_SER / N;
BER = Count_BER / (3 * N);
semilogy(SNR_dB, SER, 'b-.o', SNR_dB, BER, 'r-^');
xlabel('SNR (dB)');
ylabel('Probability of errors');
legend('SER', 'BER');
