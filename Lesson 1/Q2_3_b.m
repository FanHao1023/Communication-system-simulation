r = input('Please enter radius: ');
a1 = input("Please enter angle: ");
a = (a1/180)*pi;

x = r*cos(a);
y = r*sin(a);

fprintf("the rectangular corrdinates are(%f, %f)", x, y)
