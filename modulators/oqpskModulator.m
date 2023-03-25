function y = oqpskModulator(x,sps)
%modulates the input x, and returns the root-raised cosine pulse shaped
%signal y. Input signal must be column vector of value in the set [0 63].
%Root-raised cosine filter has a roll-off factor 0.35 and spans 4 symbols. 
%The output signal y has unit power
%persistent filterCoeffs

mod_oqpsk = comm.OQPSKModulator('PulseShape', 'Normal raised cosine', 'RolloffFactor', 0.35, ...
                                 'SamplesPerSymbol', sps, 'SymbolMapping', 'Gray', ...
                                 'FilterSpanInSymbols',4);

y=mod_oqpsk(x);

end