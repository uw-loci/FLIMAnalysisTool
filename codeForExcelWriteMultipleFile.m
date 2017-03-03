

clear all
close all
%%Read the file with bmp, tiff file name
[nameofFile, path]=uigetfile({'*.bmp;*.tiff','Intensity Image files(*.bmp,*.tiff)'},'MultiSelect','on');% to open openfile gui

L=length(nameofFile);
row_header(1:L,1)={''};     %Column cell array (for row labels)
 
if(iscell(nameofFile)) %multiple file selected
    for i=1:L
        flim_params(i)=calculateMeanSingle(nameofFile{i}, path);
  
       
    end
    
else %single file selected
    flim=calculateMeanSingle(nameofFile, path);
end

flag=flim_params.ThirdParameterFlag;
data=zeros(L,5+2*flag);
for i=1:L
    if(flag)%for 3 parameter settings
        data(i,:)=[flim_params(i).tm,flim_params(i).t1,flim_params(i).t2,flim_params(i).t3,flim_params(i).a1,flim_params(i).a2,flim_params(i).a3];
    else %for 2 parameter settings
        data(i,:)=[flim_params(i).tm,flim_params(i).t1,flim_params(i).t2,flim_params(i).a1,flim_params(i).a2];
    end
    row_header{i,1}=flim_params(i).nameoffile;     
%      data(i,:)=[1,2,3,4,5];
end

data_cells=num2cell(data);     %Convert data to cell array
 if(flag)
    col_header={'tm','t1','t2','t3','a1','a2','a3'};     %Row cell array (for column labels)
 else
     col_header={'tm','t1','t2','a1','a2'};     %Row cell array (for column labels)
 end
output_matrix=[{' '} col_header; row_header data_cells];     %Join cell arrays
xlswrite('My_file1.xlsx',output_matrix);     %Write data and both headers


        