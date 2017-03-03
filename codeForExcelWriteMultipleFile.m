% code to analyze batch exported data from SPCImage
% Author: Md Abdul Kader Sagar
% LOCI
%
% This matlab program takes the file exported from SPCimage batch export
% mode and calcaultes mean and standard deviation for all parameters for 2
% or 3 component fit to an excel file
%
%INPUT
%From SPCImage export t1,t2,a1[%],a2[%], and "Gray-Scale Image" for 2
%component fit
%for 3 component fit export t3 and a3[%]
%When you run the program go to the directory and select the grayscale
%images only
%
%OUTPUT
%output will be saved as the same director as the input images with name "ExportedValue.xlsx"
%you can change the name

clear all
close all



fileName='ExportedValue.xlsx';


%%%
[nameofFile, path]=uigetfile({'*.bmp;*.tiff','Intensity Image files(*.bmp,*.tiff)'},'MultiSelect','on');% to open openfile gui


if(iscell(nameofFile)) %multiple file selected
    flag=checkForThirdParam(nameofFile{1}, path);
    L=length(nameofFile);
    row_header(1:L,1)={''};     %Column cell array (for row labels)
    data=zeros(L,10+4*flag);
    for i=1:L

        flim_params=calculateMeanSingle(nameofFile{i}, path);
        if(flag)%for 3 parameter settings
            data(i,:)=[flim_params.tm,flim_params.t1,flim_params.t2,flim_params.t3,flim_params.a1,flim_params.a2,flim_params.a3,flim_params.tm_std_dev,flim_params.t1_std_dev,flim_params.t2_std_dev,flim_params.t3_std_dev,flim_params.a1_std_dev,flim_params.a2_std_dev,flim_params.a3_std_dev];
        else %for 2 parameter settings
            data(i,:)=[flim_params.tm,flim_params.t1,flim_params.t2,flim_params.a1,flim_params.a2,flim_params.tm_std_dev,flim_params.t1_std_dev,flim_params.t2_std_dev,flim_params.a1_std_dev,flim_params.a2_std_dev];
        end
        row_header{i,1}=flim_params.nameoffile;

        
    end
    
else %single file selected
    
    flag=checkForThirdParam(nameofFile, path);
    data=zeros(1,10+4*flag);
    flim_params=calculateMeanSingle(nameofFile, path);
    if(flag)%for 3 parameter settings
        data(1,:)=[flim_params.tm,flim_params.t1,flim_params.t2,flim_params.t3,flim_params.a1,flim_params.a2,flim_params.a3,flim_params.tm_std_dev,flim_params.t1_std_dev,flim_params.t2_std_dev,flim_params.t3_std_dev,flim_params.a1_std_dev,flim_params.a2_std_dev,flim_params.a3_std_dev];
    else %for 2 parameter settings
        data(1,:)=[flim_params.tm,flim_params.t1,flim_params.t2,flim_params.a1,flim_params.a2,flim_params.tm_std_dev,flim_params.t1_std_dev,flim_params.t2_std_dev,flim_params.a1_std_dev,flim_params.a2_std_dev];
    end
    row_header{1,1}=flim_params.nameoffile;

end

% flag=flim_params.ThirdParameterFlag;
% data=zeros(L,10+4*flag);
% for i=1:L
%     if(flag)%for 3 parameter settings
%         data(i,:)=[flim_params(i).tm,flim_params(i).t1,flim_params(i).t2,flim_params(i).t3,flim_params(i).a1,flim_params(i).a2,flim_params(i).a3,flim_params(i).tm_std_dev,flim_params(i).t1_std_dev,flim_params(i).t2_std_dev,flim_params(i).t3_std_dev,flim_params(i).a1_std_dev,flim_params(i).a2_std_dev,flim_params(i).a3_std_dev];
%     else %for 2 parameter settings
%         data(i,:)=[flim_params(i).tm,flim_params(i).t1,flim_params(i).t2,flim_params(i).a1,flim_params(i).a2,flim_params(i).tm_std_dev,flim_params(i).t1_std_dev,flim_params(i).t2_std_dev,flim_params(i).a1_std_dev,flim_params(i).a2_std_dev];
%     end
%     row_header{i,1}=flim_params(i).nameoffile;     
% %      data(i,:)=[1,2,3,4,5];
% end

data_cells=num2cell(data);     %Convert data to cell array
if(flag)
    col_header={'tm','t1','t2','t3','a1','a2','a3','tm_stdev','t1_stdev','t2_stdev','t3_stdev','a1_stdev','a2_stdev','a3_stdev'};     %Row cell array (for column labels)
else
    col_header={'tm','t1','t2','a1','a2','tm_stdev','t1_stdev','t2_stdev','a1_stdev','a2_stdev'};     %Row cell array (for column labels)
end
output_matrix=[{' '} col_header; row_header data_cells];     %Join cell arrays
xlswrite(strcat(path,fileName),output_matrix);     %Write data and both headers


        