function varargout = eda(varargin)
% EDA MATLAB code for eda.fig
%      EDA, by itself, creates a new EDA or raises the existing
%      singleton*.
%
%      H = EDA returns the handle to a new EDA or the handle to
%      the existing singleton*.
%
%      EDA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDA.M with the given input arguments.
%
%      EDA('Property','Value',...) creates a new EDA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eda_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eda_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eda

% Last Modified by GUIDE v2.5 16-Jan-2015 15:19:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eda_OpeningFcn, ...
                   'gui_OutputFcn',  @eda_OutputFcn, ...
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


% --- Executes just before eda is made visible.
function eda_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eda (see VARARGIN)

% Choose default command line output for eda
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eda wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eda_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)
prompt = {'Podaj nazwe bazy do wczytania:'};
dlg_title = 'Wczytywanie danych';
num_lines = 1;
def = {'cars.mat'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
load cars;
guidata(hObject,handles)
cars.Properties.VarNames

set(handles.datatable,'data',dataset2cell(cars));
set(handles.datatable,'ColumnName',cars.Properties.VarNames);





% --- Executes on key press with focus on loadbutton and none of its controls.
function loadbutton_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in maindbmenu.
function maindbmenu_Callback(hObject, eventdata, handles)
% hObject    handle to maindbmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns maindbmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from maindbmenu



