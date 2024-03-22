% (1) 
p = @(x) 2 * x .* exp(-x.^2);

cdf = @(x) 1 - exp(-x.^2);

% (2) 
mu = sqrt(pi/2);
sigma_square = (4 - pi)/2;

% (3) 
num_samples = 10^6;
X = sqrt(-2 * log(1 - rand(num_samples, 1)));

% (4) 
p_Y = @(y) (1/(sqrt(sigma_square) * sqrt(pi))) * exp(-(y - mu).^2 / (2 * sigma_square)) .* (y >= 0);

% histogram
figure;
histogram(X(X <= 4), 'Normalization', 'pdf', 'BinWidth', 0.01);
hold on;
x_values = 0:0.01:4;
% plot(x_values, p(x_values), 'r', 'LineWidth', 2);
xlabel('x');
ylabel('Probability Density');
title('Rayleigh Distribution PDF');

% (4) 
Y = X.^2;
figure;
histogram(Y(Y <= 4), 'Normalization', 'pdf', 'BinWidth', 0.01);
hold on;
y_values = 0:0.01:16;
% plot(y_values, p_Y(y_values), 'r', 'LineWidth', 2);
xlabel('y');
ylabel('Probability Density');
title('Y=X^2 Distribution PDF');

% 显示平均值和方差
disp(['Rayleigh Distribution - Mean: ', num2str(mu)]);
disp(['Rayleigh Distribution - Variance: ', num2str(sigma_square)]);
