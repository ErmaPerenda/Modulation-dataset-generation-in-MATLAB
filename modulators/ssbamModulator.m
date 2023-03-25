function y = ssbamModulator(x,fs)
%modulates the input x
%IF frequency is 50khz
y=ssbmod(x,50e3,fs);
end