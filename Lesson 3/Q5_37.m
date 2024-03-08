n = input('Please enter a number for n: ');
data = load("input3.dat");

filtered_data = medfilt1(data, n, 'replicate');

figure;
plot(data, '-b', 'LineWidth', 1.5);
hold on;
plot(filtered_data, '-r', 'LineWidth', 1.5);

title('Original Data and Filtered Data');
xlabel('Sample');
ylabel('Value');
legend('Original Data', 'Filtered Data', 'Location', 'best');
grid on;
