x = linspace(-1, 1, 100);
y = linspace(-2*pi, 2*pi, 100);
[X, Y] = meshgrid(x, y);

z = exp(X + Y*1i);

figure;
subplot(1, 3, 1);
mesh(x, y, real(z));
title('mesh plot');
xlabel('x');
ylabel('y');
zlabel('Re{z}');

subplot(1, 3, 2);
surf(x, y, real(z));
title('surf plot');
xlabel('x');
ylabel('y')
zlabel('Re{z}');

subplot(1, 3, 3);
contour(x, y, real(z));
title('contour plot');
xlabel('x');
ylabel('y');
zlabel('Re{z}');