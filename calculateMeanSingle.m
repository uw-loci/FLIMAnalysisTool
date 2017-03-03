function y=calculateMeanSingle(nameoffile, path)


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


parameter_inputt1=strcat(path,imageName,'_t1.asc');
parameter_inputt2=strcat(path,imageName,'_t2.asc');
parameter_inputa1=strcat(path,imageName,'_a1[%].asc');
parameter_inputa2=strcat(path,imageName,'_a2[%].asc');

%Third parameter 
parameter_inputa3=strcat(path,imageName,'_a3[%].asc');
parameter_inputt3=strcat(path,imageName,'_t3.asc');

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


ThirdParameterFlag=0;

if(exist(parameter_inputa3,'file')==2)
    im_a3=importdata(parameter_inputa3);
    if(exist(parameter_inputt3,'file')==2)
        im_t3=importdata(parameter_inputt3);
        ThirdParameterFlag=1;
    else
        msgbox(strcat(imageName,'_t3.asc not found, please reload'));
        return;
    end

end



%%calculating mean
im_t1=im_t1_file;
im_a1=im_a1_file;
im_t2=im_t2_file;
im_a2=im_a2_file;


% figure, imshow(bw_sz);

im_a1=im_a1/100;
im_a2=im_a2/100;

%calculate mean lifetime
%The following line creates mean based on percentage value
%tm=im_a1.*im_t1+im_a2.*im_t2;

%The dollowing line calculates mean based on absolute value of a1, a2
tm=im_a1.*im_t1+im_a2.*im_t2;
[m n]=size(tm);
loc=find(im_t1~=0);%location of the valid(nonZero pixel)
flim.t3=0;
flim.a3=0;

if(ThirdParameterFlag==1)
    im_a3=im_a3/100;
    tm=tm+im_a3.*im_t3;
    flim.t3=mean(im_t3(loc));
    flim.a3=100*mean(im_a3(loc));
    %std_dev
    
    flim.t3_std_dev=std(im_t3(loc));
    flim.a3_std_dev=100*std(im_a3(loc));
end


%%% mean value calculation%%%%
flim.tm=mean(tm(loc));
flim.t1=mean(im_t1(loc));
flim.t2=mean(im_t2(loc));
flim.a1=100*mean(im_a1(loc));
flim.a2=100*mean(im_a2(loc));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Std dev value

flim.tm_std_dev=std(tm(loc));
flim.t1_std_dev=std(im_t1(loc));
flim.t2_std_dev=std(im_t2(loc));
flim.a1_std_dev=100*std(im_a1(loc));
flim.a2_std_dev=100*std(im_a2(loc));
%%%%%%%%%%%%%%

flim.nameoffile=firstPartName{1};
flim.ThirdParameterFlag=ThirdParameterFlag;


y=flim;


