function SaveResults()

global Tracks;


x= load('defaultname.mat');


 FileName = [x.PathName, char(strcat(x.FileName(1: size(x.FileName,2)-4), 'a'))];


    save(FileName, 'Tracks');
    
    
end



