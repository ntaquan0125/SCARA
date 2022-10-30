function varargout = scara_arm(varargin)
% SCARA_ARM MATLAB code for scara_arm.fig
%      SCARA_ARM, by itself, creates a new SCARA_ARM or raises the existing
%      singleton*.
%
%      H = SCARA_ARM returns the handle to a new SCARA_ARM or the handle to
%      the existing singleton*.
%
%      SCARA_ARM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCARA_ARM.M with the given input arguments.
%
%      SCARA_ARM('Property','Value',...) creates a new SCARA_ARM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before scara_arm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to scara_arm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scara_arm

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @scara_arm_OpeningFcn, ...
    'gui_OutputFcn',  @scara_arm_OutputFcn, ...
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


% --- Executes just before scara_arm is made visible.
function scara_arm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to scara_arm (see VARARGIN)

% Choose default command line output for scara_arm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes scara_arm wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Setup the robot arm
global scara
a     = [0 4 2.5 0 0];
alpha = [0 0 180 0 0];
d     = [3.5 0 0 1 0];
theta = [0 0 0 0 0];
type = ['b', 'r', 'r', 'p', 'r'];
base = [0; 0; 0];
scara = Arm(a, alpha, d, theta, type, base);
scara = scara.set_joint_variable(2, deg2rad(get(handles.q1_slider, 'Value')));
scara = scara.set_joint_variable(3, deg2rad(get(handles.q2_slider, 'Value')));
scara = scara.set_joint_variable(4, get(handles.q3_slider, 'Value'));
scara = scara.set_joint_variable(5, deg2rad(get(handles.q4_slider, 'Value')));
scara = scara.update();
set_ee_params(scara, handles);
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));

reset_btn_Callback(hObject, eventdata, handles);
space_select_Callback(hObject, eventdata, handles);


% --- Outputs from this function are returned to the command line.
function varargout = scara_arm_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in workspace.
function workspace_Callback(hObject, eventdata, handles)
% hObject    handle to workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of workspace
global scara
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));


% --- Executes on button press in coords.
function coords_Callback(hObject, eventdata, handles)
% hObject    handle to coords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coords
global scara
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));


% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.px_axes);
cla(handles.py_axes);
cla(handles.pz_axes);
hold(handles.px_axes, 'on');
hold(handles.py_axes, 'on');
hold(handles.pz_axes, 'on');
set(handles.px_axes, 'XLimSpec', 'Tight');
set(handles.py_axes, 'XLimSpec', 'Tight');
set(handles.pz_axes, 'XLimSpec', 'Tight');
ylabel(handles.px_axes, '$x$', 'interpreter', 'latex', 'fontsize', 13);
ylabel(handles.py_axes, '$y$', 'interpreter', 'latex', 'fontsize', 13);
ylabel(handles.pz_axes, '$z$', 'interpreter', 'latex', 'fontsize', 13);

cla(handles.joint1dot_axes);
cla(handles.joint2dot_axes);
cla(handles.joint3dot_axes);
hold(handles.joint1dot_axes, 'on');
hold(handles.joint2dot_axes, 'on');
hold(handles.joint3dot_axes, 'on');
set(handles.joint1dot_axes, 'XLimSpec', 'Tight');
set(handles.joint2dot_axes, 'XLimSpec', 'Tight');
set(handles.joint3dot_axes, 'XLimSpec', 'Tight');
ylabel(handles.joint1dot_axes, '$\dot{q_1}$', 'interpreter', 'latex', 'fontsize', 13);
ylabel(handles.joint2dot_axes, '$\dot{q_2}$', 'interpreter', 'latex', 'fontsize', 13);
ylabel(handles.joint3dot_axes, '$\dot{q_3}$', 'interpreter', 'latex', 'fontsize', 13);

cla(handles.q_axes);
cla(handles.qdot_axes);
cla(handles.q2dot_axes);
hold(handles.q_axes, 'on');
hold(handles.qdot_axes, 'on');
hold(handles.q2dot_axes, 'on');
set(handles.q_axes, 'XLimSpec', 'Tight');
set(handles.qdot_axes, 'XLimSpec', 'Tight');
set(handles.q2dot_axes, 'XLimSpec', 'Tight');
ylabel(handles.q_axes, '$s$', 'interpreter', 'latex', 'fontsize', 13);
ylabel(handles.qdot_axes, '$v$', 'interpreter', 'latex', 'fontsize', 13);
ylabel(handles.q2dot_axes, '$a$', 'interpreter', 'latex', 'fontsize', 13);


% --- Executes on slider movement.
function q1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to q1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
scara = scara.set_joint_variable(2, deg2rad(get(handles.q1_slider, 'Value')));
scara = scara.update();
set_ee_params(scara, handles);
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function q1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to q2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
scara = scara.set_joint_variable(3, deg2rad(get(handles.q2_slider, 'Value')));
scara = scara.update();
set_ee_params(scara, handles);
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function q2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to q3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
scara = scara.set_joint_variable(4, get(handles.q3_slider, 'Value'));
scara = scara.update();
set_ee_params(scara, handles);
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function q3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q4_slider_Callback(hObject, eventdata, handles)
% hObject    handle to q4_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
scara = scara.set_joint_variable(5, deg2rad(get(handles.q4_slider, 'Value')));
scara = scara.update();
set_ee_params(scara, handles);
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function q4_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q4_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in dh_table_btn.
function dh_table_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dh_table_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
table((1:scara.n)', scara.a', scara.alpha', scara.d', scara.theta', 'VariableNames', {'Joint', 'a', 'alpha', 'd', 'theta'})


% --- Executes on button press in homo_mat_btn.
function homo_mat_btn_Callback(hObject, eventdata, handles)
% hObject    handle to homo_mat_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
scara.T(:,:,scara.n+1)


function x_start_Callback(hObject, eventdata, handles)
% hObject    handle to x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_start as text
%        str2double(get(hObject,'String')) returns contents of x_start as a double


% --- Executes during object creation, after setting all properties.
function x_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_start_Callback(hObject, eventdata, handles)
% hObject    handle to y_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_start as text
%        str2double(get(hObject,'String')) returns contents of y_start as a double


% --- Executes during object creation, after setting all properties.
function y_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_start_Callback(hObject, eventdata, handles)
% hObject    handle to z_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_start as text
%        str2double(get(hObject,'String')) returns contents of z_start as a double


% --- Executes during object creation, after setting all properties.
function z_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roll_start_Callback(hObject, eventdata, handles)
% hObject    handle to roll_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll_start as text
%        str2double(get(hObject,'String')) returns contents of roll_start as a double


% --- Executes during object creation, after setting all properties.
function roll_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitch_start_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitch_start as text
%        str2double(get(hObject,'String')) returns contents of pitch_start as a double


% --- Executes during object creation, after setting all properties.
function pitch_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_start_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_start as text
%        str2double(get(hObject,'String')) returns contents of yaw_start as a double


% --- Executes during object creation, after setting all properties.
function yaw_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_end_Callback(hObject, eventdata, handles)
% hObject    handle to x_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_end as text
%        str2double(get(hObject,'String')) returns contents of x_end as a double


% --- Executes during object creation, after setting all properties.
function x_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_end_Callback(hObject, eventdata, handles)
% hObject    handle to y_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_end as text
%        str2double(get(hObject,'String')) returns contents of y_end as a double


% --- Executes during object creation, after setting all properties.
function y_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_end_Callback(hObject, eventdata, handles)
% hObject    handle to z_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_end as text
%        str2double(get(hObject,'String')) returns contents of z_end as a double


% --- Executes during object creation, after setting all properties.
function z_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roll_end_Callback(hObject, eventdata, handles)
% hObject    handle to roll_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll_end as text
%        str2double(get(hObject,'String')) returns contents of roll_end as a double


% --- Executes during object creation, after setting all properties.
function roll_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitch_end_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitch_end as text
%        str2double(get(hObject,'String')) returns contents of pitch_end as a double


% --- Executes during object creation, after setting all properties.
function pitch_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_end_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_end as text
%        str2double(get(hObject,'String')) returns contents of yaw_end as a double


% --- Executes during object creation, after setting all properties.
function yaw_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in profile_select.
function profile_select_Callback(hObject, eventdata, handles)
% hObject    handle to profile_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns profile_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from profile_select


% --- Executes during object creation, after setting all properties.
function profile_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profile_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function v_max_Callback(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_max as text
%        str2double(get(hObject,'String')) returns contents of v_max as a double


% --- Executes during object creation, after setting all properties.
function v_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_max_Callback(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_max as text
%        str2double(get(hObject,'String')) returns contents of a_max as a double


% --- Executes during object creation, after setting all properties.
function a_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function t_max_Callback(hObject, eventdata, handles)
% hObject    handle to t_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_max as text
%        str2double(get(hObject,'String')) returns contents of t_max as a double


% --- Executes during object creation, after setting all properties.
function t_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in motion_btn.
function motion_btn_Callback(hObject, eventdata, handles)
% hObject    handle to motion_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara

p0 = zeros(1, 6);
p0(1) = str2double(get(handles.x_start, 'String'));
p0(2) = str2double(get(handles.y_start, 'String'));
p0(3) = str2double(get(handles.z_start, 'String'));
p0(4) = deg2rad(str2double(get(handles.roll_start, 'String')));
p0(5) = deg2rad(str2double(get(handles.pitch_start, 'String')));
p0(6) = deg2rad(str2double(get(handles.yaw_start, 'String')));

pf = zeros(1, 6);
pf(1) = str2double(get(handles.x_end, 'String'));
pf(2) = str2double(get(handles.y_end, 'String'));
pf(3) = str2double(get(handles.z_end, 'String'));
pf(4) = deg2rad(str2double(get(handles.roll_end, 'String')));
pf(5) = deg2rad(str2double(get(handles.pitch_end, 'String')));
pf(6) = deg2rad(str2double(get(handles.yaw_end, 'String')));
p2 = [0 6.5 2.5 180 0 0];

contents = cellstr(get(handles.profile_select, 'String'));
profile_type = contents{get(handles.profile_select, 'Value')};

v_max = str2double(get(handles.v_max, 'String'));
a_max = str2double(get(handles.a_max, 'String'));
t_max = str2double(get(handles.t_max, 'String'));

joint = inverse_kinematics(scara.a, scara.alpha, scara.d, scara.theta, p0);
scara = scara.set_joint_variable(2, joint(1));
scara = scara.set_joint_variable(3, joint(2));
scara = scara.set_joint_variable(4, joint(3));
scara = scara.set_joint_variable(5, joint(4));
scara = scara.update();
scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));

if get(handles.radiobutton1, 'Value')
    q_max = sqrt((pf(1) - p0(1))^2 + (pf(2) - p0(2))^2 + (pf(3) - p0(3))^2);
elseif get(handles.radiobutton2, 'Value')
    A = 2*[p2(1) - p0(1), p2(2) - p0(2); pf(1) - p0(1), pf(2) - p0(2)];
    B = [p2(1)^2 + p2(2)^2; pf(1)^2 + pf(2)^2] - [p0(1)^2 + p0(2)^2; p0(1)^2 + p0(2)^2];
    pc = inv(A)*B;
    pc = [pc(1) pc(2) p0(3) 0 0 0];
    alpha1 = atan2(p0(2) - pc(2), p0(1) - pc(1));
    alpha3 = atan2(pf(2) - pc(2), pf(1) - pc(1));
    r = sqrt((p0(1) - pc(1))^2 + (p0(2) - pc(2))^2);
    q_max = r*abs(alpha3 - alpha1);
else
    q_max = 0;
end
if strcmp(profile_type, 'LSPB')
    [t, q, qdot, q2dot] = LSPB_trajectory(q_max, v_max, a_max);
elseif strcmp(profile_type, 'Scurve')
    [t, q, qdot, q2dot] = Scurve_trajectory(q_max, v_max, a_max);
elseif strcmp(profile_type, 'Quintic')
    [t, q, qdot, q2dot] = quintic_trajectory(0, t_max, 0, 0, 0, q_max, 0, 0);
end

if get(handles.radiobutton1, 'Value')
    [t, p, pdot, p2dot] = linear_interpolation(p0, pf, t, q, qdot, q2dot);
elseif get(handles.radiobutton2, 'Value')
    [t, p, pdot, p2dot] = circular2d_interpolation(p0, p2, pf, t, q, qdot, q2dot);
elseif get(handles.radiobutton3, 'Value')
    [t, p, pdot, p2dot] = spline_interpolation(t_max);
end
for i = 1:length(t)
    point = [p(1,i), p(2,i), p(3,i), 0, 0, wrapToPi(p(6,i))];
    joint = inverse_kinematics(scara.a, scara.alpha, scara.d, scara.theta, point);
    scara = scara.set_joint_variable(2, joint(1));
    scara = scara.set_joint_variable(3, joint(2));
    scara = scara.set_joint_variable(4, joint(3));
    scara = scara.set_joint_variable(5, joint(4));
    scara = scara.update();
    jointdot(:,i) = pinv(scara.J)*pdot(:,i);
    set_joints_params(scara, handles);
    set_ee_params(scara, handles);
    scara.plot(handles.axes1, get(handles.coords,'Value'), get(handles.workspace,'Value'));
    plot(handles.px_axes, t(1:i), p(1,1:i), 'b-');
    plot(handles.py_axes, t(1:i), p(2,1:i), 'b-');
    plot(handles.pz_axes, t(1:i), p(3,1:i), 'b-');
    plot(handles.joint1dot_axes, t(1:i), jointdot(2,1:i), 'b-');
    plot(handles.joint2dot_axes, t(1:i), jointdot(3,1:i), 'b-');
    plot(handles.joint3dot_axes, t(1:i), jointdot(4,1:i), 'b-');
    plot(handles.q_axes, t(1:i), q(1:i), 'b-');
    plot(handles.qdot_axes, t(1:i), qdot(1:i), 'b-');
    plot(handles.q2dot_axes, t(1:i), q2dot(1:i), 'b-');
    plot3(handles.axes1, p(1,1:i), p(2,1:i), p(3,1:i), 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]);
    pause(t(100)/100);
end


% --- Executes on selection change in space_select.
function space_select_Callback(hObject, eventdata, handles)
% hObject    handle to space_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns space_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from space_select
contents = cellstr(get(handles.space_select, 'String'));
space_plot_type = contents{get(handles.space_select, 'Value')};
if strcmp(space_plot_type, 'Task space')
    set(handles.coords_plot_group, 'Visible', 'on');
    set(handles.jointdot_plot_group, 'Visible', 'off');
    set(handles.profile_plot_group, 'Visible', 'off');
elseif strcmp(space_plot_type, 'Joint space')
    set(handles.jointdot_plot_group, 'Visible', 'on');
    set(handles.coords_plot_group, 'Visible', 'off');
    set(handles.profile_plot_group, 'Visible', 'off');
elseif strcmp(space_plot_type, 'Profile')
    set(handles.profile_plot_group, 'Visible', 'on');
    set(handles.coords_plot_group, 'Visible', 'off');
    set(handles.jointdot_plot_group, 'Visible', 'off');
end


% --- Executes during object creation, after setting all properties.
function space_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to space_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
