function y=addClockOffset(in,fs,fc,clockOffset)

% Frequency offset, which is determined by the clock offset (ppm)
%     and the center frequency, as fOffset = -(C-1)*fc, where fc is the
%     center frequency in Hz and C is the clock offset factor. clock offset
%     factor, C, is calculated as C = (1+offset/1e6), where offset is the
%     clock offset in ppm.
%Sampling offset, which is determined by the clock offset (ppm) and
%     sampling rate, fs. This method first generates a clock offset value,
%     offset, in ppm, based on the specified maximum clock offset and
%     calculates the offset factor, C, as C = (1+offset/1e6), where offset
%     is the clock offset in ppm. The signal is resampled using interp1
%     function at a new sampling rate of C*fs.


    %maxOffset = 5;
    %clockOffset = (rand() * 2*maxOffset) - maxOffset;
    C = 1 + clockOffset / 1e6;
      
      % Add frequency offset
      frequencyOffset = -(C-1)*fc;
      
      
      FrequencyShifter = comm.PhaseFrequencyOffset(...
        'SampleRate', fs, ...
        'FrequencyOffset',frequencyOffset);
      in=FrequencyShifter(in);
      
      %applyTimingDrift Apply sampling time drift
       
      originalFs = fs;
      x = (0:length(in)-1)' / originalFs;
      newFs = originalFs * C;
      xp = (0:length(in)-1)' / newFs;
      y = interp1(x, in, xp);
end