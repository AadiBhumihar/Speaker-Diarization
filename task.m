
[data, fs] = wavread("Aadir.wav");
N = length(data)
t = linspace(0, N/fs, N);
plot(t,data)
sound(data, fs);