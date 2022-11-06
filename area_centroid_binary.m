function [areaIm, centroidIm] = area_centroid_binary(inputImage)

% Finds the area and center of area of binary image assuming 1 object
%
% Lucas Gillette ECE438 Lab 3

% get size of input image
[rowSize, colSize, bandSize] = size(inputImage); 

if bandSize == 1
    % Area
    % loop thru image and sum
    areaIm = 0;
    for i = 1:rowSize
        for j = 1:colSize
            if(inputImage(i, j, 1) == 255)
                areaIm = areaIm + 1;
            end % end if
        end % end for
    end % end for

    % Center of area
    % Keep running total for rows and columns, increment by row/column * 1
    rsum = 0;
    csum = 0;
    for i = 1:rowSize
        for j = 1:colSize
            if(inputImage(i, j, 1) == 255)
                rsum = rsum + i*1;
                csum = csum + j*1;
            end % end if
        end % end for
    end % end for

    r_cent = 1/areaIm * rsum;
    c_cent = 1/areaIm * csum;

    centroidIm = [round(r_cent) round(c_cent)];

else
   warning("Input image must be binary!");
   areaIm = 0;
   centroidIm = [1 1];
   return
end
end % end function