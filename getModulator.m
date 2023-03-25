function modulator=getModulator(modType,sps,fs)
%getModulator selects modulator based on modulation Type
%modType - type of modulation
%sps - number samples per symbol
%fs sample rate
switch modType
    case "BPSK"
        modulator = @(x) bpskModulator(x,sps);
    case "QPSK"
        modulator = @(x) qpskModulator(x,sps);
    case "OQPSK"
        modulator = @(x) oqpskModulator(x,sps);
    case "PSK8"
        modulator = @(x) psk8Modulator(x,sps);
    case "APSK16"
        modulator = @(x) apsk16Modulator(x,sps);
    case "APSK32"
        modulator = @(x) apsk32Modulator(x,sps);
    case "APSK64"
        modulator = @(x) apsk64Modulator(x,sps);
    case "APSK128"
        modulator = @(x) apsk128Modulator(x,sps);
    case "APSK256"
        modulator = @(x) apsk256Modulator(x,sps);
    case "QAM16"
        modulator = @(x) qam16Modulator(x,sps);
    case "QAM32"
        modulator = @(x) qam32Modulator(x,sps);
    case "QAM64"
        modulator = @(x) qam64Modulator(x,sps);
    case "QAM128"
        modulator = @(x) qam128Modulator(x,sps);
    case "QAM256"
        modulator = @(x) qam256Modulator(x,sps);
    case "GFSK"
        modulator = @(x) gfskModulator(x,sps);
    case "CPFSK"
        modulator = @(x) cpfskModulator(x,sps);
    case "PAM4"
        modulator = @(x) pam4Modulator(x,sps);
    case "BFM"
        modulator = @(x) bfmModulator(x,fs);
    case "DSBAM"
        modulator = @(x) dsbamModulator(x,fs);
    case "SSBAM"
        modulator = @(x) ssbamModulator(x,fs);
    otherwise
        assert (false, 'Unsupported modulatation type.');
        
end
end