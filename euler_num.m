function [convex, concave, euler] = euler_num(inputImage)
% Function to get the number of convexities and concavities in a binary
% image and calculate the euler number based on those
%
% Lucas Gillette ECE438 Lab3

[rowSize, colSize, bandSize] = size(inputImage);

mat_convex = [0 0; 0 255];
mat_concave = [0 255; 255 255];

if bandSize == 1
    convex = 0;
    concave = 0;
    for i = 1:rowSize-1
        for j = 1:colSize-1
            if(inputImage(i:i+1, j:j+1) == mat_convex)
                convex = convex + 1;

            elseif(inputImage(i:i+1, j:j+1) == mat_concave)
                concave = concave + 1;

            end %end if
        end %end for
    end %end for

else
   warning("Input image must be binary!");
   convex = 0; concave = 0;
end
euler = convex - concave;
end %end function

