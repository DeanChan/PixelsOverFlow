function [disc_set,disc_value,Mean_Image]=IMPCA_f(Train_DAT,projV_NUM)

% Face feature extraction using 2DPCA

[N,M,Train_NUM]=size(Train_DAT);

Mean_Image=mean(Train_DAT,3);

S=zeros(M,M);
for k=1:Train_NUM
   V=Train_DAT(:,:,k)-Mean_Image;
   S=S+V'*V;   
end

Gt=S/Train_NUM;

[disc_set,Dt]=eigs(Gt,projV_NUM); % return the K largest magnitude eigenvalues.
disc_value=diag(Dt);
