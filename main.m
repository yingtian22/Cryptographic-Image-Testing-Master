clear; 
clc; 
%************************************************************%
% author:Zhang Tianshuo                                      %
% email:zhang.tianshuo@163.com                               %                  
%************************************************************%
figure('name','Cryptographic Image Security Evaluation System','NumberTitle','off','Position',[300, 300, 700, 600]);
ha=axes('units','normalized','position',[0,0,1,1]);
uistack(ha,'down')
II=imread('Encrypted background.jpg');
image(II)
colormap gray
set(ha,'handlevisibility','off','visible','off');
%%
ImageIntegratedIesting=uicontrol('Style', 'pushbutton', ...
    'String', 'Cryptographic Image Security Assessment', 'Position', [250, 500, 200, 40]);
ImageIntegratedIesting.Callback = @IntegratedIesting; 
%%
ImagePixel_Histogram = uicontrol('Style', 'pushbutton', ...
    'String', 'Pixel Histogram', 'Position', [100, 300, 80, 40]);
ImagePixel_Histogram.Callback = @Pixel_Histogram;  
%%
ImageThreedVisualization = uicontrol('Style', 'pushbutton', ...
    'String', 'Threed Visualization', 'Position', [300, 300, 80, 40]);
ImageThreedVisualization.Callback = @ThreedVisualization;  
%%
ImageCorrelationTesting = uicontrol('Style', 'pushbutton', ...
    'String', 'Correlation testing', 'Position', [500, 300, 80, 40]);
ImageCorrelationTesting.Callback = @CorrelationTesting;  
%%
ImageEntropy = uicontrol('Style', 'pushbutton', ...
    'String', 'Information Entropy', 'Position', [100, 200, 80, 40]);
ImageEntropy.Callback = @entropy;  
%%
ImageCorrelation = uicontrol('Style', 'pushbutton', ...
    'String', 'Correlation', 'Position', [300, 200, 80, 40]);
ImageCorrelation.Callback = @ImCoef;  
%%
ImageTestXquareUniform = uicontrol('Style', 'pushbutton', ...
    'String', 'test x square', 'Position', [500, 200, 80, 40]);
ImageTestXquareUniform.Callback = @test_x_square_uniform;  