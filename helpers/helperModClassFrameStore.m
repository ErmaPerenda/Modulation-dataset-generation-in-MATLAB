classdef helperModClassFrameStore < handle
%helperModClassFrameStore Manage data for modulation classification
%   FS = helperModClassFrameStore creates a frame store object, FS, that
%   stores the complex baseband signals in a format usable in machine
%   learning algorithms.
%   
%   we modified original MathWorks script to adjust to our needs
%   FS = helperModClassFrameStore(MAXFR,SPF,LABELS_MOD_TYPES,SNR,
%           LABELS_POWER_RATIOS,LABELS_FREQUENCY_OFFSETS, LABELS_BWS,NUM_SIGNALS)
%    creates a frame store
%   object, FH, with the maximum number of frames, MAXFR, samples per
%   frame, SPF, and expected labels, LABELS.
%   
%   Methods:
%   
%   add(FS,FRAMES,LABELS_MOD_TYPES,SNR,
%       LABELS_POWER_RATIOS,LABELS_FREQUENCY_OFFSETS, 
%       LABELS_BWS,NUM_SIGNALS) adds frame(s), FRAMES, with mentioned labels, 
%   to the frame store.
%
%   [FRAMES,LABELS] = get(FS) returns stored frames and corresponding
%   labels from frame store, FS.
%   

  properties
    OutputFormat = FrameStoreOutputFormat.IQAsRows
  end
  
  properties (SetAccess=private)
    %NumFrames Number of frames in the frame store
    NumFrames = 0
    %MaximumNumFrames Capacity of frame store
    MaximumNumFrames
    %SamplesPerFrame Samples per frame
    SamplesPerFrame
    %Labels Set of expected labels
    LabelsModulationTypes
    SNR
    LabelsPowerRatios
    LabelsFrequencyOffsets
    LabelsBws
    NumSignals
  end
  
  properties (Access=private)
    Frames
    Label
  end
  
  methods
    function obj = helperModClassFrameStore(varargin)
      %helperModClassFrameStore Store complex I/Q frames
      %    FS = helperModClassFrameStore(MAXFR,SPF,LABELS) returns a frame
      %    store object, FS, to store complex I/Q baseband frames of type
      %    LABEL with frame size of SPF. Frame are stored as a
      %    [SPFxNUMFRAMES] array.
      
      inputs = inputParser;
      addRequired(inputs, 'MaximumNumFrames')
      addRequired(inputs, 'SamplesPerFrame')
      addRequired(inputs, 'LabelsModulationTypes')
      addRequired(inputs, 'SNR')
      addRequired(inputs, 'LabelsPowerRatios')
      addRequired(inputs, 'LabelsFrequencyOffsets')
      addRequired(inputs, 'LabelsBws')
      addRequired(inputs, 'NumSignals')
      parse(inputs, varargin{:})
      
      obj.SamplesPerFrame = inputs.Results.SamplesPerFrame;
      obj.MaximumNumFrames = inputs.Results.MaximumNumFrames;
      obj.LabelsModulationTypes=inputs.Results.LabelsModulationTypes;
      obj.SNR=inputs.Results.SNR;
      obj.LabelsPowerRatios=inputs.Results.LabelsPowerRatios;
      obj.LabelsFrequencyOffsets=inputs.Results.LabelsFrequencyOffsets;
      obj.LabelsBws=inputs.Results.LabelsBws;
      obj.NumSignals=inputs.Results.NumSignals;
      
      obj.Frames = ...
        zeros(obj.SamplesPerFrame,obj.MaximumNumFrames);
      obj.Label = repmat({obj.LabelsModulationTypes(1),0,...
                obj.LabelsPowerRatios(1),obj.LabelsFrequencyOffsets(1),...
                obj.LabelsBws(1),0},obj.MaximumNumFrames,1);
    end
    
    function printLabel(obj,varargin)
        
        label=varargin;
        disp(size(label));
        fprintf(['New frame is created with the label: \n',  ...
        'Mod type %s; SNR %d, Power ratios: %s, Frequency Offsets: %s, \n',  ...
        'Bandwidths: %s, Num signals: %d'], label{1}, label {2}, label{3},...
        label{4}, label{5}, label{6});
    end
    
    function add(obj,frames,varargin)
      %add     Add baseband frames to frame store
      %   add(FS,FRAMES,LABEL) adds frame(s), FRAMES, with label, LABEL, to
      %   frame store FS.
      label=varargin;
      numNewFrames = size(frames,2);
      if (~isscalar(label) && numNewFrames ~= length(label)) ...
          && (size(frames,1) ~= obj.SamplesPerFrame)
        error(message('comm_demos:helperModClassFrameStore:MismatchedInputSize'));
      end
      
      % Add frames
      startIdx = obj.NumFrames+1;
      endIdx = obj.NumFrames+numNewFrames;
      obj.Frames(:,startIdx:endIdx) = frames;
      
      % Add labels types
      %if all(ismember(label,obj.Labels))
        obj.Label(startIdx:endIdx,:) = label;
      %else
      %  error(message('comm_demos:helperModClassFrameStore:UnknownLabel',...
     %     label(~ismember(label,obj.Labels))))
      %end

      obj.NumFrames = obj.NumFrames + numNewFrames;
    end
    
    function [frames,labels] = get(obj,fs)
      %get     Return frames and labels
      %   [FRAMES,LABELS]=get(FS) returns the frames and corresponding
      %   labels in the frame store, FS. 
      %   
      %   If OutputFormat is IQAsRows, then FRAMES is an array of size
      %   [2xSPFx1xNUMFRAMES], where the first row is the in-phase
      %   component and the second row is the quadrature component.
      %   
      %   If OutputFormat is IQAsPages, then FRAMES is an array of size
      %   [1xSPFx2xNUMFRAMES], where the first page (3rd dimension) is the
      %   in-phase component and the second page is the quadrature
      %   component.
      
      switch obj.OutputFormat
        case FrameStoreOutputFormat.IQAsRows
          I = real(obj.Frames(:,1:obj.NumFrames));
          Q = imag(obj.Frames(:,1:obj.NumFrames));
          
          psd=zeros(size(I));
         
          I = permute(I,[3 1 4 2]);
          Q = permute(Q,[3 1 4 2]);
          
         for i=1:size(psd,2)
            [S,F,T,P]=spectrogram(obj.Frames(:,i),hanning(obj.SamplesPerFrame), ...
             0,obj.SamplesPerFrame,fs,'centered');
             psd(:,i)=10*log10(abs(fftshift(P)));
         end
        
         psd=permute(psd,[3 1 4 2]);
         frames = cat(1,I,Q,psd);
       
        case FrameStoreOutputFormat.IQAsPages
          I = real(obj.Frames(:,1:obj.NumFrames));
          Q = imag(obj.Frames(:,1:obj.NumFrames));
          psd=zeros(size(I));
          for i=1:size(psd,2)
            [S,F,T,P]=spectrogram(obj.Frames(:,i),hanning(obj.SamplesPerFrame), ...
             0,obj.SamplesPerFrame,fs,'centered');
             psd(:,i)=10*log10(abs(fftshift(P)));
         end
          I = permute(I,[3 1 4 2]);
          Q = permute(Q,[3 1 4 2]);
          psd=permute(psd,[3 1 4 2]);
          frames = cat(3,I,Q,psd);
      end
      
      labels = obj.Label(1:obj.NumFrames,:);
    end
    
    
   
  end
end

