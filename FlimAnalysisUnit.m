function varargout = FlimAnalysisUnit(varargin)
% FLIMANALYSISUNIT MATLAB code for FlimAnalysisUnit.fig
%      FLIMANALYSISUNIT, by itself, creates a new FLIMANALYSISUNIT or raises the existing
%      singleton*.
%
%      H = FLIMANALYSISUNIT returns amar to the handle to a new FLIMANALYSISUNIT or the handle to
%      the existing singleton*.
%
%      FLIMANALYSISUNIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLIMANALYSISUNIT.M with the given input arguments.
%
%      FLIMANALYSISUNIT('Property','Value',...) creates a new FLIMANALYSISUNIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FlimAnalysisUnit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FlimAnalysisUnit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FlimAnalysisUnit

% Last Modified by GUIDE v2.5 19-Jul-2016 11:02:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FlimAnalysisUnit_OpeningFcn, ...
                   'gui_OutputFcn',  @FlimAnalysisUnit_OutputFcn, ...
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


% --- Executes just before FlimAnalysisUnit is made visible.
function FlimAnalysisUnit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FlimAnalysisUnit (see VARARGIN)

% Choose default command line output for FlimAnalysisUnit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% set(hObject,'toolbar','figure');
% UIWAIT makes FlimAnalysisUnit wait for user response (see UIRESUME)
% uiwait(handles.figure1);




%%
%global variable description
%global x imageName path intensity_image_name ;
% imageName: First portion of the name,tilee underscore, eg, im20
% path: path to the directory
%intensiity_image_name= im20_inten..bmp

% --- Outputs from this function are returned to the command line.
function varargout = FlimAnalysisUnit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_images.
function load_images_Callback(hObject, eventdata, handles)
% hObject    handle to load_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x imageName path intensity_image_name ;
axes(handles.axes1);
filename=get(handles.file_name,'String');
x=imread(filename);
imshow(x);

% --- Executes on button press in binarized.
function binarized_Callback(hObject, eventdata, handles)
% hObject    handle to binarized (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x imageName path intensity_image_name gray_image ;
axes(handles.axes_thres);
% x=imread('greens.jpg');
binary_mask=uint8(im2bw(gray_image,.15));
imshow(binary_mask.*gray_image);



% --- Executes on button press in lifetime_calc.
function lifetime_calc_Callback(hObject, eventdata, handles)
% hObject    handle to lifetime_calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x imageName path intensity_image_name flim_params ;
axes(handles.axes_thres);

flim_params=lifetime_params_Calculator();

set(handles.tm_box,'String',flim_params.tm);
set(handles.t1_box,'String',flim_params.t1);
set(handles.t2_box,'String',flim_params.t2);
set(handles.a1_box,'String',flim_params.a1);
set(handles.chi_2Mean,'String',flim_params.chi);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global x imageName path intensity_image_name gray_image image_threshold_min image_threshold_max ;
slider_pos=get(handles.slider1,'Value');
set(handles.text1,'String',slider_pos);
axes(handles.axes_thres);
% x=imread('greens.jpg');
image_threshold_min=slider_pos;

% binary_mask=uint8(im2bw(x,slider_pos));

binary_mask=uint8(im2bw2levels(gray_image,image_threshold_min,image_threshold_max));

imshow(binary_mask.*gray_image);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function file_name_Callback(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_name as text
%        str2double(get(hObject,'String')) returns contents of file_name as a double



% --- Executes during object creation, after setting all properties.
function file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in open_file_button.
function open_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to open_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x imageName path intensity_image_name gray_image image_threshold_min fid image_threshold_max chi2_data chi2_min chi2_max;
global im_t1_file im_t2_file im_a1_file im_a2_file;
% [nameoffile, path]=uigetfile({'*.bmp';'*.tif'});% to open openfile gui
% [nameoffile, path]=uigetfile({'*.bmp;*.tiff','Intensity Image files(*.bmp,*.tiff)'});% to open openfile gui

if(exist('path.mat')==2)
   load path
else 
    prevPath='D:\';
end

pathSTR=strcat(prevPath,'*.bmp;*.tiff');
[nameoffile, path] = uigetfile(pathSTR,'Intensity Image files(*.bmp,*.tiff)');

handles = guidata(hObject); 
axes(handles.axes_view_image);


[no_use name_file_not_used extension_type]=fileparts(nameoffile);



% firstPartName = strsplit(nameoffile,'_');

if(strcmp(extension_type,'.bmp'))
    type=1;
elseif(strcmp(extension_type,'.tiff'))
    type=2;
end


if(type==1)
    firstPartName=strsplit(nameoffile,'_intensity_image.bmp');
elseif(type==2)
    firstPartName=strsplit(nameoffile,'_intensity_image.tiff');
end



imageName=char(firstPartName(1));% takes only the first string before the _ sign

%reads intensity file
% intensity_image_name=strcat(path,imageName,'_intensity_image.bmp');
intensity_image_name=strcat(path,nameoffile);
prevPath=path;
save path prevPath

image_threshold_min=0.15;
image_threshold_max=1.0;
x=imread(intensity_image_name);
if(type==1)
    gray_image=rgb2gray(x);
elseif(type==2)
    gray_image=x;
end



%chi_data loading
%file not exist condition needed to be added later
chi2_data_name=strcat(path,imageName,'_chi.asc');

if(exist(chi2_data_name,'file')==2)
    chi2_data=importdata(chi2_data_name);
    
else
    msgbox(strcat(imageName,'_chi.asc not found, please reload'));
    return;
end


% chi2_data=importdata(chi2_data_name);

chi2_min=0.8;
chi2_max=1.2;

gray_image=imresize(gray_image,size(chi2_data));


parameter_inputt1=strcat(path,imageName,'_t1.asc');
parameter_inputt2=strcat(path,imageName,'_t2.asc');
parameter_inputa1=strcat(path,imageName,'_a1[%].asc');
parameter_inputa2=strcat(path,imageName,'_a2[%].asc');

% intensity_image=imread(intensity_image_name);
% imshow(a) 

if(exist(parameter_inputt1,'file')==2)
    im_t1_file=importdata(parameter_inputt1);
else
    msgbox(strcat(imageName,'_t1.asc not found, please reload'));
    return;
end


if(exist(parameter_inputt2,'file')==2)
    im_t2_file=importdata(parameter_inputt2);
else
    msgbox(strcat(imageName,'_t2.asc not found, please reload'));
    return;
end 

if(exist(parameter_inputa1,'file')==2)
    im_a1_file=importdata(parameter_inputa1);
else
    msgbox(strcat(imageName,'_a1.asc not found, please reload'));
    return;
end


if(exist(parameter_inputa2,'file')==2)
    im_a2_file=importdata(parameter_inputa2);
else
    msgbox(strcat(imageName,'_a2.asc not found, please reload'));
    return;
end



set(handles.image_name,'String',imageName);
% set(handles.image_name,'String','asd');
imshow(x);

fid = fopen('lifetime_params.txt', 'w');

fprintf(fid,'name\t\tThreshold\t\ttm\t\t\t\t\tt1\t\t\t\t\tt2\t\t\t\t\ta1');
fprintf(fid,'\n');

%calculate flim param

function flim=lifetime_params_Calculator()
global x imageName path intensity_image_name gray_image image_threshold_min image_threshold_max hist_vals;
global  chi2_data chi2_min chi2_max;
global im_t1_file im_t2_file im_a1_file im_a2_file;
% firstPartName = strsplit(input_string,'_');
% imageName=char(firstPartName(1));% takes only the first string before the _ sign





% % intensity_image_name=strcat(path,imageName,'_intensity_image.bmp');
% parameter_inputt1=strcat(path,imageName,'_t1.asc');
% parameter_inputt2=strcat(path,imageName,'_t2.asc');
% parameter_inputa1=strcat(path,imageName,'_a1[%].asc');
% parameter_inputa2=strcat(path,imageName,'_a2[%].asc');
% 
% % intensity_image=imread(intensity_image_name);
% % imshow(a) 
% im_t1=importdata(parameter_inputt1);
% im_t2=importdata(parameter_inputt2);
% im_a1=importdata(parameter_inputa1);
% im_a2=importdata(parameter_inputa2);
im_t1=im_t1_file;
im_a1=im_a1_file;
im_t2=im_t2_file;
im_a2=im_a2_file;



% figure, imshow(bw_sz);

im_a1=im_a1/100;
im_a2=im_a2/100;

%calculate mean lifetime
tm=im_a1.*im_t1+im_a2.*im_t2;
% gray_image=rgb2gray(intensity_image);
% bw_resize=imresize(gray_image,size(im_t1));
% figure, imshow(bw_sz);

% mask_image=uint8(im2bw(bw_resize,image_threshold_min));

%thresholds the image based on the max min threshold obtained from the
%sliders
mask_image=uint8(im2bw2levels(gray_image,image_threshold_min,image_threshold_max));


% imshow(bin)
%threshold the image with chi2 value range(between chi2_min and chi2_max)
mask_image=mask_image.*uint8((~(chi2_data<chi2_min|chi2_data>chi2_max)));

[m n]=size(mask_image);
%finding location of valid pixels
loc=find(reshape(mask_image,1,m*n));

 
arr=reshape(tm,1,m*n);
val=arr(loc);
hist_vals.tm=val;
flim.tm=sum(val)/length(val);

%%%%t1%%%
arr=reshape(im_t1,1,m*n);
val=arr(loc);
hist_vals.t1=val;
flim.t1=sum(val)/length(val);
%%%%%%%%%%%%%%%%%%%


%%%%%%%t2%%%%%%%%
arr=reshape(im_t2,1,m*n);
val=arr(loc);
hist_vals.t2=val;
flim.t2=sum(val)/length(val);
%%%%%%%%%%%%%%%%%


%%%%%%%%%a1%%%%%%%%
arr=reshape(im_a1,1,m*n);
val=arr(loc);
hist_vals.a1=val;
flim.a1=sum(val)/length(val)*100;

%%%%%%%%%%chi2%%%%%%%%%
arr=reshape(chi2_data,1,m*n);
val=arr(loc);
hist_vals.chi=val;
flim.chi=sum(val)/length(val);




% --- Executes on key press with focus on slider1 and none of its controls.
function slider1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_to_file.
function save_to_file_Callback(hObject, eventdata, handles)
% hObject    handle to save_to_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flim_params imageName image_threshold_min fid image_threshold_max;

 fid = fopen('lifetime_params.txt', 'a+');
% 
% fprintf(fid,'name\t\tThreshold\t\ttm\t\t\t\t\tt1\t\t\t\t\tt2\t\t\t\t\ta1');

fprintf(fid,imageName);
fprintf(fid,'\t\t');
fprintf(fid,num2str(image_threshold_min));
fprintf(fid,'\t\t\t%f\t\t\t%f\t\t\t%f\t\t\t%f\n',flim_params.tm,flim_params.t1,flim_params.t2,flim_params.a1);
fclose(fid);

% --- Executes during object creation, after setting all properties.
function save_to_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_to_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function Max_thresh_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Max_thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global imageName path intensity_image_name gray_image image_threshold_min image_threshold_max ;
slider_pos=get(handles.Max_thresh_slider,'Value');
set(handles.thresh_max_text,'String',slider_pos);
axes(handles.axes_thres);
% x=imread('greens.jpg');
image_threshold_max=slider_pos;
binary_mask=uint8(im2bw2levels(gray_image,image_threshold_min,image_threshold_max));

imshow(binary_mask.*gray_image);


% --- Executes during object creation, after setting all properties.
function Max_thresh_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%creates a binary using two threshold

function thresholded_image=im2bw2levels(input_image,low_thres,high_thres)
global chi2_min chi2_max chi2_data;

% temp_image=input_image.*uint8((~(chi2_data<chi2_min|chi2_data>chi2_max)));

% thresholded_image=xor(im2bw(input_image,low_thres),im2bw(input_image,high_thres));
thresholded_image=xor(im2bw(input_image,low_thres),im2bw(input_image,high_thres));

function [histo maxpos max_value]= mean_with_histo(val)
val=round(val);
maximum=max(val);
L=length(val);
histo=zeros(1,maximum+1);
for i=1:L
    histo(val(i)+1)=histo(val(i)+1)+1;
end

plot(0:maximum,histo);
[max_value maxpos]=max(histo);

maxpos=maxpos-1;

function [histo maxpos max_value]= mean_with_histo_chi(val)
val=round(val);
maximum=max(val);
L=length(val);
histo=zeros(1,maximum+1);
for i=1:L
    histo(val(i)+1)=histo(val(i)+1)+1;
end

xAxisVal=linspace(0,maximum/100,length(histo));
plot(xAxisVal,histo);
[max_value maxpos]=max(histo);

maxpos=maxpos-1;

% --- Executes on button press in hist_tm.
function hist_tm_Callback(hObject, eventdata, handles)
% hObject    handle to hist_tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_vals data_excel;
axes(handles.axes_hist);

[hist_tm tm_pos tm_max_value_in_hist]=mean_with_histo(hist_vals.tm);
set(handles.hist_max_val,'String',tm_max_value_in_hist);
set(handles.hist_max_pos,'String',tm_pos);
data_excel=hist_tm;

% --- Executes on button press in hist_t1.
function hist_t1_Callback(hObject, eventdata, handles)
% hObject    handle to hist_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_vals data_excel;
axes(handles.axes_hist);
[hist_t1 t1_pos t1_max_value_in_hist]=mean_with_histo(hist_vals.t1);
set(handles.hist_max_val,'String',t1_max_value_in_hist);
set(handles.hist_max_pos,'String',t1_pos);
data_excel=hist_t1;


% --- Executes on button press in hist_t2.
function hist_t2_Callback(hObject, eventdata, handles)
% hObject    handle to hist_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_vals data_excel;
axes(handles.axes_hist);
[hist_t2 t2_pos t2_max_value_in_hist]=mean_with_histo(hist_vals.t2);
set(handles.hist_max_val,'String',t2_max_value_in_hist);
set(handles.hist_max_pos,'String',t2_pos);
data_excel=hist_t2;

% --- Executes on button press in hist_a1.
function hist_a1_Callback(hObject, eventdata, handles)
% hObject    handle to hist_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_vals data_excel;
axes(handles.axes_hist);
% hist(hist_vals.a1,10000);
 [hist_a1 a1_pos a1_max_value_in_hist]=mean_with_histo(100*hist_vals.a1);
 set(handles.hist_max_val,'String',a1_max_value_in_hist);
set(handles.hist_max_pos,'String',a1_pos);
data_excel=hist_a1;

% --- Executes on button press in Export_excel.
function Export_excel_Callback(hObject, eventdata, handles)
% hObject    handle to Export_excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_vals data_excel;
filename_xls=get(handles.filename_xl,'String');
 xlswrite(strcat(filename_xls,'.xlsx'),data_excel);
 


function filename_xl_Callback(hObject, eventdata, handles)
% hObject    handle to filename_xl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_xl as text
%        str2double(get(hObject,'String')) returns contents of filename_xl as a double



% --- Executes during object creation, after setting all properties.
function filename_xl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_xl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_chi2_min_Callback(hObject, eventdata, handles)
% hObject    handle to slider_chi2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider




global chi2_max chi2_min chi2_data gray_image image_threshold_min image_threshold_max;
axes(handles.axes_thres);

chi2_min=get(handles.slider_chi2_min,'Value');
set(handles.text_thres_chi2_min,'String',chi2_min);


mask_image=uint8(im2bw2levels(gray_image,image_threshold_min,image_threshold_max));
% imshow(bin)
%threshold the image with chi2 value range(between chi2_min and chi2_max)
mask_image=mask_image.*uint8((~(chi2_data<chi2_min|chi2_data>chi2_max)));

imshow(mask_image.*gray_image);



% --- Executes during object creation, after setting all properties.
function slider_chi2_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_chi2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_chi2_max_Callback(hObject, eventdata, handles)
% hObject    handle to slider_chi2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% slider_pos=get(handles.slider_chi2_max,'Value');



global chi2_max chi2_min chi2_data gray_image image_threshold_min image_threshold_max;
axes(handles.axes_thres);

chi2_max=get(handles.slider_chi2_max,'Value')+1;
set(handles.text_thres_chi2_max,'String',chi2_max);


mask_image=uint8(im2bw2levels(gray_image,image_threshold_min,image_threshold_max));
% imshow(bin)
%threshold the image with chi2 value range(between chi2_min and chi2_max)
mask_image=mask_image.*uint8((~(chi2_data<chi2_min|chi2_data>chi2_max)));

imshow(mask_image.*gray_image);




% --- Executes during object creation, after setting all properties.
function slider_chi2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_chi2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in view_chi2_thresh_image.
function view_chi2_thresh_image_Callback(hObject, eventdata, handles)
% hObject    handle to view_chi2_thresh_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global chi2_max chi2_min chi2_data gray_image image_threshold_min image_threshold_max;
axes(handles.axes_thres);


mask_image=uint8(im2bw2levels(gray_image,image_threshold_min,image_threshold_max));
% imshow(bin)
%threshold the image with chi2 value range(between chi2_min and chi2_max)
mask_image=mask_image.*uint8((~(chi2_data<chi2_min|chi2_data>chi2_max)));

imshow(mask_image.*gray_image);


% --- Executes during object creation, after setting all properties.
function open_file_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to open_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in chi2_hist.
function chi2_hist_Callback(hObject, eventdata, handles)
% hObject    handle to chi2_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_vals data_excel;
axes(handles.axes_hist);
% hist(hist_vals.a1,10000);
[hist_chi chi_pos chi_max_value_in_hist]=mean_with_histo_chi(100*hist_vals.chi);
set(handles.hist_max_val,'String',chi_max_value_in_hist);
set(handles.hist_max_pos,'String',chi_pos);
data_excel=hist_chi;


% --- Executes on button press in ROIButton.
function ROIButton_Callback(hObject, eventdata, handles)
global chi2_max chi2_min chi2_data gray_image image_threshold_min image_threshold_max h_im x;
% hObject    handle to ROIButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_view_image);

h_im=imshow(x);
e = imfreehand;
BW = createMask(e,h_im);


% --- Executes during object deletion, before destroying properties.
function t2_box_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to t2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function t1_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function t2_box_CreateFcn(hObject, eventdata, handles)
function a1_box_CreateFcn(hObject, eventdata, handles)
function text33_CreateFcn(hObject, eventdata, handles)
function chi_2Mean_CreateFcn(hObject, eventdata, handles)
