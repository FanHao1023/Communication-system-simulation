R = 100;
L = 0.1e-3;
C = 0.25e-9;

f = logspace(5, 7, 100);

Zc = -1i ./ (2*pi*f*C);
Zl = 1i*2*pi.*f*L;


I = 120 ./ (R + Zc + Zl);
phase = angle(I)*(180/pi);

figure;
plot(f, I)
title('current v.s. frequency (linear)');
xlabel('frequency (Hz)');
ylabel('I (A)');

figure;
semilogx(f, I);
title('current v.s. frequency (linear)');
xlabel('frequency (Hz)');
ylabel('I (A)');

figure;
plot(f, phase);
title('phase v.s. frequency (linear)');
xlabel('frequency (Hz)');
ylabel('phase (degree)');

figure;
semilogx(f, phase);
title('phase v.s. frequency (log)');
xlabel('frequency (Hz)');
ylabel('phase (degree)');

figure;
subplot(2, 1, 1);
semilogx(f, abs(I));
title('Current v.s. frequency');
xlabel('frequency (Hz)');
ylabel('current (A)');

subplot(2, 1, 2);
semilogx(f, phase);
title('current phase v.s. frequency');
xlabel('frequency (Hz)');
ylabel('phase (degree)');



