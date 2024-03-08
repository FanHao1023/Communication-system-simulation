% use for loop
d=0.3:0.1:1.8;

T=zeros(1,16);
for i=1:16
    T(i) = (100*4) / (d(i)*sqrt(4-d(i)^2));
end

plot(d, T, 'LineWidth', 1.5);
title('Using for loop');
xlabel('distance (m)');
ylabel('Tensor (N)');

min_T = min(T);
min_index = find(min_T == T);
fprintf('The distance for minimum tensor is %.4f', d(min_index));
