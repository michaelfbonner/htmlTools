%% CodeDescriptions  
%
% Generate HTML documentation from filenames and descriptions
% 
%% Syntax
% 
% CODE_DESCRIPTIONS
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
%  CodeDescriptions;
% 
%% See also
% 
% * TABLE_OF_CONTENTS
% * htmlMakeTableOfContents
% * htmlPublishDirectory
%
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Assign variables

projectName = 'htmlTools';
directoryToolbox = pwd;



%% ptbTools

CodeNotes.(projectName).name = projectName;


CodeNotes.(projectName).code = {
    
'htmlMakeTableOfContents.m'     'Generate TABLE_OF_CONTENTS.m from filenames and descriptions';

'htmlPublishDirectory.m'   'Publish all m-files in a directory to HTML';

};



%% Publish code

% Write TABLE_OF_CONTENTS.m (formatted to generate an easily readable HTML
% file)
TableParameters.CodeNotes = CodeNotes;
TableParameters.directoryCode = directoryToolbox;
TableParameters.projectName = projectName;
htmlMakeTableOfContents(TableParameters);

% Publish all code to HTML
PublishParameters.directoryCode = directoryToolbox;
htmlPublishDirectory(PublishParameters)

