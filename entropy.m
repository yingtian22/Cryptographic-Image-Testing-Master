function entropy(~,~)  
    [filename, pathname] = uigetfile('*.*', 'Please select an image file');
    img_path = fullfile(pathname, filename);
    f=imread(img_path);
    pixel_level=256;
    f = double(f);
    xh = hist( f(:), pixel_level);
    xh = xh / sum(xh(:));
    i = find(xh); 
    entropy_value = - sum(xh(i).*log2(xh(i)));
    fprintf('*************************************************\n');
    fprintf('The information entropy of the image is:%f\n',entropy_value);
end