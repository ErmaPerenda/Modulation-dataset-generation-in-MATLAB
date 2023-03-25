function y = dsbamModulator(x,fs)
%modulates the input x
%IF frequency is 50khz
y=ammod(x,50e3,fs);
end