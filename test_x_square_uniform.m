function test_x_square_uniform(~,~)  
    [filename, pathname] = uigetfile('*.*', 'Please select an image file');
    img_path = fullfile(pathname, filename);
    f=imread(img_path);
    [m,n]=size(f);
    f = double(f); 
    xh = hist( f(:),256);  
    p=(m*n)/256;     
    d=0;
    for i=1:256
        t=((xh(i)-p)^2)/p;      
        d=d+t;
    end
    fprintf('*************************************************\n');
    fprintf('The x-squared value of the image is:%f\n',d);
end