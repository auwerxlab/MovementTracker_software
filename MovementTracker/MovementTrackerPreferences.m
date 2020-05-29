function varargout = MovementTrackerPreferences(varargin)
% MovementTrackerPREFERENCES M-file for MovementTrackerPreferences.fig
%      MovementTrackerPREFERENCES, by itself, creates a new MovementTrackerPREFERENCES or raises the existing
%      singleton*.
%
%      H = MovementTrackerPREFERENCES returns the handle to a new MovementTrackerPREFERENCES or the handle to
%      the existing singleton*.
%
%      MovementTrackerPREFERENCES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MovementTrackerPREFERENCES.M with the given input arguments.
%
%      MovementTrackerPREFERENCES('Property','Value',...) creates a new MovementTrackerPREFERENCES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MovementTrackerPreferences_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MovementTrackerPreferences_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MovementTrackerPreferences

% Last Modified by GUIDE v2.5 11-Feb-2008 17:05:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MovementTrackerPreferences_OpeningFcn, ...
                   'gui_OutputFcn',  @MovementTrackerPreferences_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MovementTrackerPreferences is made visible.
function MovementTrackerPreferences_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MovementTrackerPreferences (see VARARGIN)

% Choose default command line output for MovementTrackerPreferences
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MovementTrackerPreferences wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global MovementTrackerPrefs

set(findobj('Tag', 'MIN_OBJECT_AREA'), 'String', num2str(MovementTrackerPrefs.MinObjectArea))
set(findobj('Tag', 'MAX_OBJECT_AREA'), 'String', num2str(MovementTrackerPrefs.MaxObjectArea))
set(findobj('Tag', 'MAX_DISTANCE'), 'String', num2str(MovementTrackerPrefs.MaxDistance))
set(findobj('Tag', 'MAX_SIZE_CHANGE'), 'String', num2str(MovementTrackerPrefs.SizeChangeThreshold))
set(findobj('Tag', 'MIN_TRACK_LENGTH'), 'String', num2str(MovementTrackerPrefs.MinTrackLength))

set(findobj('Tag', 'USE_AUTO_THRESH'), 'Value', MovementTrackerPrefs.AutoThreshold)
set(findobj('Tag', 'CORRECT_FACTOR'), 'String', num2str(MovementTrackerPrefs.CorrectFactor))
set(findobj('Tag', 'MANUAL_LEVEL'), 'String', num2str(MovementTrackerPrefs.ManualSetLevel))
set(findobj('Tag', 'DARK_OBJECTS_WHITE_BKGD'), 'Value', MovementTrackerPrefs.DarkObjects)
set(findobj('Tag', 'WHITE_OBJECTS_DARK_BKGD'), 'Value', ~MovementTrackerPrefs.DarkObjects)
USE_AUTO_THRESH_Callback(hObject, eventdata, handles);

set(findobj('Tag', 'PLOT_RGB'), 'Value', MovementTrackerPrefs.PlotRGB)
set(findobj('Tag', 'PAUSE_TRACKER'), 'Value', MovementTrackerPrefs.PauseDuringPlot)
set(findobj('Tag', 'PLOT_AREA_HIST'), 'Value', MovementTrackerPrefs.PlotObjectSizeHistogram)




% --- Outputs from this function are returned to the command line.
function varargout = MovementTrackerPreferences_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in USE_AUTO_THRESH.
function USE_AUTO_THRESH_Callback(hObject, eventdata, handles)
% hObject    handle to USE_AUTO_THRESH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of USE_AUTO_THRESH

if get(findobj('Tag', 'USE_AUTO_THRESH'), 'Value')
    set(findobj('Tag', 'CORRECT_FACTOR_TEXT'), 'Enable', 'On')
    set(findobj('Tag', 'CORRECT_FACTOR'), 'Enable', 'On')
    set(findobj('Tag', 'MANUAL_LEVEL_TEXT'), 'Enable', 'Off')
    set(findobj('Tag', 'MANUAL_LEVEL'), 'Enable', 'Off')
else
    set(findobj('Tag', 'CORRECT_FACTOR_TEXT'), 'Enable', 'Off')
    set(findobj('Tag', 'CORRECT_FACTOR'), 'Enable', 'Off')
    set(findobj('Tag', 'MANUAL_LEVEL_TEXT'), 'Enable', 'On')
    set(findobj('Tag', 'MANUAL_LEVEL'), 'Enable', 'On')
end    
    



% --- Executes on button press in OK_TRACKER_PREFS.
function OK_TRACKER_PREFS_Callback(hObject, eventdata, handles)
% hObject    handle to OK_TRACKER_PREFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ApplyPrefsChanges;
closereq;



% --- Executes on button press in SAVE_TRACKER_PREFS.
function SAVE_TRACKER_PREFS_Callback(hObject, eventdata, handles)
% hObject    handle to SAVE_TRACKER_PREFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global MovementTrackerPrefs

ApplyPrefsChanges;



if (ispc)
    
currentFolder = pwd;
WorkSheet = 'Tracker Prefs';
SaveData = struct2cell(MovementTrackerPrefs);    

folder =mfilename('fullpath');
folder = folder(1:length(folder)- 26);
  
 cd (folder)

xlswrite('Movement Tracker Preferences.xls', SaveData, WorkSheet, 'B1:B12');

  cd(currentFolder)


elseif (isunix)
  
  currentFolder = pwd;
  WorkSheet = 'Tracker Prefs';
  SaveData = struct2cell(MovementTrackerPrefs);  

  
  folder =mfilename('fullpath');
  folder = folder(1:length(folder)- 26);
  
  cd (folder)
  
javaaddpath('poi_library/poi-3.8-20120326.jar');
javaaddpath('poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('poi_library/xmlbeans-2.3.0.jar');
javaaddpath('poi_library/dom4j-1.6.1.jar');
javaaddpath('poi_library/stax-api-1.0.1.jar');
  
 
  xlwrite( 'Movement Tracker Preferences.xls', SaveData, WorkSheet, 'B1:B12');

   cd(currentFolder)

  
end
function ApplyPrefsChanges
% This function runs when OK or Save Tracker Prefs is selected, and updates
% MovementTrackerPrefs to reflect any changes made by the user

global MovementTrackerPrefs

MovementTrackerPrefs.MinObjectArea = str2num(get(findobj('Tag', 'MIN_OBJECT_AREA'), 'String'));
MovementTrackerPrefs.MaxObjectArea = str2num(get(findobj('Tag', 'MAX_OBJECT_AREA'), 'String'));
MovementTrackerPrefs.MaxDistance = str2num(get(findobj('Tag', 'MAX_DISTANCE'), 'String'));
MovementTrackerPrefs.SizeChangeThreshold = str2num(get(findobj('Tag', 'MAX_SIZE_CHANGE'), 'String'));
MovementTrackerPrefs.MinTrackLength = str2num(get(findobj('Tag', 'MIN_TRACK_LENGTH'), 'String'));

MovementTrackerPrefs.AutoThreshold = get(findobj('Tag', 'USE_AUTO_THRESH'), 'Value');
MovementTrackerPrefs.CorrectFactor = str2num(get(findobj('Tag', 'CORRECT_FACTOR'), 'String'));
MovementTrackerPrefs.ManualSetLevel = str2num(get(findobj('Tag', 'MANUAL_LEVEL'), 'String'));
MovementTrackerPrefs.DarkObjects = get(findobj('Tag', 'DARK_OBJECTS_WHITE_BKGD'), 'Value');

MovementTrackerPrefs.PlotRGB = get(findobj('Tag', 'PLOT_RGB'), 'Value');
MovementTrackerPrefs.PauseDuringPlot = get(findobj('Tag', 'PAUSE_TRACKER'), 'Value');
MovementTrackerPrefs.PlotObjectSizeHistogram = get(findobj('Tag', 'PLOT_AREA_HIST'), 'Value');





% -------------------------------------------------------------------------
% 'Create Functions' for all Text Edit Fields................
% -------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function MIN_OBJECT_AREA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MIN_OBJECT_AREA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MAX_OBJECT_AREA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MAX_OBJECT_AREA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MAX_DISTANCE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MAX_DISTANCE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MAX_SIZE_CHANGE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MAX_SIZE_CHANGE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MIN_TRACK_LENGTH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MIN_TRACK_LENGTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function CORRECT_FACTOR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CORRECT_FACTOR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function MANUAL_LEVEL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MANUAL_LEVEL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
