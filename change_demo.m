
[sig,Fs] = audioread('sample1.wav');

change_point(sig,Fs)

sig1 = [];
sig = sig.';
sig1 = sig ;

N = length(sig); % signal length
n = 0:N-1;
ts = n*(1/Fs); % time for signal

% define the window
wintype = 'rectwin';
winlen = 201;
winamp = [0.5,1]*(1/winlen);

% find the zero-crossing rate
zc = zerocross(sig,wintype,winamp(1),winlen);
size(zc);

% find the zero-crossing rate
E = energy(sig,wintype,winamp(2),winlen) ;
size(E);

% time index for the ST-ZCR and STE after delay compensation
out = (winlen-1)/2:(N+winlen-1)-(winlen-1)/2 ;
t = (out-(winlen-1)/2)*(1/Fs);



figure;
plot(ts,sig); hold on;
plot(t,zc(out),'r','Linewidth',2); 
xlabel('t, seconds');
title('Short-time Zero Crossing Rate');
legend('signal','STZCR');


figure;
plot(ts,sig); hold on;
plot(t,E(out),'r','Linewidth',2); 
xlabel('t, seconds');
title('Short-time Energy');
legend('signal','STE');


sig1(find(E(out)<=0.0001)-100) =[] ;

N1 = length(sig1); % signal length
n1 = 0:N1-1;
ts1 = n1*(1/Fs); % time for signal

% find the zero-crossing rate
E1 = energy(sig,wintype,winamp(2),winlen) ;
size(E1);

% time index for the ST-ZCR and STE after delay compensation
out = (winlen-1)/2:(N1+winlen-1)-(winlen-1)/2 ;
t1 = (out-(winlen-1)/2)*(1/Fs);

figure;
plot(ts1,sig1); hold on;
plot(t1,E1(out),'r','Linewidth',2); hold on;
xlabel('t, seconds');
title('Short-time Energy');
legend('signal','STE');

sig1 = sig1.';
chage = []
chage = change_point(sig1,Fs)
val =  sig1(chage*Fs)
figure;
plot(ts1,sig1); hold on;
plot(chage,val,'r*')
xlabel('t, seconds');
title('Speaker Change Detection');
legend('signal','Speaker Change');