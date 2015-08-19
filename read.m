path_name = 'F:\Dropbox\Pattern Recognition\Database\eth80\eth80-cropped-close128\';

%Image_row_NUM=128;Image_column_NUM=128; 
Image_row_NUM    = 64;
Image_column_NUM = 64; %128x128 image is resized to be 64x64
NN               = Image_row_NUM * Image_column_NUM;

Category_Object_NUM       = 10;
Train_Category_Object_NUM = 9;
Test_Category_Object_NUM  = Category_Object_NUM - Train_Category_Object_NUM;

stemp = zeros(1,10);

Object_Sample_NUM = 41;

Category_Train_NUM  = Object_Sample_NUM * Train_Category_Object_NUM;
Class_Train_NUM = Category_Train_NUM;
Category_Sample_NUM = Object_Sample_NUM * Category_Object_NUM; % total
Category_Test_NUM   = Category_Sample_NUM - Category_Train_NUM;
Class_Test_NUM = Category_Test_NUM;

Category_NUM = 8;
Class_NUM = Category_NUM;
Train_NUM    = Category_NUM * Category_Train_NUM; % 
Test_NUM     = Category_NUM * Category_Test_NUM; % 

Eigen_NUM = 300;
Disc_NUM  = Category_NUM - 1;  %Category_NUM - 1

Dim_Begin     = Disc_NUM; 
Dim_End       = Disc_NUM; %Disc_NUM
Dim_Interval  = 1; % for Kernel Fisherface and CKFD regular and irregular
Dim_Total_NUM = (Dim_End - Dim_Begin) / Dim_Interval + 1; % is same as (Dim_End-Dim_Begin+Dim_Interval)/Dim_Interval

% the following section is to read selected face images in COIL database into matrix A
%str1 = 'D:\ETH80_Database\eth80-cropped-close128\Object_Class_Name.txt';
str1 = [path_name 'Object_Class_Name.txt'];
[filename] = textread(str1,'%s', Category_NUM);
Object_Name(Category_NUM).filename = 'Initialization';
for k = 1 : Category_NUM
    Object_Name(k).filename = filename(k); % a struct, in which every element is an array
end
clear filename; 

%str1 = 'D:\ETH80_Database\eth80-cropped-close128\Object_Viewpoint.txt';
str1 = [path_name 'Object_Viewpoint.txt'];
[filename] = textread(str1,'%s',Object_Sample_NUM);
Object_Sample_Name(Object_Sample_NUM).filename = 'Initialization';
for k = 1 : Object_Sample_NUM
    Object_Sample_Name(k).filename = filename(k); % a struct, in which every element is an array
end
clear filename; 

% ind = randperm(Category_Object_NUM);
% ind = matrix(1, :);

Train_DAT = zeros(Image_row_NUM, Image_column_NUM, Train_NUM);
s = 1;
for r = 1 : Category_NUM
   object_name = Object_Name(r).filename;
   for index = 1 : Train_Category_Object_NUM
       
      for t = 1 : Object_Sample_NUM
         object_sample_name = Object_Sample_Name(t).filename;    
%          string=[path_name ... 
%                  object_name int2str(index) '\' ...
%                  object_name int2str(index) '-' ...
%                  object_sample_name '.png'];
         string =[path_name ... 
                 object_name int2str(index) '\' ...
                 object_name int2str(index) '-' ...
                 object_sample_name '.png'];
             string_to_use=blanks(0);
             for i=1:size(string,2)
                string_to_use=[string_to_use char(string(i))];
             end
         A = imread(string_to_use);
         A = imresize(A, [Image_row_NUM,Image_column_NUM]);

         %imshow(A)
         A = im2double(A);
         A = mean(A,3);% convert to intensity images
                  
         % Intialize A
         % A=histeq(A);
         %

         Train_DAT(:,:,s) = A;
         s = s + 1;
      end
      
   end
end

Test_DAT = zeros(Image_row_NUM, Image_column_NUM, Test_NUM);
s = 1;
for r = 1 : Category_NUM
    object_name = Object_Name(r).filename;
    for index = (Train_Category_Object_NUM + 1) : Category_Object_NUM
      
      for t = 1 : Object_Sample_NUM
         object_sample_name = Object_Sample_Name(t).filename;    
%          string=[path_name ...
%                  object_name int2str(index) '\' ...
%                  object_name int2str(index) '-' ...
%                  object_sample_name '.png'];
         string= [path_name ... 
                 object_name int2str(index) '\' ...
                 object_name int2str(index) '-' ...
                 object_sample_name '.png'];
             string_to_use=blanks(0);
             for i=1:size(string,2)
                string_to_use=[string_to_use char(string(i))];
             end
         A = imread(string_to_use);
         A = imresize(A, [Image_row_NUM,Image_column_NUM]);

         %imshow(A)
         A = im2double(A);
         A = mean(A,3);% convert to intensity images
         
         % Intialize A
         % A=histeq(A);
         %

         Test_DAT(:,:,s) = A;
         s = s + 1;
      end
      
   end
end

save('data.mat', 'Train_DAT', 'Test_DAT', 'Image_row_NUM', 'Image_column_NUM', 'Train_NUM', 'Test_NUM', 'Class_Train_NUM', 'Class_Test_NUM', 'Class_NUM')