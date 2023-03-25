function y = pam4Modulator(x,sps)
%modulates the input x, and returns the root-raised cosine pulse shaped
%signal y. Input signal must be column vector of value in the set [0 3].
%Root-raised cosine filter has a roll-off factor 0.35 and spans 4 symbols. 
%The output signal y has unit power
%persistent filterCoeffs amp
%if isempty(filterCoeffs)
    filterCoeffs=rcosdesign(0.35,4,sps);
    amp=1/sqrt(mean(abs(pammod(0:3,4)).^2));
%end
syms=amp*pammod(x,4,0,'gray');
y=filter(filterCoeffs,1,upsample(syms,sps));
end