v = 1 : 1 : 200;
R = 1000;
I = v / R;
W = I .* v;
W_dB = 10*log10(W);

plot(v, W_dB, v, W)