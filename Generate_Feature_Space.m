
clear all


load data
projV_NUM=10;

alpha=1.9680;


   for s=1:Train_NUM
       E_Train_DAT(:,:,s)=exp(1i*alpha*pi*Train_DAT(:,:,s))./sqrt(2);
   end



   for s=1:Test_NUM
       E_Test_DAT(:,:,s)=exp(1i*alpha*pi*Test_DAT(:,:,s))./sqrt(2);
   end




% using 2DPCA for training
tic;
[U,disc_value,Mean_Image]=IMPCA_f(E_Train_DAT,projV_NUM);
toc

% 2DPCA Transformation

E_Train_SET=zeros(Image_row_NUM,projV_NUM,Train_NUM);
E_Test_SET=zeros(Image_row_NUM,projV_NUM,Test_NUM);



for s=1:Train_NUM
    E_Train_SET(:,:,s)=E_Train_DAT(:,:,s)*U; % 
end



for s=1:Test_NUM
    E_Test_SET(:,:,s)=E_Test_DAT(:,:,s)*U; % 
end



E_Train_SET=reshape(E_Train_SET,[Image_row_NUM,projV_NUM,Class_Train_NUM,Class_NUM]);
E_Test_SET=reshape(E_Test_SET,[Image_row_NUM,projV_NUM,Class_Test_NUM,Class_NUM]);


save('U.mat', 'U', 'E_Train_SET', 'E_Test_SET', 'Image_row_NUM', 'Image_column_NUM', 'projV_NUM', 'alpha', 'Class_NUM', 'Test_NUM', 'Class_Test_NUM');



