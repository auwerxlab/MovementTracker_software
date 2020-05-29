function varargout = MovementTracker(varargin)
% MovementTracker M-file for MovementTracker.fig
%      MovementTracker, by itself, creates a new MovementTracker or raises the existing
%      singleton*.
%
%      H = MovementTracker returns the handle to a new MovementTracker or the handle to
%      the existing singleton*.
%
%      MovementTracker('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MovementTracker.M with the given input arguments.
%
%      MovementTracker('Property','Value',...) creates a new MovementTracker or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MovementTracker_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MovementTracker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MovementTracker

% Last Modified by GUIDE v2.5 11-Feb-2008 14:12:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MovementTracker_OpeningFcn, ...
                   'gui_OutputFcn',  @MovementTracker_OutputFcn, ...
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



% --- Executes just before MovementTracker is made visible.
function MovementTracker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MovementTracker (see VARARGIN)

% Choose default command line output for MovementTracker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MovementTracker wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global MovementTrackerPrefs

% Get Tracker default Prefs from Excel file


 currentFolder = pwd;
 folder =mfilename('fullpath');
 folder = folder(1:length(folder)- 15);
  
  cd (folder)

ExcelFileName = 'Movement Tracker Preferences.xls';
WorkSheet = 'Tracker Prefs';
[N, T, D] = xlsread(ExcelFileName, WorkSheet);
MovementTrackerPrefs.MinObjectArea = N(1);
MovementTrackerPrefs.MaxObjectArea = N(2);
MovementTrackerPrefs.MaxDistance = N(3);
MovementTrackerPrefs.SizeChangeThreshold = N(4);
MovementTrackerPrefs.MinTrackLength = N(5);
MovementTrackerPrefs.AutoThreshold = N(6);
MovementTrackerPrefs.CorrectFactor = N(7);
MovementTrackerPrefs.ManualSetLevel = N(8);
MovementTrackerPrefs.DarkObjects = N(9);
MovementTrackerPrefs.PlotRGB = N(10);
MovementTrackerPrefs.PauseDuringPlot = N(11);
MovementTrackerPrefs.PlotObjectSizeHistogram = N(12);

  cd (currentFolder)



% --- Outputs from this function are returned to the command line.
function varargout = MovementTracker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% -------------------------------------------------------------------------
% 'Create Functions' for all Text Edit Fields................
% -------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function MOVIE_NAME_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_NAME_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function MOVIE_NAME_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_NAME_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_NAME_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_NAME_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_NAME_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_NAME_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_NAME_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_NAME_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_START_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_START_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_START_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_START_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_START_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_START_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_START_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_START_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_START_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_START_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_END_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_END_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_END_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_END_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_END_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_END_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_END_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_END_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function MOVIE_END_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOVIE_END_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function PLOT_FRAME_RATE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PLOT_FRAME_RATE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


