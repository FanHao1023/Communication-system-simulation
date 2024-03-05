v = 0.85*340;
a = 2*9.81;
r1 = (v^2)/a;
fprintf('Radius = %f\n',r1)

v2 = 1.5*340;
r2 = (v2^2)/a;
fprintf('Radius = %f\n', r2)

v3 = 0.5*340 : 1 : 2*340;
r3 = (v3.^2)/a;
plot(v3, r3, 'r');
xlabel('v(m/s)')
ylabel('r(m)')

amax = 7*9.81;
rmin = (v2^2)/amax;
fprintf('Minmum radius = %f', rmin)
