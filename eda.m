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

% Last Modified by GUIDE v2.5 29-Jan-2015 22:48:46

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
imshow('agh.jpg', 'Parent', handles.axes1)

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
prompt = [{'Podaj nazwe bazy do wczytania:'} {'Podaj delimiter:'} {'Czy pierwszy wiersz to tytu³y kolumn?'}];
dlg_title = 'Wczytywanie danych';
num_lines = [1 1 1]';
def = [{'data\cars.txt'} {','} {'tak'}];
answer = inputdlg(prompt,dlg_title,num_lines,def);
%assignin('base','answer',answer);
loaded_data=dataset('File',answer{1},'Delimiter',answer{2},'ReadVarNames',strcmp('tak',answer{3}));
[m n]=size(loaded_data);
data=dataset();
for k = 1:n;
    data.(k)=absenceOfEmptiness(loaded_data.(loaded_data.Properties.VarNames{k}),loaded_data.Properties.VarNames{k});
end
data.Properties.VarNames=loaded_data.Properties.VarNames;
%assignin('base','datacell',dataset2cell(loaded_data)); debug
data_cell=dataset2cell(data);
data_cell(1,:)=[];
set(handles.datatable,'data',data_cell);
set(handles.datatable,'ColumnName',data.Properties.VarNames);
set(handles.var1menu,'String',data.Properties.VarNames);
set(handles.var2menu,'String',data.Properties.VarNames);
set(handles.var3menu,'String',data.Properties.VarNames); %populacja list, które bêd¹ potem potrzebne
handles.maindb = data; %zmienna maindb bêdzie naszym datasetem
guidata(hObject, handles); %odœwie¿amy handle






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





    


% --- Executes on selection change in var1menu.
function var1menu_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
if isstr(handles.maindb{1,tmp_int})
    tmp_str='Typ: dane jakoœciowe';
    main_str=tmp_str;
    set(handles.text1,'String',main_str);
else
    tmp_str='Typ: dane liczbowe';
    tmp_max=num2str(max(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_min=num2str(min(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_q1=num2str(quantile(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),.25));
    tmp_median=num2str(median(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_q3=num2str(quantile(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),.75));
    tmp_mean=num2str(mean(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_std=num2str(std(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    main_str=sprintf('%s \n Maksimum : %s \n Minimum : %s \n Pierwszy kwantyl: %s \n  Mediana : %s \n Trzeci kwantyl: %s \n Œrednia: %s \n Odch. stand: %s \n',tmp_str,tmp_max,tmp_min,tmp_q1,tmp_median,tmp_q3,tmp_mean,tmp_std);
    set(handles.text1,'String',main_str); 
end


% --- Executes during object creation, after setting all properties.
function var1menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var1menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in var2menu.
function var2menu_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var2menu,'Value')
if isstr(handles.maindb{1,tmp_int})
    tmp_str='Typ: dane jakoœciowe';
    main_str=tmp_str;
    set(handles.text2,'String',main_str);
else
    tmp_str='Typ: dane liczbowe';
    tmp_max=num2str(max(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_min=num2str(min(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_q1=num2str(quantile(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),.25));
    tmp_median=num2str(median(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_q3=num2str(quantile(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),.75));
    tmp_mean=num2str(mean(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_std=num2str(std(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
     main_str=sprintf('%s \n Maksimum : %s \n Minimum : %s \n Pierwszy kwantyl: %s \n  Mediana : %s \n Trzeci kwantyl: %s \n Œrednia: %s \n Odch. stand: %s \n',tmp_str,tmp_max,tmp_min,tmp_q1,tmp_median,tmp_q3,tmp_mean,tmp_std);
    set(handles.text2,'String',main_str); 
end



% --- Executes during object creation, after setting all properties.
function var2menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var2menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in var3menu.
function var3menu_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var3menu,'Value')
if isstr(handles.maindb{1,tmp_int})
    tmp_str='Typ: dane jakoœciowe';
    main_str=tmp_str;
    set(handles.text3,'String',main_str);
else
    tmp_str='Typ: dane liczbowe';
    tmp_max=num2str(max(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_min=num2str(min(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_q1=num2str(quantile(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),.25));
    tmp_median=num2str(median(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_q3=num2str(quantile(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),.75));
    tmp_mean=num2str(mean(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    tmp_std=num2str(std(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int})));
    main_str=sprintf('%s \n Maksimum : %s \n Minimum : %s \n Pierwszy kwantyl: %s \n  Mediana : %s \n Trzeci kwantyl: %s \n Œrednia: %s \n Odch. stand: %s \n',tmp_str,tmp_max,tmp_min,tmp_q1,tmp_median,tmp_q3,tmp_mean,tmp_std);
    set(handles.text3,'String',main_str); 
end



% --- Executes during object creation, after setting all properties.
function var3menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var3menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in histbutton.
function histbutton_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
figure(1);
hist(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
title(handles.maindb.Properties.VarNames{tmp_int});



% --- Executes on button press in standbutton.
function standbutton_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
tmp_mean=mean(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
tmp_std=std(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
tmp_size=size(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
database=handles.maindb;
for l=1:tmp_size
    database{l,tmp_int}=((database{l,tmp_int}-tmp_mean)/(tmp_std)); 
end
handles.maindb=database;
data_cell=dataset2cell(database);
data_cell(1,:)=[];
set(handles.datatable,'data',data_cell);
guidata(hObject, handles);


% --- Executes on button press in normbutton.
function normbutton_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
tmp_min=min(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
tmp_max=max(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
tmp_size=size(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}));
database=handles.maindb;
for l=1:tmp_size
    database{l,tmp_int}=((database{l,tmp_int}-tmp_min)/(tmp_max-tmp_min)); 
end
handles.maindb=database;
data_cell=dataset2cell(database);
data_cell(1,:)=[];
set(handles.datatable,'data',data_cell);
guidata(hObject, handles);




% --- Executes on button press in scatterbutton.
function scatterbutton_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
tmp_int2 = get(handles.var2menu,'Value');
figure(1);
scatter(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),handles.maindb.(handles.maindb.Properties.VarNames{tmp_int2}));
xlabel(handles.maindb.Properties.VarNames{tmp_int});
ylabel(handles.maindb.Properties.VarNames{tmp_int2});


% --- Executes on button press in scatter3button.
function scatter3button_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
tmp_int2 = get(handles.var2menu,'Value');
tmp_int3 = get(handles.var3menu,'Value');
figure(1);
scatter3(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),handles.maindb.(handles.maindb.Properties.VarNames{tmp_int2}),handles.maindb.(handles.maindb.Properties.VarNames{tmp_int3}));
xlabel(handles.maindb.Properties.VarNames{tmp_int});
ylabel(handles.maindb.Properties.VarNames{tmp_int2});
zlabel(handles.maindb.Properties.VarNames{tmp_int3});


% --- Executes on button press in tourbutton.
function tourbutton_Callback(hObject, eventdata, handles) 
data=double(stringColsPurger(handles.maindb));
[n,p] = size(data);
% Tworzymy wektor czêstoœci
N = 2*p - 3;
% U¿ywamy drugiej opcji (w tej metodzie s¹ dwie, ¿eby otrzymaæ ma³y numer niewymierny, pierwsza to pierwiastek).
lam = mod(exp(1:N),1);
% Ma³y niewymierny numer:
delt = exp(-5);
% Zdobywanie indeksów w celu stworzenia rotacji.
%Krok 1 metody torusa.
J = 2:p;
I = ones(1,length(J));
I = [I, 2*ones(1,length(J)-1)];
J = [J, 3:p];
E = eye(p,2); % Wektory podstawy
% Robi tour dla pewnej liczby iteracji.
maxit = 2150;
z = zeros(n,2);
figure(1);
ph = plot(z(:,1),z(:,2),'o','erasemode','normal');
axis equal, axis off
% Takie ustawienie zredukuje migotanie.
set(gcf,'backingstore','off','renderer',...
    'painters','DoubleBuffer','on')
% Rozpoczêcie trasy.
for k = 1:maxit
    % Szukanie macierzy rotacji.
    Q = eye(p);
    for j = 1:N
        dum = eye(p);
        dum([I(j),J(j)],[I(j),J(j)]) = ...
            cos(lam(j)*k*delt);
        dum(I(j),J(j)) = -sin(lam(j)*k*delt);
        dum(J(j),I(j)) = sin(lam(j)*k*delt);
        Q = Q*dum;
    end
    % Rotacja wektorów podstawy.
    A = Q*E;
    % Projekcja na nowe wektory podstawy.
    z = data*A;
    % Wykres przetransformowanych danych.
    set(ph,'xdata',z(:,1),'ydata',z(:,2))
    % Wymusza rysowanie danych przez MATLABa.
    pause(0.02)
end






% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
