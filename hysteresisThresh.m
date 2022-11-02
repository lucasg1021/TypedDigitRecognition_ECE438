function imThresh = hysteresisThresh(inputImage, hThresh, lThresh)
% perform hysteresis thresholding of input image using high and low thresh
%
% Lucas Gillette
% 11/2/2022

imThresh = zeros(size(inputImage));
% get locations that are larger than high value
[rH, cH] = find(inputImage > hThresh);

% look for values above low threshold around high threshold values
% use 8 connectivity

for k = 1:length(rH)
    imThresh(rH(k), cH(k)) = 255;
    for r1 = -1:1
        for c1 = -1:1
            if inputImage(rH(k)+r1, cH(k)+c1) > lThresh
                imThresh(rH(k)+r1, cH(k)+c1) = 255;
            end
        end
    end
end

end