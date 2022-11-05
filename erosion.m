function [outputImage] = erosion(inputImage)
% Performs erosion operation - allows user to input values for 9x9 SE or
% default to square
%
% Lucas Gillette ECE438 Lab6

[rowSize, colSize, bandSize] = size(inputImage);

if bandSize > 1
   warning("Cannot be a color image");
   return;
end

while true
    % fprintf("Enter 0 for default structuring element (cross) or 1 to enter custom:");
    select = 0; % don't ask for SE

    % structuring element
    SE = zeros(3, 3);
    if select
        for i = 1:3
            for j = 1:3
                fprintf("Enter value for (r, c) location (%d, %d):", i, j);
                val = input(" ");
                if val == 1 || val == 0
                    SE(i, j) = val;
                else
                    warning("Value must be 0 or 1!");
                    return;
                end
            end
        end % end for
    else
        SE = [0 0 1 0 0; 0 0 1 0 0; 1 1 1 1 1; 0 0 1 0 0; 0 0 1 0 0;];
    end % end if

    SE = cast(SE, 'uint8');
    % create copy of image
    inputImageBin = inputImage/255;
    outputImage = zeros(rowSize, colSize);
    outputImage(:, :) = inputImage(:, :);
    window = zeros(5);
    flag = 0;

    % loop thru input image
    for i = 3:rowSize-2
        for j = 3:colSize-2
            if inputImageBin(i, j) == 1
                window(:, :) = inputImageBin(i-2:i+2, j-2:j+2);
                for k = 1:5
                    for z = 1:5
                        if(SE(k, z) == 1 && window(k, z) == 0)
                            flag = 1;
                            outputImage(i, j) = 0;
                        end
                        if flag == 1
                            break;
                        end
                    end
                    if flag == 1
                        flag = 0;
                        break;
                    end
                end
            end
        end
    end

    return;
end
end