function y = apsk128Modulator(x,sps)
%modulates the input x, and returns the root-raised cosine pulse shaped
%signal y. Input signal must be column vector of value in the set [0 127].
%Root-raised cosine filter has a roll-off factor 0.35 and spans 4 symbols. 
%The output signal y has unit power

filterCoeffs=rcosdesign(0.35,4,sps);
syms=dvbsapskmod(x,128,'s2x','UnitAveragePower',true);
y=filter(filterCoeffs,1,upsample(syms,sps));
%y=syms;
end