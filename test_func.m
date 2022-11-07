%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Test script for character recognition
%
%   Lucas Gillette
%
%   11/6/2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numFolders = 5;
numFiles = numFolders * 10;
numCorrect = 0;

for folders = 1:numFolders  % change first value to test multiple folders
    for fileNum = 0:9
        file = sprintf("Train_%d-2/Train%d-2_%d.jpeg", folders, folders, fileNum);
        
        im = imread(file);
        value = test_char_rec_func(im);
        
        if value == fileNum
           numCorrect = numCorrect + 1; 
        end
        
        fprintf("\r\nFolder %d:\r\n\tGuess: %d\r\n\tActual: %d\r\n", folders, value, fileNum);
    end
end

fprintf("\r\n%d correct out of %d\r\n", numCorrect, numFiles);
