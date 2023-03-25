function y = bfmModulator(x,fs)
%modulates the input x
%frequency deviation is 75kHz
%pre-emphasis filter time constant is 75micro seconds

persistent mod 
if isempty(mod)
    M=2;
    mod=comm.FMBroadcastModulator(...
        'AudioSampleRate',fs,...
        'SampleRate',fs);
end
y=mod(x);
end