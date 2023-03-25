function dataSrc=getDataSource(modType,sps,sample_length,fs)
%generate random source symbols 
%modType - modulation type
%sps - number samples per symbol
%sample_length - length of frame
%fs - sampling frequency
switch modType
    case {"BPSK","GFSK","CPFSK"}
        M=2;
        dataSrc = @() randi([0 M-1],ceil(ceil(sample_length/sps)),1);
    case {"QPSK","PAM4", "OQPSK"}
        M=4;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case "PSK8"
        M=8;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case {"QAM16","APSK16"}
        M=16;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case {"QAM32","APSK32"}
        M=32;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case {"QAM64","APSK64"}
        M=64;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case {"QAM128","APSK128"}
        M=128;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case {"QAM256","APSK256"}
        M=256;
        dataSrc = @() randi([0 M-1],ceil(sample_length/sps),1);
    case {"BFM","DSBAM","SSBAM"}
        dataSrc= @() getAudio(sample_length,fs);
    otherwise
        assert(false,'Cannot generate source data for unsupported modulation type');
end
end