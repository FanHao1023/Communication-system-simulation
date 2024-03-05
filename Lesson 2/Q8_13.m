k = 8.99e9;
q1 = 1e-13;
q2 = 1e-13;
q3 = -1e-13;
q4 = 1e-13;
eqs0 = 8.85e-12;

r1 = [1, 1, 0];
r2 = [1, -1, 0];
r3 = [-1, -1, 0];
r4 = [-1, 1, 0];

V = @(r) k*(q1/norm(r-r1) + q2/norm(r-r2) + q3/norm(r-r3) + q4/norm(r-r4));

V1 = V([10, 10, 1]);
V2 = V([10, -10, 1]);
V3 = V([-10, -10, 1]);
V4 = V([-10, 10, 1]);

[X, Y] = meshgrid(linspace(-10, 10, 100), linspace(-10, 10, 100));
Z = zeros(size(X));

for i = 1:size(X, 1)
    for j = 1:size(X, 2)
        Z(i,j) = V([X(i, j), Y(i, j), 1]);

    end
end

figure;
surf(X, Y, Z);
title('surf plot');
xlabel('x');
ylabel('y');

figure;
mesh(X, Y, Z);
title('mesh plot');
xlabel('x');
ylabel('y');

figure;
contour(X, Y, Z);
title('contour plot');
xlabel('x');
ylabel('y');