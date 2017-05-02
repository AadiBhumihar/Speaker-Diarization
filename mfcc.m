function [y] = mfcc()

tic
[sig, Fs] = wavread("Aadir.wav");

frame_length = 0.03; 
frame_hop = 0.01;
n_MFCC = 19; 
delta_feature = '0';
S = melcepst(sig,Fs,'0',n_MFCC, floor(3*log(Fs)) ,frame_length * Fs, frame_hop * Fs);

MFCC{1} = S;

disp(['Feature extraction complete. Time taken = ' num2str(toc)])
