function croppedIm = threshCropIm(inputImage, thresh)
% Threshold and crop to binary object in image
%
% Lucas Gillette
% 10/31/2022

% perform threshold and invert
% inputImage(inputImage >= thresh) = 255;
% inputImage(inputImage ~= 255) = 0;
% inputImage = ~inputImage .* 255;

inputImage = 255 - inputImage;
inputImage = hysteresisThresh(inputImage, 100, 50);

% get image size
[rows, cols] = size(inputImage);

% Look for top, bottom, left, and right most pixels in image to crop to
% minimum nonzero row = top, max nonzero row = bottom
% minimum nonzero col = left, max nonzero col = right
top = 1; bottom = rows/2; left = 1; right = cols/2;

for r = 1:rows
    for c = 1:cols
        if inputImage(r, c) == 255
            if top == 1
                top = r;
            end
            bottom = r;
        end % end if
    end % end for
end % end for

for c = 1:cols
    for r = 1:rows
        if inputImage(r, c) == 255
            if left == 1
                left = c;
            end
            right = c;
        end % end if
    end % end for
end % end for

croppedIm = inputImage(top-1:bottom+1, left-1:right+1);

end