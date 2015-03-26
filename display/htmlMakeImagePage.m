%% htmlMakeImagePage
%
% Create an html document to display images
% 
%% Syntax
% 
% htmlMakeImagePage(fileNamesImages, fileNameHtml, nImagesPerParagraph)
% 
%% Description
% 
% htmlMakeImagePage generates an HTML document for displaying a series of
% images. This is a convenient to view lots of data all at once.
% 
% * fileNamesImages     - cell array of file names for images                       
% * fileNameHtml    - name for HTML file that will be generated
% * nImagesPerParagraph     - nummber of images between paragraph breaks
% (default = nan, which creates no paragraph breaks)
%
%% Example
%
%  searchTerm = '*png';
%  searchPath = [directoryOutput searchTerm];
%  fileNamesImages = dir2(directoryOutput, searchTerm, '-r');
%  fileNamesImages = {fileNamesImages.name};
%  thisHtmlName = 'all_images.html';
%  fileNameHtml = fullfile(directoryOutput, thisHtmlName);
%  nImagesPerParagraph = 4;
%  htmlMakeImagePage(fileNamesImages, fileNameHtml, nImagesPerParagraph);
%  
%  htmlMakeImagePage(fileNamesImages, fileNameHtml);
% 
%% See also
% 
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Function 

function htmlMakeImagePage(fileNamesImages, fileNameHtml, nImagesPerParagraph)


%% Assign variables

nFileNamesImages = length(fileNamesImages);

if nargin < 3
    nImagesPerParagraph = nan;
end



%% Create html document

templateStartText = '<!DOCTYPE html> \n <html> \n <body> \n <p> \n';
templateEndText = '<body> \n <html>';

fileID = fopen(fileNameHtml, 'w');
fprintf(fileID, templateStartText);

imagesInParagraphCounter = 0;
for loopIndexFileNamesImages = 1 : nFileNamesImages
    
    thisImageFileName = fileNamesImages{loopIndexFileNamesImages};
    
    if imagesInParagraphCounter == nImagesPerParagraph;
        
        newParagraphText = '<p> \n <br> <br> <br> <br> <br> <br> ';
        fprintf(fileID, newParagraphText);
        imagesInParagraphCounter = 0;
        
    end
    
    thisImageText = ['<img src="' thisImageFileName '"> &nbsp; &nbsp; &nbsp; &nbsp; \n'];
    
    fprintf(fileID, thisImageText);
    
    imagesInParagraphCounter = imagesInParagraphCounter + 1;
    
end

newParagraphText = '<p> \n <br> <br> <br> <br> <br> <br> ';
fprintf(fileID, newParagraphText);

fprintf(fileID, templateEndText);
fclose(fileID);


end  % function htmlMakeImagePage(fileNamesImages, fileNameHtml, nImagesPerParagraph)

