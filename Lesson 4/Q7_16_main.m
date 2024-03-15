x = 0:0.05:5;
y_sin = sin(x);
noise = (1/200) * random_normal(1, length(x)); 
y_noisy_sin = y_sin + noise;

dy_noisy_sin = derivative(y_noisy_sin, 0.05);

dy_correct_sin = cos(x);

figure;
subplot(2, 1, 1);
plot(x, y_sin, 'g', x, y_noisy_sin, 'b', 'LineWidth', 1.5);
title('sin(x) and Noisy sin(x)');
xlabel('x');
ylabel('y');
legend('sin(x)', 'Noisy sin(x)');


subplot(2, 1, 2);
plot(x, dy_correct_sin, 'r', x, dy_noisy_sin, 'm', 'LineWidth', 1.5);
title('Correct Derivative and Noisy Derivative');
xlabel('x');
ylabel('dy/dx');
legend('Correct Derivative', 'Noisy Derivative');

