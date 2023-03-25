function y=rayleighMultipath(x,fs,fd)
fs_a=200e3;
rayChan = comm.RayleighChannel(...
   'SampleRate',fs, ...
   'PathDelays',[0 0.9 1.7]/fs_a, ...
   'AveragePathGains',[1 0.8 0.3], ...
   'NormalizePathGains',true, ...
   'MaximumDopplerShift',fd, ...
  'DopplerSpectrum',{doppler('Gaussian',0.6),doppler('Flat'),doppler('Flat')}, ...
   'RandomStream','mt19937ar with seed', ...
  'Seed',22, ...
  'PathGainsOutputPort',true);

%rayChan_2 = comm.RayleighChannel(...
%    'SampleRate',fs, ...
%    'PathDelays',[0 0.02 0.6 1.8]/fs_a, ...
%    'AveragePathGains',[0 -1 -4 -10], ...
%   'NormalizePathGains',true, ...
%   'MaximumDopplerShift',0, ...
%   'DopplerSpectrum',{doppler('Gaussian',0.6),doppler('Flat'),doppler('Gaussian',0.6),doppler('Flat')}, ...
%   'RandomStream','mt19937ar with seed', ...
%  'Seed',22, ...
%  'PathGainsOutputPort',true);

%y=rayChan_2(x);
y=rayChan(x);

end