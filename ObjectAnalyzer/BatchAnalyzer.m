function BatchAnalyzer()

% This function extracts the major parameters for all tracks in a Tracks file. 

global Tracks;
global Current;

% Set up for processing
Current.BatchAnalysis = 1;        % Running in Batch Analysis Mode

% Analyze Tracks
NumTracks = length(Tracks);
for TN = 1:NumTracks
    Current.Analyzed = 0;
    Current.TempAnalyzed = 0;
    H = findobj('tag', 'SLIDER');
    set(H, 'Value', TN);
    
    TrackAnalysis;
end



x= load('defaultname.mat');


 FileName = [x.PathName, char(strcat(x.FileName(1: size(x.FileName,2)-4), 'a'))];


    save(FileName, 'Tracks');


Current.BatchAnalysis = 0;    % Return to Non-Batch Mode
