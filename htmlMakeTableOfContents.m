%% htmlMakeTableOfContents
%
% Generate TABLE_OF_CONTENTS.m from filenames and descriptions
% 
%% Syntax
% 
% htmlWriteReadMe(ReadMeParameters)
% 
%% Description
% 
% htmlMakeTableOfContents writes the names and descriptions of the files in
% CodeNotes to a TABLE_OF_CONTENTS.m file in the code directory
% 
% * TableParameters.CodeNotes.name  - name for this code group
% * TableParameters.CodeNotes.code  - N-by-P cell array. N is the
% number of files. Columen one of P is the filename with its file extension
% and column two of P is the file description.
% * TableParameters.directoryCode  - directory containing code
% * TableParameters.projectName     - name that will appear
% at the top of the TABLE_OF_CONTENTS.m file
% 
% The TABLE_OF_CONTENTS.m file contains alpabetically sorted file
% descriptions with links to html files. If Matlab's 'publish' function is
% run on all files in the code directory, a TABLE_OF_CONTENTS.html file
% will be generated from this.
%
%% Example
%
%  CodeDescriptions.stimuli.name = 'Stimuli';
%  CodeDescriptions.stimuli.code = { 
% 'createImagePatches_v001.m'     'Create images with highlighted patches for labeling in Mech Turk';
% 'fMRIprotocolCalculations_v001.m'   'Calculate numbers of stimuli and timing'};
%  TableParameters.CodeNotes = CodeNotes;
%  TableParameters.directoryCode = directoryCode;
%  TableParameters.projectName = 'Pathways';
% 
%% See also
%
% * htmlPublishDirectory
% 
% Michael F. Bonner | University of Pennsylvania | <http://www.michaelfbonner.com> 



%% Function

function htmlMakeTableOfContents(TableParameters)


%% Assign variables

CodeNotes = TableParameters.CodeNotes;
directoryCode = TableParameters.directoryCode;
projectName = TableParameters.projectName;

% Get code groups
codeGroups = fieldnames(CodeNotes);
nCodeGroups = length(codeGroups);



%% Write to TABLE_OF_CONTENTS.m
% 
% TABLE_OF_CONTENTS.m is formatted to generate an easily readable HTML file
% (TABLE_OF_CONTENTS.html) when passed to the Matlab's 'publish' function.

% Start writing to file
outputFileName = 'TABLE_OF_CONTENTS.m';
outputFullFile = fullfile(directoryCode, outputFileName);
fileID = fopen(outputFullFile, 'w');

% Toolbox header information 
fprintf(fileID, '%s \n', ['%% ' projectName]);
fprintf(fileID, '%s \n', ['% Code for ' projectName]);
fprintf(fileID, '%s \n', '%');

% Write code information to README
for iCodeGroups = 1 : nCodeGroups
    
    % Get code groups
    thisCodeGroupField = codeGroups{iCodeGroups};
    thisCodeGroupName = CodeNotes.(thisCodeGroupField).name;
    theseCodeDescriptions = CodeNotes.(thisCodeGroupField).code;
    
    % Sort code alphabetically
    codeNames = theseCodeDescriptions(:, 1);
    [codeNamesSorted, sortingIndices] = sort(codeNames);
    codeDescriptionsSorted = theseCodeDescriptions(sortingIndices, 2);
 
    % Code group header information
    fprintf(fileID, '%s \n', ['%% ' thisCodeGroupName]);
    fprintf(fileID, '%s \n', '%');
    
    % Code information
    nCode = size(theseCodeDescriptions, 1);
    for iCode = 1 : nCode
        thisCodeName = codeNamesSorted{iCode};
        [~, thisCodeNameNoExtension, ~] = fileparts(thisCodeName);
        thisCodeFullfile = fullfile(directoryCode, thisCodeName);
        thisCodeDescription = codeDescriptionsSorted{iCode};
        fprintf(fileID, '%s \n', ['% * <file:' thisCodeNameNoExtension '.html ' thisCodeName '> - ' thisCodeDescription ' | <file:' thisCodeFullfile ' code>']);
    end
  
end  % iCodeGroups loop
  
fclose(fileID);


end  % function htmlMakeTableOfContents(TableParameters)

