function im = closing(inputIm)
% perform closing operation
im = dilation(inputIm);
im = erosion(im);
end