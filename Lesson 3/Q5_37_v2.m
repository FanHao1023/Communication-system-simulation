n = input('請輸入濾波器平均樣本數: ');
if ~mod(n, 2)
    n = n + 1;
end

fid = fopen('input3.dat');
[B, COUNT] = fscanf(fid, '%f');
B = transpose(B);
fclose(fid);
A = B;
AB = zeros(1, COUNT);
for k = 1:COUNT
    if k == 1 || k == COUNT
        AB(k) = A(k);
    elseif k <= ((n - 1) / 2)
        AB(k) = median(A(1 : 2 * k - 1));
    elseif k >= (COUNT - ((n - 1) / 2))
        AB(k) = median(A(2 * k - COUNT : COUNT));
    else
        AB(k) = median(A(k - ((n - 1) / 2) : k + ((n - 1) / 2)));
    end
end

figure(1)
plot(1:COUNT, AB, 'b-', 'LineWidth', 2);
hold on;
plot(1:COUNT, B, 'r-', 'LineWidth', 1);
title('moving median');
xlabel('count');
ylabel('value');
axis([1 COUNT -0.5 4.5])

