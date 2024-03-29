%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     ECE438 Final Project Fall 2022
%
%      Chad Robke & Lucas Gillette
%
%   Typed optical character recognition
%              Digits 0-9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [num, imOut] = test_char_rec_func(im)

num = -1;

% if RGB convert to grayscale
im = rgb2gray(im);

% invert image and perform hysteresis threshold
im = 255 - im;
im = cast(medianFilt(im, 11), 'uint8');

im = hysteresisThresh(im, 200, 100);

% close holes
im = closing(im);

% perform thresholding operation, invert, and crop image to object
im = threshCropIm(im);

% get image dimensions
[rowSize, colSize] = size(im);

% find euler number
% e = -1 if 2 holes, e = 0 for 1 hole, e = 1 for no holes
[convex, concave, euler] = euler_num(im);

imOut = im;

% only number with 2 holes is an 8
if euler == -1
    strOut = '8';
    num = 8;
    
% if 1 hole must be 0, 4, 6, or 9
elseif euler == 0
%     % get area and centroid
%     [area, centroid] = area_centroid_binary(im);
%     
%     imtop = im(1:centroid(1), :);
%     imbot = im(centroid(1):end, :);
%     
%     [areaTop, ~] = area_centroid_binary(imtop);
%     [areaBot, ~] = area_centroid_binary(imbot);
%     
%     ratio = areaTop/areaBot;
%     centLoc = centroid/[rowSize colSize];
%     
%     if .99 < ratio && 1.1 > ratio && 0.49 < centLoc && .51 > centLoc
%        strOut = '0';
%        num = 0;
%        return;
%     end
    % split image in half
    imBot = im(floor(rowSize/2):end, :);
    imTop = im(1:floor(rowSize/2), :);
    imMid = im(floor(rowSize/3):floor(2*rowSize/3), :);

    
    pattern = ones(2*floor(floor(rowSize/2*.65)/2)+1, 1)*255;
    
    value = hitOrMiss(imTop(:, floor(colSize/2):end), pattern);
    
    if value > 0
        value = hitOrMiss(imTop(:, 1:floor(colSize/2)), pattern);
        
        if value > 0
            value = hitOrMiss(imBot(:, 1:floor(colSize/2)), pattern);
            if value > 0
               num = 0;
               return;
            else
                num = 9;
                return;
            end
        else
           num = 4;
           return;
        end
    else
        pattern = ones(1, 2*floor(floor(colSize*.5)/2)+1)*255;
        valueMid = hitOrMiss(imMid, pattern);
        
        if valueMid > 0
            num = 6;
            return;
        else
            num = 0;
            return;
        end
    end
    
    
% else if no holes must be 1, 2, 3, 5, or 7
else
    % look for large vertical line for 1
    pattern = ones(2*floor(floor(rowSize*.9)/2)+1, 1)*255;
    value = hitOrMiss(im, pattern);
    
    if value > 0
        strOut = '1';
        num = 1;
        return;
    end
    
    % check if 2
    % get bottom half of image
    imBot = im(floor(rowSize/2):end, :);
    pattern = ones(1, 2*floor(floor(colSize*.85)/2)+1)*255;
    valueBot = hitOrMiss(imBot, pattern);

    % get top half of image
    imTop = im(1:floor(rowSize/2), :);
    pattern = ones(1, 2*floor(floor(colSize*.85)/2)+1)*255;
    valueTop = hitOrMiss(imTop, pattern);
    
    imMid = im(floor(rowSize/3):floor(2*rowSize/3), :);
    pattern = ones(1, 2*floor(floor(colSize*.5)/2)+1)*255;
    valueMid = hitOrMiss(imMid, pattern);
    
    imTopLeft = im(1:floor(rowSize/2), 1:floor(colSize/2));
    pattern = ones(2*floor(floor(rowSize/2*.6)/2)+1, 1)*255;
    valueTopLeft = hitOrMiss(imTopLeft, pattern);
    
    if valueTop > valueBot || (valueTopLeft > 0 && valueBot < 1000)
        % must be 7 or 5 - hit or miss on bottom half
        pattern = ones(1, 2*floor(floor(colSize*.5)/2)+1)*255;
        value = hitOrMiss(imBot, pattern);

        if value > 0
            strOut = '5';
            num = 5;
            return;
        else
            strOut = '7';
            num = 7;
            return;
        end
    
    elseif valueBot > valueTop
        if valueMid > 0
            strOut = '3';
            num = 3;
            return;
        else
            strOut = '2';
            num = 2;
            return; 
        end
    
    end

   strOut = '3'; 
   num = 3;
   return

end

end