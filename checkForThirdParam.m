function checkForThirdParamflag=checkForThirdParam(nameoffile, path)




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

checkForThirdParamflag=0;
parameter_inputa3=strcat(path,imageName,'_a3[%].asc');
parameter_inputt3=strcat(path,imageName,'_t3.asc');


if(exist(parameter_inputa3,'file')==2)
    if(exist(parameter_inputt3,'file')==2)
        checkForThirdParamflag=1;
    else
        msgbox(strcat(imageName,'_t3.asc not found, please reload'));
        return;
    end
end 