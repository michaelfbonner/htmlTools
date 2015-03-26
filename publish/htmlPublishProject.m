%% htmlPublishProject
%
% Publish all m-files associated with a project to HTML
% 
%% Syntax
% 
% htmlPublishProject(PublishProjectParameters)
% 
%% Description
% 
% htmlPublishProject calls htmlMakeTableOfContents and htmlPublishDirectory
% to publish all the code that has been documented in the CodeNotes
% structure (see htmlMakeTableOfContents).
% 
% *  PublishProjectParameters.CodeNotes     - this is the CodeNotes field
% in TableParameters that is passed to htmlMakeTableOfContents
% * PublishProjectParameters.projectName  - name that will appear
% at the top of the TABLE_OF_CONTENTS file
% * PublishProjectParameters.directoryProject   - directory where the
% documentation folder will be written
%
%% Example
%
%  PublishProjectParameters.CodeNotes = CodeNotes;
%  PublishProjectParameters.projectName = projectName;
%  PublishProjectParameters.directoryProject = directoryProject;
%  htmlPublishProject(PublishProjectParameters)
% 
%% See also
%
% * <file:htmlMakeTableOfContents.html htmlMakeTableOfContents>
% * <file:htmlPublishDirectory.html htmlPublishDirectory>
% 
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Function

function htmlPublishProject(PublishProjectParameters)


%% Assign variables

CodeNotes = PublishProjectParameters.CodeNotes;
projectName = PublishProjectParameters.projectName;
directoryProject = PublishProjectParameters.directoryProject;



%% Create table of contents file
%
% Write a TABLE_OF_CONTENTS.m that is formatted to generate an
% TABLE_OF_CONTENTS.html file

TableParameters.CodeNotes = CodeNotes;
TableParameters.directoryCode = directoryProject;
TableParameters.projectName = projectName;
htmlMakeTableOfContents(TableParameters);



%% Publish code

% Sub-directories
directoryNames = fieldnames(CodeNotes);
nDirectoryNames = length(directoryNames);

% Publish code in each sub-directory
for iDirectoryNames = 1 : nDirectoryNames
    
    thisDirectoryName = directoryNames{iDirectoryNames};
    PublishParameters.directoryCode = thisDirectoryName;
    PublishParameters.directoryProject = directoryProject;
    htmlPublishDirectory(PublishParameters)
    
end

% Publish anything in the main project directory
PublishParameters.directoryCode = directoryProject;
PublishParameters.directoryProject = directoryProject;
htmlPublishDirectory(PublishParameters)



%% Clean up project directories

% Remove the unecessary TABLE_OF_CONTENTS.m file
tableOfContentsMfile = fullfile(directoryProject, 'TABLE_OF_CONTENTS.m');
delete(tableOfContentsMfile);

% Remove the unecessary CodeDescriptions.html file
directoryDocumentation = fullfile(directoryProject, 'Documentation');
tableOfContentsMfile = fullfile(directoryDocumentation, 'CodeDescriptions.html');
if exist(tableOfContentsMfile, 'file')
    delete(tableOfContentsMfile);
end


end  % function htmlPublishProject(PublishProjectParameters)


