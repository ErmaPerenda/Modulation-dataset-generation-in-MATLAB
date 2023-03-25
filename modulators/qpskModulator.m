function y = qpskModulator(x,sps)
%modulates the input x, and returns the root-raised cosine pulse shaped
%signal y. Input signal must be column vector of value in the set [0 3].
%Root-raised cosine filter has a roll-off factor 0.35 and spans 4 symbols. 
%The output signal y has unit power
%persistent filterCoeffs
%if isempty(filterCoeffs)
    filterCoeffs=rcosdesign(0.35,4,sps);
%end
syms=pskmod(x,4,pi/4,'gray');
y=filter(filterCoeffs,1,upsample(syms,sps));
%y=syms;
end