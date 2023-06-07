function ThreedVisualization(~,~)
    [filename, pathname] = uigetfile('*.*', 'Please select an image file');
    img_path = fullfile(pathname, filename);
    figure( 'Name', 'Threed Visualization','NumberTitle', 'off');
    I=imread(img_path);
    i=1:1:512;
    j=1:1:512;
    K=I(i,j);
    mesh(i,j,K);
end
