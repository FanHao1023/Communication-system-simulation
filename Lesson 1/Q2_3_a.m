x = input('Please enter x: ');
y = input('Please enter y: ');
r = ((x^2) + (y^2))^0.5;
a1 = atan(y/x);
a = (a1/pi)*180;

fprintf('The polar coordinate are(%f, %f)', r, a)