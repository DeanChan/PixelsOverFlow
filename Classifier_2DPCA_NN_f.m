function Class_No=Classifier_2DPCA_NN_f(Train_DAT,Test_DAT)


if nargin < 2, 
    error('Not enought arguments!'); 
end

[Image_row_NUM, projV_NUM, Class_Train_NUM, Class_NUM]=size(Train_DAT);
[Image_row_NUM, projV_NUM, Class_Test_NUM, Class_NUM]=size(Test_DAT);


for k=1:1
   for m=1:Class_Test_NUM 
    
    Test=Test_DAT(:,:,m,k);
    
    min_dist=1e+30;
    for t=1:Class_NUM
      for s=1:Class_Train_NUM 
         Train=Train_DAT(:,:,s,t);
         V=Test-Train;
         
         dist=0;
         for r=1:projV_NUM
           dist=dist+norm(V(:,r),2); 
         end

        if min_dist>dist
          min_dist=dist;
          Class_No=t;
       end
      end
    end

   end
 end

