function EndTrack()

global Tracks;
global Prefs;
global Current;

% Get current track no.
H = findobj('tag', 'SLIDER');
TN = round(get(H, 'Value'));

StopTrack;
Current.PlayFrame = length(Tracks(TN).Frames);

figure(Prefs.FigH);

if Current.Analyzed
    if Tracks(TN).Frames(Current.PlayFrame) <= Prefs.FirstMovieLen
        
        Object1 = VideoReader(Prefs.MovieName(1,:));
        nFrames = Object1.NumberOfFrames;
        vidHeight = Object1.Height;
        vidWidth = Object1.Width;
        
        Mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
        
        Mov.colormap = [];
        Mov.cdata= read(Object1,Tracks(TN).Frames(Current.PlayFrame));
   
    else
        Object2 = VideoReader(Prefs.MovieName(2,:));
        nFrames = Object2.NumberOfFrames;
        vidHeight = Object2.Height;
        vidWidth = Object2.Width;
        
        
        Mov.colormap = [];
        Mov.cdata= read(Object2,  Tracks(TN).Frames(Current.PlayFrame)-Prefs.FirstMovieLen);
    
    
    end
    imshow(Mov.cdata, Mov.colormap);
    hold on;
    plot(Tracks(TN).SmoothX, Tracks(TN).SmoothY,  'r');
    p = size(Tracks(TN).Pirouettes);
    for n = 1:p(1)
        PIndex = [Tracks(TN).Pirouettes(n,1):Tracks(TN).Pirouettes(n,2)];
        plot(Tracks(TN).SmoothX(PIndex), Tracks(TN).SmoothY(PIndex), 'g');
    end  
    plot(Tracks(TN).SmoothX(Current.PlayFrame), Tracks(TN).SmoothY(Current.PlayFrame), 'b+');
    hold off;
else
    if Tracks(TN).Frames(Current.PlayFrame) <= Prefs.FirstMovieLen
        Object1 = VideoReader(Prefs.MovieName(1,:));
        nFrames = Object1.NumberOfFrames;
        vidHeight = Object1.Height;
        vidWidth = Object1.Width;
        
        
        Mov.colormap = [];
        Mov.cdata= read(Object1,Tracks(TN).Frames(Current.PlayFrame));
    
    
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
    plot(Tracks(TN).Path(Current.PlayFrame,1), Tracks(TN).Path(Current.PlayFrame,2), 'b+');
    hold off;
end

H = findobj('tag', 'FRAMENUM');
set(H, 'String', num2str(Tracks(TN).Frames(Current.PlayFrame)));
H = findobj('tag', 'TIMEELAPSED');
set(H, 'String', num2str(round(Tracks(TN).Frames(Current.PlayFrame)/Prefs.SampleRate)));
