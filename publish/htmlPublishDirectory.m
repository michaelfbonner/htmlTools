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
% * PublishParameters.directoryCode     - directory with m-files
% * PublishParameters.directoryProject  - directory where the documentation
% folder will be written
% 
% The edit dates for each m-file are saved to 'DatesEdited.mat', which
% contains:
% 
% * DatesEdited         - Contains fields for each m-file with their most
% recent edit date
%
%% Example
%
%  PublishParameters.directoryCode = directoryToolbox;
%  htmlPublishDirectory(PublishParameters)
% 
%% See also
% 
% * <file:htmlMakeTableOfContents.html htmlMakeTableOfContents>
% * <file:htmlPublishProject.html htmlPublishProject>
% 
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Function

function htmlPublishDirectory(PublishParameters)


%% Assign variables

% Directories
directoryCode = PublishParameters.directoryCode;
directoryProject = PublishParameters.directoryProject;
directoryOutput = fullfile(directoryProject, 'Documentation');
if ~exist(directoryOutput, 'dir')
    mkdir(directoryOutput);
end

% Files to publish
searchTerm = fullfile(directoryCode, '*.m');
matlabFiles = dir(searchTerm);
nMatlabFiles = length(matlabFiles);

% Load in DatesEdited which keeps a log of when the code files were last
% edited. This allows us to avoid re-publishing html documentation that
% already exists
DatesEditedFullfile = fullfile(directoryOutput, 'DatesEdited.mat');
if exist(DatesEditedFullfile, 'file')
    load(DatesEditedFullfile);
    % Loads:
    % * DatesEdited  - structure with dates for when the m-files were
    % last edited (or created)
else
    DatesEdited = struct();
end



%% Publish to html

% Publish any new or newly edited files
for iMatlabFiles = 1 : nMatlabFiles
    
    % File path and name
    thisFile = matlabFiles(iMatlabFiles).name;
    thisFullfile = fullfile(directoryCode, thisFile);
    [~, thisFileName, ~] = fileparts(thisFile);
    
    % Most recent edit date that was published to html
    mostRecentEditDate = matlabFiles(iMatlabFiles).datenum;
    
    % Check if the file has been edited since the mostRecentEditDate
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

% Save a log of the current edit dates
save(DatesEditedFullfile, 'DatesEdited');


end  % function htmlPublishDirectory(PublishParameters)




