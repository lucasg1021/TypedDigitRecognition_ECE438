function im = getInputImage()
% Asks user for input image
%
% Lucas Gillette ECE438 Final Project 
% 10/31/2022

[file, path] = uigetfile({'*jpeg'; '*.png'; '*jpg'; '*bmp'; '*tiff'; '*.*'},...
    'Select Input Image');

if file == 0
    error('No input image selected');
end

fullFilePath = fullfile(path, file);
im = imread(fullFilePath);


end