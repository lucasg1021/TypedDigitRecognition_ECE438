%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     ECE438 Final Project Fall 2022
%
%      Chad Robke & Lucas Gillette
%
%   Typed optical character recognition
%              Digits 0-9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get input image from user
fprintf('Select Input Image\r\n\n');
im = getInputImage();

% if RGB convert to grayscale
im = rgb2gray(im);

% invert image and perform hysteresis threshold
im = 255 - im;
im = cast(medianFilt(im, 11), 'uint8');

im = hysteresisThresh(im, 225, 100);

% close holes
im = closing(im);

% perform thresholding operation, invert, and crop image to object
im = threshCropIm(im);

% find euler number
% e = -1 if 2 holes, e = 0 for 1 hole, e = 1 for no holes
[convex, concave, euler] = euler_num(im);

% only number with 2 holes is an 8
if euler == -1
    strOut = '8';
    
% if 1 hole must be 0, 4, 6, or 9
elseif euler == 0
    
% else if no holes must be 1, 2, 3, 5, or 7
else
    strOut = '';
end


fprintf("Number is %s\r\n", strOut);