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

% Last Modified by GUIDE v2.5 25-Jan-2015 15:13:38

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
def = {'data\cars.txt'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
loaded_data=dataset('File',answer{1},'Delimiter',',','ReadVarNames',true);
%assignin('base','datacell',dataset2cell(loaded_data)); debug
data_cell=dataset2cell(loaded_data);
data_cell(1,:)=[];
set(handles.datatable,'data',data_cell);
set(handles.datatable,'ColumnName',loaded_data.Properties.VarNames);
set(handles.var1menu,'String',loaded_data.Properties.VarNames);
set(handles.var2menu,'String',loaded_data.Properties.VarNames);
set(handles.var3menu,'String',loaded_data.Properties.VarNames); %populacja list, które bêd¹ potem potrzebne
handles.maindb = loaded_data; %zmienna maindb bêdzie naszym datasetem
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





% --- Executes on button press in testbutton.
function testbutton_Callback(hObject, eventdata, handles)
%faza pierwsza
emptycnt=[];
for k = 1:(size(handles.maindb))(2)
    for l=1:(size(handles.maindb))(1)
        if isempty(handles.maindb{l,k})
            emptycnt(length(emptycnt)+1)=l;
        end
    end
    if ~isempty(emptycnt)
        choice = questdlg(strcat('Wykryto ',emptycnt,' pustych rekordów w kolumnie ',handles.maindb.Properties.VarNames(k),'. Co z nimi zrobiæ? '), ...
            'Faza 1', ...
            'Sta³a','Œrednia','Losowa wartoœæ','Losowa wartoœæ');
        switch choice
            case 'Sta³a'
                if isstr(handles.maindb{1,k})
                    for m=1:size(emptycnt)
                        handles.maindb{m,k} = 'missing';
                    end
                else
                    for m=1:size(emptycnt)
                        handles.maindb{m,k} = 0;
                    end
                end
            case 'Œrednia'
                if iscellstr(handles.maindb{1,k})
                    for m=1:size(emptycnt)
                        h = msgbox('Niedostêpne dla wartoœci nieliczbowych','Uwaga!');
                    end
                else
                    for m=1:size(emptycnt)
                        handles.maindb{m,k} = mean(handles.maindb.(handles.maindb.Properties.VarNames(k)));
                    end
                end
            case 'Losowa wartoœæ'
                if iscellstr(handles.maindb{1,k})
                    for m=1:size(emptycnt)
                        h = msgbox('Niedostêpne dla wartoœci nieliczbowych','Uwaga!'); %placeholder
                    end
                else
                    for m=1:size(emptycnt)
                        handles.maindb{m,k} = mean(handles.maindb.(handles.maindb.Properties.VarNames(k))); %placeholder
                    end
                end
        end
    end
    emptycnt = [];
end
%faza druga

    


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
    %main_str=strcat(tmp_str,'\n',tmp_max,char(13),tmp_min,'\n',tmp_q1,'\n',tmp_median,'\n',tmp_q3,'\n',tmp_mean);
    main_str=sprintf('%s \n Maksimum : %s \n Minimum : %s \n Pierwszy kwantyl: %s \n  Mediana : %s \n Trzeci kwantyl: %s \n Œrednia: %s \n',tmp_str,tmp_max,tmp_min,tmp_q1,tmp_median,tmp_q3,tmp_mean);
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
    %main_str=strcat(tmp_str,'\n',tmp_max,char(13),tmp_min,'\n',tmp_q1,'\n',tmp_median,'\n',tmp_q3,'\n',tmp_mean);
    main_str=sprintf('%s \n Maksimum : %s \n Minimum : %s \n Pierwszy kwantyl: %s \n  Mediana : %s \n Trzeci kwantyl: %s \n Œrednia: %s \n',tmp_str,tmp_max,tmp_min,tmp_q1,tmp_median,tmp_q3,tmp_mean);
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
    %main_str=strcat(tmp_str,'\n',tmp_max,char(13),tmp_min,'\n',tmp_q1,'\n',tmp_median,'\n',tmp_q3,'\n',tmp_mean);
    main_str=sprintf('%s \n Maksimum : %s \n Minimum : %s \n Pierwszy kwantyl: %s \n  Mediana : %s \n Trzeci kwantyl: %s \n Œrednia: %s \n',tmp_str,tmp_max,tmp_min,tmp_q1,tmp_median,tmp_q3,tmp_mean);
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
title(handles.maindb.Properties.VarNames{tmp_int});


% --- Executes on button press in scatter3button.
function scatter3button_Callback(hObject, eventdata, handles)
tmp_int = get(handles.var1menu,'Value');
tmp_int2 = get(handles.var2menu,'Value');
tmp_int3 = get(handles.var3menu,'Value');
figure(1);
scatter3(handles.maindb.(handles.maindb.Properties.VarNames{tmp_int}),handles.maindb.(handles.maindb.Properties.VarNames{tmp_int2}),handles.maindb.(handles.maindb.Properties.VarNames{tmp_int3}));
title(handles.maindb.Properties.VarNames{tmp_int});


% --- Executes on button press in tourbutton.
function tourbutton_Callback(hObject, eventdata, handles) % przeklejony kod, jeszcze nie powinien dzia³aæ (swoj¹ drog¹, wymaga chyba oczyszczenia z danych tesktowych)
data=double(stringColsPurger(handles.maindb));
[n,p] = size(data);
% Tworzymy wektor czêstoœci
N = 2*p - 3;
% U¿ywamy drugiej opcji.
lam = mod(exp(1:N),1);
% Ma³y irrational numer:
delt = exp(-5);
% Get the indices to build the rotations.
% As in step 1 of the torus method.
J = 2:p;
I = ones(1,length(J));
I = [I, 2*ones(1,length(J)-1)];
J = [J, 3:p];
E = eye(p,2); % Basis vectors
% Just do the tour for some number of iterations.
maxit = 2150;
z = zeros(n,2);
figure(1);
ph = plot(z(:,1),z(:,2),'o','erasemode','normal');
axis equal, axis off
% Use some Handle Graphics to remove flicker.
set(gcf,'backingstore','off','renderer',...
    'painters','DoubleBuffer','on')
% Start the tour.
for k = 1:maxit
    % Find the rotation matrix.
    Q = eye(p);
    for j = 1:N
        dum = eye(p);
        dum([I(j),J(j)],[I(j),J(j)]) = ...
            cos(lam(j)*k*delt);
        dum(I(j),J(j)) = -sin(lam(j)*k*delt);
        dum(J(j),I(j)) = sin(lam(j)*k*delt);
        Q = Q*dum;
    end
    % Rotate basis vectors.
    A = Q*E;
    % Project onto the new basis vectors.
    z = data*A;
    % Plot the transformed data.
    set(ph,'xdata',z(:,1),'ydata',z(:,2))
    % Forces Matlab to plot the data.
    pause(0.02)
end
