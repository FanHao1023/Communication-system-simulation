numbers_zone1 = 1:38;

numbers_zone2 = 1:8;

selected_zone1 = randperm(length(numbers_zone1), 6);

selected_zone2 = randi(length(numbers_zone2));

winning_numbers = [numbers_zone1(selected_zone1), numbers_zone2(selected_zone2)];

disp("中獎號碼為：" + num2str(winning_numbers));
