function [imOut] = medianFilt(im, sz)
% perform median filtering operation
%
% Lucas Gillette
% 11/5/2022

[row, col] = size(im);
imOut = zeros(size(im));

windowSize = (sz - 1)/2;

for r = windowSize + 1:row - windowSize
   for c = windowSize + 1:col - windowSize
      window =  im(r-windowSize:r+windowSize, c-windowSize:c+windowSize);
      imOut(r, c) = median(window, 'all');
   end
end

end