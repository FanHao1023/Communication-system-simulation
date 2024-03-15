data = random_normal(1, 1000);
std_dev = std(data(:));  

figure;
histogram(data);
title('Standard Normal Distribution');
xlabel('Value');
ylabel('Probability');

disp(['std : ', num2str(std_dev)]);
