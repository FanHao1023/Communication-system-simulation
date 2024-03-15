x = 0:0.05:5;
y = sin(x);
dy_correct = cos(x);
dy_calculated = derivative(y, 0.05);

figure;
subplot(2, 1, 1);
plot(x, y, 'b', x, dy_correct, 'r', 'LineWidth', 1.5);
title('Function (sin) and its Derivative (cos)');
xlabel('x');
ylabel('y');
legend('sin(x)', 'cos(x)');

subplot(2, 1, 2);
plot(x, dy_calculated, 'g', x, dy_correct, 'r', 'LineWidth', 1.5);
title('Calculated Derivative and Correct Derivative');
xlabel('x');
ylabel('dy/dx');
legend('Calculated Derivative', 'Correct Derivative');

