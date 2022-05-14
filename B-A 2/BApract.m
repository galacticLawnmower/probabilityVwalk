function varargout = BApract(varargin)
% BAPRACT MATLAB code for BApract.fig
%      BAPRACT, by itself, creates a new BAPRACT or raises the existing
%      singleton*.
%
%      H = BAPRACT returns the handle to a new BAPRACT or the handle to
%      the existing singleton*.
%
%      BAPRACT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BAPRACT.M with the given input arguments.
%
%      BAPRACT('Property','Value',...) creates a new BAPRACT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BApract_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BApract_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BApract

% Last Modified by GUIDE v2.5 14-May-2022 10:08:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BApract_OpeningFcn, ...
                   'gui_OutputFcn',  @BApract_OutputFcn, ...
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


% --- Executes just before BApract is made visible.
function BApract_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BApract (see VARARGIN)

% Choose default command line output for BApract
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.ms, 'String', 30);
set(handles.s, 'String', 15);
set(handles.e, 'String', 3);
set(handles.it, 'String', 1.3);
set(handles.deg, 'String', 3);
set(handles.size, 'String', 6);
set(handles.BaC, 'value', 1);
set(handles.size, 'enable', 'off')
set(handles.deg, 'enable', 'off')




% UIWAIT makes BApract wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BApract_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N= str2double(get(handles.it, 'String'))
netW = str2double(get(handles.ms, 'String'))
sta = str2double(get(handles.s, 'String'))
en = str2double(get(handles.e, 'String'))
BA_C = get(handles.BaC, 'value');
TR_C = get(handles.TrC, 'value');
LA_C = get(handles.LaC, 'value');


if BA_C == 1 && (TR_C+LA_C == 0)
qz = (N-1)*25;

wg = BA_G(N,netW,sta,en);
mu_time = BA(wg,sta,en,25+qz);
y = mu_time;

for i =1:25+qz
    m(i) = i/25;
end
x = m;
axes(handles.axes1)
L1 = plot(x,y)
title('gamma vs arrival time')
xlabel('gamma')
ylabel('arrival time')

[M,I] = min(y);
gi = double(x(I))
set(handles.mgam, 'String', gi);
ti = double(y(I))
set(handles.mti, 'String', ti);
mm = x(i)
set(handles.maxG, 'String', mm);

PaGraph = PA_G(wg,sta,en,25);
y = PaGraph
for i =1:25
    mb(i) = i;
end
x = mb;
axes(handles.axes5)
L1 = plot(x,y,'-')
title('walk length vs probability')
xlabel('walk length')
ylabel('probability')

        hold on
fd = diff(y,1)./diff(x,1);
%fd = gradient(y(:)) ./ gradient(x(:))
%plot(x(2:end),fd,'-')
plot(fd)
sd = diff(y,2)./diff(x,2);
%sd = gradient(fd(:)) ./ gradient(x(:))
%plot(x(2:end),sd,'-')
plot(sd)
hold off

t = handles.uitable1;
set(t,'Data',y');
set(t,'ColumnName',{'P data'})

t = handles.uitable2;
set(t,'Data',fd');
set(t,'ColumnName',{'P'' data'})

t = handles.uitable3;
set(t,'Data',sd');
set(t,'ColumnName',{'P'''' data'})


'cat'
for i =1:netW
    for j =1:netW
        if wg(i,j) ~= 0
            adjT(i,j) =1
        end
    end
end
axes(handles.axes7)
CNet(adjT)
end

if TR_C == 1 && (BA_C+LA_C == 0)
    'cat'
    %gamma
    N= str2double(get(handles.it, 'String'))
    qz = (N-1)*25;
    netW = str2double(get(handles.ms, 'String'))
    sta = str2double(get(handles.s, 'String'))
    en = str2double(get(handles.e, 'String'))
    
    netW = str2double(get(handles.ms, 'String'))
    deg = str2double(get(handles.deg,'String'))
    sizeT = str2double(get(handles.size,'String'))
    set(handles.text10, 'String', 'tree size');


    i= 1 + deg
    m =deg;
    for j = 1:sizeT-1
        m = m*(deg-1);
        i = i+m
    end
    i
    vec = zeros(i);
    for j=1:deg
        vec(1,1+j)=1;
        vec(1+j,1) =1;
    end
    for j=1:i;
        for k=0:(deg-2)
           
            'cat'
            if 2+(deg)+(j-1)*(deg-1) +k <= i
                2+(deg)+(j-1)*(deg-1) +k
                j+1
                vec(2+(deg)+(j-1)*(deg-1)+k,j+1) =1;
                vec(j+1,2+(deg)+(j-1)*(deg-1)+k)=1;
            end
        end
            
    end
    dr = i
    m3 = vec;
    for i =1:dr
        tsum = sum(vec(i,:));
        for j = 1:dr
          m3(i,j) = vec(i,j)/tsum;
        end
    end
    mu_time = BA(m3,sta,en,25+qz);
    y = mu_time;
    for i =1:25+qz
        m(i) = i/25;
    end
    x = m;
    axes(handles.axes1)
    L1 = plot(x,y)
    title('gamma vs arrival time')
    xlabel('gamma')
    ylabel('arrival time')
    
    [M,I] = min(y);
gi = double(x(I))
set(handles.mgam, 'String', gi);
ti = double(y(I))
set(handles.mti, 'String', ti);
mm = x(i)
set(handles.maxG, 'String', mm);
    
    PaGraph = PA_G(m3,sta,en,25);
    y = PaGraph
    for i =1:25
        mb(i) = i;
    end
    x = mb;
    axes(handles.axes5)
    L1 = plot(x,y,'-')
    title('walk length vs probability')
    xlabel('walk length')
    ylabel('probability')
    
    hold on
fd = diff(y,1)./diff(x,1);
%fd = gradient(y(:)) ./ gradient(x(:))
%plot(x(2:end),fd,'-')
plot(fd)
sd = diff(y,2)./diff(x,2);
%sd = gradient(fd(:)) ./ gradient(x(:))
%plot(x(2:end),sd,'-')
plot(sd)
hold off
legend('P','P'' ', 'P'''' ')
    
    t = handles.uitable1;
set(t,'Data',y');
set(t,'ColumnName',{'P data'})

t = handles.uitable2;
set(t,'Data',fd');
set(t,'ColumnName',{'P'' data'})

t = handles.uitable3;
set(t,'Data',sd');
set(t,'ColumnName',{'P'''' data'})

    axes(handles.axes7)
    CNet(vec)
end
if LA_C == 1 && (BA_C+TR_C == 0)
    'cat'
    qz = (N-1)*25;
    N= str2double(get(handles.it, 'String'))
    netW = str2double(get(handles.ms, 'String'))
    sta = str2double(get(handles.s, 'String'))
    en = str2double(get(handles.e, 'String'))
    
    netW = str2double(get(handles.ms, 'String'))
    
    sizeM = str2double(get(handles.size,'String'))
    set(handles.text10, 'String', 'square graph size');
    vec = zeros(sizeM^2);
    for i=1:sizeM^2
        if i+sizeM <= sizeM^2
        
        vec(i+sizeM,i) =1;
        vec(i,i+sizeM) =1;
        end
        if i+1 <= sizeM^2
        if mod(i,sizeM) ~= 0
            vec(i+1,i) =1;
            vec(i,i+1) =1;
        end
        end
    end
    
    m3 = vec;
    for i =1:sizeM^2
        tsum = sum(vec(i,:));
        for j = 1:sizeM^2
          m3(i,j) = vec(i,j)/tsum;
        end
    end
    mu_time = BA(m3,sta,en,25+qz);
    y = mu_time;
    for i =1:25+qz
        m(i) = i/25;
    end
    x = m;
    axes(handles.axes1)
    L1 = plot(x,y)
    title('gamma vs arrival time')
    xlabel('gamma')
    ylabel('arrival time')
    
    [M,I] = min(y);
gi = double(x(I))
set(handles.mgam, 'String', gi);
ti = double(y(I))
set(handles.mti, 'String', ti);
mm = x(i)
set(handles.maxG, 'String', mm);
    PaGraph = PA_G(m3,sta,en,25);
    y = PaGraph
    for i =1:25
        mb(i) = i;
    end
    x = mb;
    axes(handles.axes5)
    L1 = plot(x,y,'-')
    title('walk length vs probability')
    xlabel('walk length')
    ylabel('probability')
    
        hold on
fd = diff(y,1)./diff(x,1);
%fd = gradient(y(:)) ./ gradient(x(:))
%plot(x(2:end),fd,'-')
plot(fd)
sd = diff(y,2)./diff(x,2);
%sd = gradient(fd(:)) ./ gradient(x(:))
%plot(x(2:end),sd,'-')
plot(sd)
hold off
legend('P','P'' ', 'P'''' ')
    
    t = handles.uitable1;
set(t,'Data',y');
set(t,'ColumnName',{'P data'})

t = handles.uitable2;
set(t,'Data',fd');
set(t,'ColumnName',{'P'' data'})

t = handles.uitable3;
set(t,'Data',sd');
set(t,'ColumnName',{'P'''' data'})

    axes(handles.axes7)
    CNet(vec)
    
end




%plot(handles.axes2,x,y);

function BaGraph = BA_G(N,netW,sta,en)
seed =[0 1 0 0 1;1 0 0 1 0;0 0 0 1 0;0 1 1 0 0;1 0 0 0 0]
Net = SFNG(netW, 2, seed);
m1 = zeros(netW);
for i=1:netW
    sum(Net(i,:));
    m1(i,i) = sum(Net(i,:));
end
m2 = inv(m1);
m3 = Net;
for i =1:netW
    tsum = sum(Net(i,:));
    for j = 1:netW
        m3(i,j) = m3(i,j)/tsum;
    end
end

prob_M = m3;
BaGraph = prob_M;
%mu_time = BA(prob_M,e_t,e_1,N)

%for i =1:N
 %   m(i) = i
%end
%x = m

%y = PA_G(prob_M,e_t,e_1,N)
%axes(handles.axes5)
%L1 = plot(x,y, '.')
%lgd = legend( L1, 'y', 'Location', 'northeast');

%BaGraph = mu_time

function PaGraph = PA_G(lin,star,en,N)

e_t = zeros(1,size(lin,2));
e_t(1,star) =1;
e_1 = zeros(size(lin,2),1);
e_1(en,1) =1;
for mas = 1:N

    u = e_t*(lin)^mas*e_1;
    
    plist(mas) = u;
    
   
end
PaGraph = plist;



function g_Callback(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g as text
%        str2double(get(hObject,'String')) returns contents of g as a double


% --- Executes during object creation, after setting all properties.
function g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ms_Callback(hObject, eventdata, handles)
% hObject    handle to ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ms as text
%        str2double(get(hObject,'String')) returns contents of ms as a double


% --- Executes during object creation, after setting all properties.
function ms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_Callback(hObject, eventdata, handles)
% hObject    handle to s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s as text
%        str2double(get(hObject,'String')) returns contents of s as a double


% --- Executes during object creation, after setting all properties.
function s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_Callback(hObject, eventdata, handles)
% hObject    handle to e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e as text
%        str2double(get(hObject,'String')) returns contents of e as a double


% --- Executes during object creation, after setting all properties.
function e_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function it_Callback(hObject, eventdata, handles)
% hObject    handle to it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of it as text
%        str2double(get(hObject,'String')) returns contents of it as a double


% --- Executes during object creation, after setting all properties.
function it_CreateFcn(hObject, eventdata, handles)
% hObject    handle to it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BaC.
function BaC_Callback(hObject, eventdata, handles)
% hObject    handle to BaC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.deg, 'enable', 'off')
set(handles.size, 'enable', 'off')
set(handles.ms, 'enable', 'on')
set(handles.TrC, 'value', 0);
set(handles.LaC, 'value', 0);

% Hint: get(hObject,'Value') returns toggle state of BaC


% --- Executes on button press in TrC.
function TrC_Callback(hObject, eventdata, handles)
% hObject    handle to TrC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.deg, 'enable', 'on')
set(handles.ms, 'enable', 'off')
set(handles.size, 'enable', 'on')
set(handles.text10, 'String', 'tree size');
set(handles.BaC, 'value', 0);
set(handles.LaC, 'value', 0);

% Hint: get(hObject,'Value') returns toggle state of TrC


% --- Executes on button press in LaC.
function LaC_Callback(hObject, eventdata, handles)
% hObject    handle to LaC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.deg, 'enable', 'off')
set(handles.ms, 'enable', 'off')
set(handles.size, 'enable', 'on')
set(handles.text10, 'String', 'Square side length');
set(handles.BaC, 'value', 0);
set(handles.TrC, 'value', 0);
% Hint: get(hObject,'Value') returns toggle state of LaC


% --- Executes on button press in CoC.
function CoC_Callback(hObject, eventdata, handles)
% hObject    handle to CoC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CoC


% --- Executes on button press in BAr.
function BAr_Callback(hObject, eventdata, handles)
% hObject    handle to BAr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BAr


% --- Executes on button press in treR.
function treR_Callback(hObject, eventdata, handles)
% hObject    handle to treR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of treR



function itT_Callback(hObject, eventdata, handles)
% hObject    handle to itT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itT as text
%        str2double(get(hObject,'String')) returns contents of itT as a double


% --- Executes during object creation, after setting all properties.
function itT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gt_Callback(hObject, eventdata, handles)
% hObject    handle to gt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gt as text
%        str2double(get(hObject,'String')) returns contents of gt as a double


% --- Executes during object creation, after setting all properties.
function gt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deg_Callback(hObject, eventdata, handles)
% hObject    handle to deg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deg as text
%        str2double(get(hObject,'String')) returns contents of deg as a double


% --- Executes during object creation, after setting all properties.
function deg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function size_Callback(hObject, eventdata, handles)
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of size as text
%        str2double(get(hObject,'String')) returns contents of size as a double


% --- Executes during object creation, after setting all properties.
function size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uitable2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uitable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
