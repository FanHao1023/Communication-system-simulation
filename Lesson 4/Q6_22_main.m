num_rolls = 100000;
rolls = zeros(1, num_rolls);

for i = 1:num_rolls
    rolls(i) = dice();
end

figure;
histogram(rolls);
title('Rolling dice Distribution');
xlabel('Value');
ylabel('number of times');
xlim([0.5, 6.5]);





