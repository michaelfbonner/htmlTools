%% htmlPublishDirectory
% 
% Publish all m-files in a directory to HTML
% 
%% Syntax
% 
% htmlPublishDirectory(PublishParameters)
% 
%% Description
% 
% htmlPublishDirectory publishes all m-files in a directory to HTML files.
% It also saves a 'DatesEdited.mat' file. Subsequent calls of this function
% for the same directory will only publish m-files that have been created
% or edited since the last call. The HTML files are written to a directory
% titled 'CodeNotes'.
% 
% * PublishParameters.directoryCode         - directory with m-files
% 
% The edit dates for each m-file are saved to 'DatesEdited.mat', which
% contains:
% 
% * DatesEdited         - Contains fields for each m-file with their most
% recent edit date
%
%% Example
%
%  PublishParameters.directoryCode = '/Users/michaelbonner/iMac_Projects/Pathways/Code';
%  htmlPublishDirectory(PublishParameters)
% 
%% See also
% 
% * htmlMakeTableOfContents
% 
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Function

function htmlPublishDirectory(PublishParameters)


%% Publish to html

directoryCode = PublishParameters.directoryCode;

searchTerm = fullfile(directoryCode, '*.m');
matlabFiles = dir(searchTerm);
nMatlabFiles = length(matlabFiles);

directoryOutput = fullfile(directoryCode, 'Documentation');

% Load in DatesEdited if it exists
DatesEditedFullfile = fullfile(directoryOutput, 'DatesEdited.mat');
if exist(DatesEditedFullfile, 'file')
    load(DatesEditedFullfile);
    % Loads:
    % * DatesEdited  - structure with dates when the m-files were
    % last edited (or created)
else
    DatesEdited = struct();
end

% Publish new or newly edited files
for iMatlabFiles = 1 : nMatlabFiles
    
    thisFile = matlabFiles(iMatlabFiles).name;
    thisFullfile = fullfile(directoryCode, thisFile);
    [~, thisFileName, ~] = fileparts(thisFile);
    
    mostRecentEditDate = matlabFiles(iMatlabFiles).datenum;
    
    isNew = true;
    if isfield(DatesEdited, thisFileName)
        previousEditDate = DatesEdited.(thisFileName);
        dateComparison = mostRecentEditDate - previousEditDate;
        isNew = dateComparison > 0;
    end
        
    % Publish if the file is totally new or newly edited
    if isNew  
        publish(thisFullfile, 'evalCode', false, 'outputDir', directoryOutput);
        DatesEdited.(thisFileName) = mostRecentEditDate;  % update edit date
    end
 
end

save(DatesEditedFullfile, 'DatesEdited');


end  % function htmlPublishDirectory(PublishParameters)




