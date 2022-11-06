function [outputImage] = sobel_mag(inputImage)
% Returns magnitude image of sobel edge detection
%
% Lucas Gillette ECE438 Lab 4

[rowSize, columnSize, bandSize] = size(inputImage);
inputImage = cast(inputImage, "double");

vertMask = [-1 -2 -1;0 0 0;1 2 1];
horizMask = [-1 0 1;-2 0 2;-1 0 1];

outputImage = zeros(rowSize, columnSize, bandSize);
s1 = zeros(rowSize, columnSize, bandSize);
s2 = zeros(rowSize, columnSize, bandSize);

for b = 1:bandSize
    for i = 2:rowSize-1
        for j = 2:columnSize-1
            s1(i, j, b) = sum(sum(inputImage(i-1:i+1, j-1:j+1, b) .* vertMask));
            s2(i, j, b) = sum(sum(inputImage(i-1:i+1, j-1:j+1, b) .* horizMask));  
        end % end for
    end % end for    
    outputImage(:, :, b) = sqrt(double(s1(:, :, b).^2 + s2(:, :, b).^2));
end % end for

% remap values
for b = 1:bandSize
    maxVal = max(max(outputImage(:, :, b)));
    for i = 1:rowSize
        for j = 1:columnSize
            outputImage(i, j, b) = outputImage(i, j, b)/maxVal * 255;
            if outputImage(i, j, b) > 255
                outputImage(i, j, b) = 255;
            end
        end % end for
    end % end for
end % end for
outputImage = cast(outputImage, 'uint8');
end