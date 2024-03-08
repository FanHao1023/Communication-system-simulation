% don't use for loop
d = 0.3:0.1:1.8;
T = (100.*2.*2)./(d.*sqrt(2.^2-d.^2));

plot(d, T);

min_T = min(T);
min_index = find(min_T == T);

plot(d, T, LineWidth=1.5);
title('not using for loop');
xlabel('distance (m)');
ylabel('Tensor (N)');

fprintf('The distance for minimum tensor is %.4f', d(min_index));