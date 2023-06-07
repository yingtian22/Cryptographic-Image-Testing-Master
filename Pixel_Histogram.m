function Pixel_Histogram(~,~)
    [filename, pathname] = uigetfile('*.*', 'Please select an image file');
    img_path = fullfile(pathname, filename);
    figure( 'Name', 'Pixel_Histogram','NumberTitle', 'off');
    imhist(imread(img_path));
end
