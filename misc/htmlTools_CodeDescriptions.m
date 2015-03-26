%% htmlTools_CodeDescriptions  
%
% Generate HTML documentation from filenames and descriptions
% 
%% Syntax
% 
% htmlTools_CodeDescriptions
% 
%% Description
% 
% The name and description of each code file should be entered into the
% CodeNotes structure. These will be written to a TABLE_OF_CONTENTS.m file.
% This and all other m-files in this directory will be published to the
% HTML documentation.
% 
%
%% Example
%
%  htmlTools_CodeDescriptions;
% 
%% See also
% 
% * TABLE_OF_CONTENTS
% * htmlMakeTableOfContents
% * htmlPublishDirectory
% * htmlPublishProject
%
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Assign variables

projectName = 'htmlTools';

% Project directory
thisFullPath = mfilename('fullpath');
directoryMisc = fileparts(thisFullPath);
directoryProject = fileparts(directoryMisc);
cd(directoryProject);



%% Notes on publish directory

thisDirectory = 'publish';
CodeNotes.(thisDirectory).name = thisDirectory;
CodeNotes.(thisDirectory).code = {
   
'htmlMakeTableOfContents.m'     'Generate TABLE_OF_CONTENTS.m from filenames and descriptions';
'htmlPublishDirectory.m'   'Publish all m-files in a directory to HTML';
'htmlPublishProject.m'  'Publish all m-files associated with a project to HTML';

};



%% Notes on display directory

thisDirectory = 'display';
CodeNotes.(thisDirectory).name = thisDirectory;
CodeNotes.(thisDirectory).code = {
   
'htmlMakeImagePage.m'     'Create an html document to display images';

};



%% Publish project

PublishProjectParameters.CodeNotes = CodeNotes;
PublishProjectParameters.projectName = projectName;
PublishProjectParameters.directoryProject = directoryProject;
htmlPublishProject(PublishProjectParameters)

