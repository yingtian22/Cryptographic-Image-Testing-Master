function ImCoef(~,~) 
    [filename, pathname] = uigetfile('*.*', 'Please select an image file');
    img_path = fullfile(pathname, filename);
    f=imread(img_path);
    N=2000;
    A=double(f);[m,n]=size(A);r=zeros(1,4);
    x1=mod(floor(rand(1,N)*10^10),m-1)+1;
    x2=mod(floor(rand(1,N)*10^10),m)+1;
    x3=mod(floor(rand(1,N)*10^10),m-1)+2;
    y1=mod(floor(rand(1,N)*10^10),n-1)+1;
    y2=mod(floor(rand(1,N)*10^10),n)+1;
    u1=zeros(1,N);u2=zeros(1,N);u3=zeros(1,N);u4=zeros(1,N);
    v1=zeros(1,N);v2=zeros(1,N);v3=zeros(1,N);v4=zeros(1,N);
    for i=1:N
        u1(i)=A(x1(i),y2(i));v1(i)=A(x1(i)+1,y2(i));
        u2(i)=A(x2(i),y1(i));v2(i)=A(x2(i),y1(i)+1);
        u3(i)=A(x1(i),y1(i));v3(i)=A(x1(i)+1,y1(i)+1);
        u4(i)=A(x3(i),y1(i));v4(i)=A(x3(i)-1,y1(i)+1);
    end
    r(1)=mean((u1-mean(u1)).*(v1-mean(v1)))/(std(u1,1)*std(v1,1));
    r(2)=mean((u2-mean(u2)).*(v2-mean(v2)))/(std(u2,1)*std(v2,1));
    r(3)=mean((u3-mean(u3)).*(v3-mean(v3)))/(std(u3,1)*std(v3,1));
    r(4)=mean((u4-mean(u4)).*(v4-mean(v4)))/(std(u4,1)*std(v4,1));
    fprintf('*************************************************\n');
    fprintf('The horizontal correlation of images is:%f\n',r(1));
    fprintf('The vertical correlation of the image is:%f\n',r(2));
    fprintf('The diagonal correlation of the image is:%f\n',r(3));
end