function TrackObjects()

global MovementTrackerPrefs

PlotFrameRate = str2num(get(findobj('Tag', 'PLOT_FRAME_RATE'), 'String'));    
% Display tracking results every 'PlotFrameRate' frames - increase
% this value (in GUI) to get faster tracking performance


% Get movies to track
% -------------------
MovieNames = {};
for i = 1:5
    Mname = eval(['get(findobj(''Tag'', ''MOVIE_NAME_' num2str(i) '''), ''String'')']);
    Mstart = eval(['get(findobj(''Tag'', ''MOVIE_START_' num2str(i) '''), ''String'')']);
    Mend = eval(['get(findobj(''Tag'', ''MOVIE_END_' num2str(i) '''), ''String'')']);
    
    
    Mname;
    Mname1 = strcat(Mname, '*');
    filename = dir (strcat(Mname1,'.*'));

    

[~, ~, ext] = fileparts(filename(1).name);

if length(ext) >2
save extension ext;

end

    if ~isempty(Mname)
        

        if ~isempty(Mstart) && ~isempty(Mend)
            for j = str2num(Mstart):str2num(Mend)
                MovieNames{length(MovieNames)+1} = [Mname num2str(j) char(ext)];
            end
        else
            MovieNames{length(MovieNames)+1} = [Mname char(ext)];

        end
           
    end
end


% Setup figure for plotting tracker results
% -----------------------------------------
WTFigH = findobj('Tag', 'WTFIG');
if isempty(WTFigH)
    WTFigH = figure('Name', 'Tracking Results', ...
        'NumberTitle', 'off', ...
        'Tag', 'WTFIG');
else
    figure(WTFigH);
end


% Start Tracker
% -------------
for MN = 1:length(MovieNames)
    
    
    Object = VideoReader(MovieNames{MN});  
    NumFrames = Object.NumberOfFrames;     
    vidHeight = Object.Height;
    vidWidth = Object.Width;
    
    
    
    mov(1:NumFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
    
    
    Tracks = [];
    
    % Analyze Movie
    % -------------
    for Frame = 1:NumFrames    

          Mov(Frame).colormap = [];
          Mov(Frame).cdata = read(Object, Frame);   
   
           
    
        % Convert frame to a binary image 
        if MovementTrackerPrefs.AutoThreshold       % use auto thresholding
            Level = graythresh(Mov(Frame).cdata) + MovementTrackerPrefs.CorrectFactor;
            Level = max(min(Level,1) ,0);
        else
            Level = MovementTrackerPrefs.ManualSetLevel;
        end
        if MovementTrackerPrefs.DarkObjects
            BW = ~im2bw(Mov(Frame).cdata, Level);  % For tracking dark objects on a bright background
        else
            BW = im2bw(Mov(Frame).cdata, Level);  % For tracking bright objects on a dark background
        end
        
        % Identify all objects
        [L,NUM] = bwlabel(BW);
        STATS = regionprops(L, {'Area', 'Centroid', 'FilledArea', 'Eccentricity'});
        
        % Identify all Objects by size, get their centroid coordinates
        ObjectIndices = find([STATS.Area] > MovementTrackerPrefs.MinObjectArea & ...
            [STATS.Area] < MovementTrackerPrefs.MaxObjectArea);
        NumObjects = length(ObjectIndices);
        ObjectCentroids = [STATS(ObjectIndices).Centroid];
        ObjectCoordinates = [ObjectCentroids(1:2:2*NumObjects)', ObjectCentroids(2:2:2*NumObjects)'];
        ObjectSizes = [STATS(ObjectIndices).Area];
        ObjectFilledAreas = [STATS(ObjectIndices).FilledArea];
        ObjectEccentricities = [STATS(ObjectIndices).Eccentricity];
        
        % Track Objects 
        % ----------- 
        if ~isempty(Tracks)
            ActiveTracks = find([Tracks.Active]);
        else
            ActiveTracks = [];
        end
        
        % Update active tracks with new coordinates
        for i = 1:length(ActiveTracks)
            DistanceX = ObjectCoordinates(:,1) - Tracks(ActiveTracks(i)).LastCoordinates(1);
            DistanceY = ObjectCoordinates(:,2) - Tracks(ActiveTracks(i)).LastCoordinates(2);
            Distance = sqrt(DistanceX.^2 + DistanceY.^2);
            [MinVal, MinIndex] = min(Distance);
            if (MinVal <= MovementTrackerPrefs.MaxDistance) & ...
                    (abs(ObjectSizes(MinIndex) - Tracks(ActiveTracks(i)).LastSize) < MovementTrackerPrefs.SizeChangeThreshold)
                Tracks(ActiveTracks(i)).Path = [Tracks(ActiveTracks(i)).Path; ObjectCoordinates(MinIndex, :)];
                Tracks(ActiveTracks(i)).LastCoordinates = ObjectCoordinates(MinIndex, :);
                Tracks(ActiveTracks(i)).Frames = [Tracks(ActiveTracks(i)).Frames, Frame];
                Tracks(ActiveTracks(i)).Size = [Tracks(ActiveTracks(i)).Size, ObjectSizes(MinIndex)];
                Tracks(ActiveTracks(i)).LastSize = ObjectSizes(MinIndex);
                Tracks(ActiveTracks(i)).FilledArea = [Tracks(ActiveTracks(i)).FilledArea, ObjectFilledAreas(MinIndex)];
                Tracks(ActiveTracks(i)).Eccentricity = [Tracks(ActiveTracks(i)).Eccentricity, ObjectEccentricities(MinIndex)];
                ObjectCoordinates(MinIndex,:) = [];
                ObjectSizes(MinIndex) = [];
                ObjectFilledAreas(MinIndex) = [];
                ObjectEccentricities(MinIndex) = [];
            else
                Tracks(ActiveTracks(i)).Active = 0;
                if length(Tracks(ActiveTracks(i)).Frames) < MovementTrackerPrefs.MinTrackLength
                    Tracks(ActiveTracks(i)) = [];
                    ActiveTracks = ActiveTracks - 1;
                end
            end
        end
        
        % Start new tracks for coordinates not assigned to existing tracks
        NumTracks = length(Tracks);
        for i = 1:length(ObjectCoordinates(:,1))
            Index = NumTracks + i;
            Tracks(Index).Active = 1;
            Tracks(Index).Path = ObjectCoordinates(i,:);
            Tracks(Index).LastCoordinates = ObjectCoordinates(i,:);
            Tracks(Index).Frames = Frame;
            Tracks(Index).Size = ObjectSizes(i);
            Tracks(Index).LastSize = ObjectSizes(i);
            Tracks(Index).FilledArea = ObjectFilledAreas(i);
            Tracks(Index).Eccentricity = ObjectEccentricities(i);
        end
        
        % Display every PlotFrameRate'th frame
        if ~mod(Frame, PlotFrameRate)
            PlotFrame(WTFigH, Mov(Frame), Tracks);
            FigureName = ['Tracking Results for Frame ', num2str(Frame)];
            set(WTFigH, 'Name', FigureName);

            if MovementTrackerPrefs.PlotRGB
                RGB = label2rgb(L, @jet, 'k');
                figure(6)
                set(6, 'Name', FigureName);
                imshow(RGB);
                hold on
                if ~isempty(Tracks)
                    ActiveTracks = find([Tracks.Active]);
                else
                    ActiveTracks = [];
                end
                for i = 1:length(ActiveTracks)
                    plot(Tracks(ActiveTracks(i)).LastCoordinates(1), ...
                        Tracks(ActiveTracks(i)).LastCoordinates(2), 'wo');
                end
                hold off
            end
            
            if MovementTrackerPrefs.PlotObjectSizeHistogram
                figure(7)
                hist([STATS.Area],300)
                set(7, 'Name', FigureName);
                title('Histogram of Object Sizes Identified by Tracker')
                xlabel('Object Size (pixels')
                ylabel('Number of Occurrences')
            end

            if MovementTrackerPrefs.PauseDuringPlot
            	pause;
            end
        end
        
    end    % END for Frame = 1:FileInfo.NumFrames
    
    % Get rid of invalid tracks
    DeleteTracks = [];
    for i = 1:length(Tracks)
        if length(Tracks(i).Frames) < MovementTrackerPrefs.MinTrackLength
            DeleteTracks = [DeleteTracks, i];
        end
    end
    Tracks(DeleteTracks) = [];
    
    % Save Tracks
    SaveFileName = [MovieNames{MN}(1:length(MovieNames{MN})-4) '.mat'];
    save(SaveFileName, 'Tracks');
    
end    % END for i = 1:FileNameSize(1)