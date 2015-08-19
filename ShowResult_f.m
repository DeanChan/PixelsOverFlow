function ShowResult_f(Class_No)

load DATABASE.mat

Range=[(Class_No-1)*410+1 Class_No*410];

figure,
for i=1:10
    index=randi(Range);
    subplot(2,5,i),imshow(uint8(DATABASE(:,:,:,index)));
end