function t= TransferTracks( FileNamesArray, EFileName, NumFrames)

if nargin<3 || isempty(NumFrames)
NumFrames =45;
end

WorkDirectory = char(pwd);

File= strcat(WorkDirectory,'/' , EFileName);

if exist(File,'file')
    delete(File)
end

% add poi_path

currentFolder = which('TransferTracks');
folder = currentFolder(1:length(currentFolder)- 16);

javaaddpath(strcat(folder, 'poi_library/poi-3.8-20120326.jar'));
javaaddpath(strcat(folder, 'poi_library/poi-ooxml-3.8-20120326.jar'));
javaaddpath(strcat(folder, 'poi_library/poi-ooxml-schemas-3.8-20120326.jar'));
javaaddpath(strcat(folder, 'poi_library/xmlbeans-2.3.0.jar'));
javaaddpath(strcat(folder, 'poi_library/dom4j-1.6.1.jar'));
javaaddpath(strcat(folder, 'poi_library/stax-api-1.0.1.jar'));


temp = 0;
for i=1: size(FileNamesArray)           % parcourt les fichiers
    
    load( FileNamesArray {i})

    Structure =  {char(FileNamesArray {i})};

    Tab = { 'ObjectNumber' , 'SpeedMean' ,  'Distance' ,  'SizeAverage' ,  'AngSpeedAVG' , 'TurningDistance' , 'SizeChange' , 'NumberOfFrames', 'Direction' };

    xlwrite ( EFileName, Structure, 'Summary', strcat('A' , num2str(1+temp)));
    xlwrite ( EFileName, {char(Tab{1})}, 'Summary', strcat('B' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{2})}, 'Summary', strcat('C' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{3})}, 'Summary', strcat('D' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{4})}, 'Summary', strcat('E' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{5})}, 'Summary', strcat('F' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{6})}, 'Summary', strcat('G' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{7})}, 'Summary', strcat('H' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{8})}, 'Summary', strcat('I' , num2str(2+temp)));
    xlwrite ( EFileName, {char(Tab{9})}, 'Summary', strcat('J' , num2str(2+temp)));

    for j=1 : size( Tracks,2)               % parcourt les Objects

        ObjectNum = strcat('Object',  num2str(j));                                                                      % ObjectID
        xlwrite ( EFileName, {char(ObjectNum)}, 'Summary', strcat('B' , num2str(2 + j + temp)));

        M = Tracks(j).Speed;                                                                                        % Speed
        xlwrite ( EFileName, mean(M(1:NumFrames)), 'Summary', strcat('C' , num2str(2 + j + temp)));
        xlwrite ( EFileName, trapz(M(1:NumFrames)),'Summary', strcat('D' , num2str(2 + j + temp)));


        N = Tracks(j).Size;                                                                                         % Size
        xlwrite ( EFileName, mean(N), 'Summary', strcat('E' , num2str(2 + j + temp)));


        P = Tracks(j).AngSpeed;                                                                                     % Angular Speed
        xlwrite ( EFileName, mean(P(1:NumFrames)), 'Summary', strcat('F' , num2str(2 + j + temp )));
        xlwrite ( EFileName, trapz(abs(P(1:NumFrames))),'Summary', strcat('G' , num2str(2 + j + temp)));

        O =Tracks(j).Size;

        xlwrite( EFileName, max(O(1:NumFrames))- min(O(1:NumFrames)), 'Summary', strcat('H' , num2str(2 + j + temp )));
        xlwrite ( EFileName, size(N(1:NumFrames),2) , 'Summary', strcat('I' , num2str(2 + j + temp )));

        DIRECT =Tracks(j).Direction;

        xlwrite( EFileName, max(O(1:NumFrames))- min(O(1:NumFrames)), 'Summary', strcat('J' , num2str(2 + j + temp )));
        xlwrite (EFileName, size(N(1:NumFrames),2) , 'Summary', strcat('J' , num2str(2 + j + temp )));

    end
 
    temp = temp + 4 + size (Tracks,2);
end

temp = 0;
for i=0: size(FileNamesArray)-1
    
    load( FileNamesArray {i+1})

    Structure =  {char(FileNamesArray {i+1})};

    xlwrite ( EFileName, Structure, 'SummarySpeed', strcat('A' , num2str(2+temp)));
    xlwrite ( EFileName, Structure, 'AngularSpeed', strcat('A' , num2str(2+temp)));
    xlwrite ( EFileName, Structure, 'ObjectSize', strcat('A' , num2str(2+temp)));
    xlwrite ( EFileName, Structure, 'Direction', strcat('A' , num2str(2+temp)));


    for j=1 : size( Tracks,2)

        M = Tracks(j).Speed;
        xlwrite ( EFileName, M,  'SummarySpeed', strcat('B' , num2str( (j-1) + 4 +temp)));
        xlwrite ( EFileName, trapz(M), 'SummarySpeed', strcat('A' , num2str( (j-1) + 4 +temp)));

    end

    for j=1 : size( Tracks,2)

        P = Tracks(j).AngSpeed; 
        xlwrite ( EFileName, P, 'AngularSpeed', strcat('A' , num2str( (j-1) + 4 +temp)));


    end

    for j=1 : size(Tracks,2)

        R = Tracks(j).Size; 
        xlwrite ( EFileName, R, 'ObjectSize', strcat('A' , num2str( (j-1) + 4 +temp)));

    end
    for j=1 : size(Tracks,2)

        DIRECT = Tracks(j).Direction; 
        xlwrite ( EFileName, DIRECT, 'Direction', strcat('A' , num2str( (j-1) + 4 +temp)));

    end
    temp = temp + 3 + size (Tracks,2);
end

