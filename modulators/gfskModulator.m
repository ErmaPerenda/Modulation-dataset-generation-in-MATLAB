function y = gfskModulator(x,sps)
%modulates the input x, and returns the root-raised cosine pulse shaped
%signal y. Input signal must be column vector of value in the set [0 1].
%Root-raised cosine filter has a roll-off factor 0.35 and spans 4 symbols. 
%The output signal y has unit power
%BT product is 0.35 and modulation index is 1
%persistent mod meanM
%if isempty(mod)
    M=2;
    mod=comm.CPMModulator(...
        'ModulationOrder',M,...
        'FrequencyPulse','Gaussian',...
        'BandwidthTimeProduct',0.35,...
        'ModulationIndex',1,...
        'SamplesPerSymbol',sps,...
        'SymbolMapping','Gray');
    meanM=mean(0:M-1);
%end
y=mod(2*(x-meanM));
end