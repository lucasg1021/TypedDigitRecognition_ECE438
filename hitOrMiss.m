function [val] = hitOrMiss(im, pattern)
% searches for pattern in image, returns number of times found
%
% Lucas Gillette 
% 11/6/2022

[rows, cols] = size(im);
[rowsP, colsP] = size(pattern);

szR = floor(rowsP/2);
szC = floor(colsP/2);

val = 0;
for i = szR+1:rows-szR
   for j = szC+1:cols-szC
      window = im(i-szR:i+szR, j-szC:j+szC);
      
      if isequal(window, pattern)
         val = val + 1; 
      end
   end
end

end