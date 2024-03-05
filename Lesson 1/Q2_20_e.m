a1 = 2*9.81 : 0.1 : 8*9.81;
r4 = (v.^2)./a1;
plot(a1, r4, 'b')
xlabel('a(m/s^2)')
ylabel('r(m)')