function SelectTrack

% This function loads the parameters of the track selected by the user
% (using the track slider) into struct Track and displays the selected
% track. 
% This function is the callback for the slider object with tag SLIDER

global Tracks;
global Prefs;
global Current;

% Get and display the selected track no.
H = findobj('tag', 'SLIDER');
TN = round(get(H, 'Value'));


H = findobj('tag', 'SLIDERTITLE');
String = ['Track No.', num2str(TN)];
set(H, 'string', String);

% Initialize Current Track State
Current.Analyzed = 0;
Current.TempAnalyzed = 0;
Current.PlayFrame = 1;
Current.PlayState = 0;
Current.BatchAnalysis = 0;

% Display selected track
hold off;
if Tracks(TN).Frames(1) <= Prefs.FirstMovieLen
     Object1 = VideoReader(Prefs.MovieName(1,:));
     nFrames = Object1.NumberOfFrames;
     vidHeight = Object1.Height;
     vidWidth = Object1.Width;
        
        
     Mov.colormap = [];
     Mov.cdata= read(Object1,Tracks(TN).Frames(1));


else
    Object2 = VideoReader(Prefs.MovieName(2,:));
    nFrames = Object2.NumberOfFrames;
    vidHeight = Object2.Height;
    vidWidth = Object2.Width;
        
        
    Mov.colormap = [];
    Mov.cdata= read(Object2, Tracks(TN).Frames(Current.PlayFrame)-Prefs.FirstMovieLen);
    
end
imshow(Mov.cdata, Mov.colormap);
hold on;
plot(Tracks(TN).Path(:,1), Tracks(TN).Path(:,2),  'r');
plot(Tracks(TN).Path(1,1), Tracks(TN).Path(1,2),  'b+');

% Update frame number & elapsed time
H = findobj('tag', 'FRAMENUM');
set(H, 'String', num2str(Tracks(TN).Frames(1)));
H = findobj('tag', 'TIMEELAPSED');
set(H, 'String', num2str(round(Tracks(TN).Frames(1)/Prefs.SampleRate)));



