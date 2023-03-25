function x = getAudio(sample_length,fs)
%returns audio source A with the sample length of sample_length
% and the sample rate fs
persistent audioSrc audioRc
if isempty(audioSrc)
    audioSrc=dsp.AudioFileReader('audio_mix_441.wav',...
                'SamplesPerFrame',sample_length,...
                'PlayCount',inf);
   audioRc=dsp.SampleRateConverter('Bandwidth',30e3,...
                'InputSampleRate',audioSrc.SampleRate,...
                'OutputSampleRate',fs);
  [~, decimFactor] = getRateChangeFactors(audioRc);
  audioSrc.SamplesPerFrame=ceil(sample_length/fs * audioSrc.SampleRate/decimFactor)*decimFactor;
              
end
x=audioRc(audioSrc());
x=x(1:sample_length,1);
end