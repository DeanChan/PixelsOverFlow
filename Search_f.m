function Class_No=Search_f(wanted)

load U.mat;
alpha=1.9680;


E_Test_DAT=zeros(Image_row_NUM,Image_column_NUM,Class_NUM); 

for s=1:Class_NUM   
     A=imread(wanted);
     B=im2double(A);
     B=mean(B,3);
     E_Test_DAT(:,:,s)=exp(1i*alpha*pi*imresize(B,[Image_row_NUM Image_column_NUM]))./sqrt(2);
end


    E_Test_SET=zeros(Image_row_NUM,projV_NUM,Class_NUM);

for s=1:Class_NUM
    E_Test_SET(:,:,s)=E_Test_DAT(:,:,s)*U; % 
end

E_Test_SET=reshape(E_Test_SET,[Image_row_NUM,projV_NUM,1,Class_NUM]);


% classification using Nearest Neighborhood classifier

Class_No=Classifier_2DPCA_NN_f(E_Train_SET(:,1:projV_NUM,:,:),E_Test_SET(:,1:projV_NUM,:,:));


  

  
