function thisStudentID = fcn_VDCore_getStudentID(varargin)
%% fcn_VDCore_getStudentID
% Opens up a submenu system to query student to get their student ID.
%
% FORMAT:
%
%      thisStudentID = fcn_VDCore_getStudentID((figNum))
%
% INPUTS:
%
%      (none)
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      thisStudentID: an integer type that is the student's Canvas ID
%      number
%
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_VDCore_getStudentID
%     for a full test suite.
%
% This function was written on 2026_10_19 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2026_10_19 by Sean Brennan, sbrennan@psu.edu
% - In fcn_VDCore_getStudentID
%   % * First write of the function
%   % * Used fcn_DebugTools_copyStructureSelections as starter

% TO-DO:
% 
% 2026_10_19 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 1; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
    MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG); 
        flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978; %#ok<NASGU>
else
    debug_figNum = []; %#ok<NASGU>
end
%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(MAX_NARGIN-1,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% % Does user want to specify the rangeToPickFrom input?
% rangeToPickFrom = 1:length(fromStructure); % Default is full structure
% if 3 <= nargin
%     temp = varargin{1};
%     if ~isempty(temp)
%         rangeToPickFrom = temp;
%     end
% end
% 
% % Does user want to specify the numToPick input?
% numToPick = length(fromStructure); % Default is to select them all
% if 4 <= nargin
%     temp = varargin{2};
%     if ~isempty(temp)
%         numToPick = temp;
%     end
% end
% 
% % Does user want to specify the flagRandomizeSelections input?
% flagRandomizeSelections = false; % Default is to not randomize
% if 4 <= nargin
%     temp = varargin{1};
%     if ~isempty(temp)
%         flagRandomizeSelections = temp;
%     end
% end

% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp; %#ok<NASGU>
        flag_do_plots = 1;
    end
end


%% Main code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~exist('thisStudentID','var')
	thisName = 'Week00_StudentID';

	% Fill in test data
	numQuestions = 0; % Initialize the number of questions
	selections = struct(); % Create an empty structure array for selections
	selections(1).AssignmentString = thisName;

	numQuestions = numQuestions+1;
	selections(numQuestions).MenuChar = num2str(numQuestions);
	selections(numQuestions).Name = 'WhatNumber';
	selections(numQuestions).Text = ') Identity information: What is the 7-digit folder number that was emailed to you?\n';
	selections(numQuestions).AnswerDefault = '-missing-';
	selections(numQuestions).AnswerType = '1column_of_integers';
	selections(numQuestions).AnswerConversionFunction = 'str2double';
	selections(numQuestions).AnswerTypeOptions = [1 1];
	selections(numQuestions).AnswerPrintFormat = '%.0f';
	selections(numQuestions).AnswerAllowableRange = [7000000 9999999];
	selections(numQuestions).FunctionMore = sprintf('fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions);
	selections(numQuestions).FunctionPreMenu = {[]};
	selections(numQuestions).FunctionMoreInputs = {30};
	selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
	selections(numQuestions).FunctionSubmissionOptions = {'.'};
	selections(numQuestions).isAllowableMenuOption = true;
	selections(numQuestions).AnswerGradingCorrect = nan;
	selections(numQuestions).AnswerGradingPoints = 1;
	selections(numQuestions).AnswerGradingType = 'not empty';
	selections(numQuestions).AnswerGradingOptions = {[]};

	%%%% Quit

	numQuestions = numQuestions+1;
	selections(numQuestions).MenuChar = 'q';
	selections(numQuestions).Name = 'Quit';
	selections(numQuestions).Text = '(Q)uit this submenu.';
	selections(numQuestions).AnswerDefault = ' ';
	selections(numQuestions).AnswerType = '1column_of_integers';
	selections(numQuestions).AnswerConversionFunction = 'str2double';
	selections(numQuestions).AnswerTypeOptions = [1 1];
	selections(numQuestions).AnswerPrintFormat = '%.0f';
	selections(numQuestions).FunctionMore = sprintf('fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions);
	selections(numQuestions).FunctionPreMenu = {[]};
	% selections(numQuestions).FunctionPreMenu = {...
	% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
	% 	};
	selections(numQuestions).FunctionMoreInputs = [];
	selections(numQuestions).FunctionSubmission = 'flag_exitMain = 1; fprintf(1,''Quitting\\n'');';
	selections(numQuestions).FunctionSubmissionOptions = {'.'};
	selections(numQuestions).isAllowableMenuOption = true;

	% Enter menu loop
	fcn_DebugTools_menuManageSelections(selections, (1));


	%%% Grab the seed
	studentIDFile = fullfile(pwd,'Data','answersSoFar_Week00_StudentID.mat');
	if exist(studentIDFile,'file')==2
		variableInfo = whos('-file',studentIDFile);
		variableNames = {variableInfo.name};
		if ~any(strcmp(variableNames,'answers'))
			error('Unable to load student ID out of file. Must exit!');
		else
			load(studentIDFile,'answers');
			thisStudentID = str2double(answers{1});
		end
	else
		error('Unable to continue because student number not found. Please restart and enter the student number!');
	end

end



%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if flag_do_plots

    % Nothing to do here


end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends main function




%% Functions follow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ______                _   _
%  |  ____|              | | (_)
%  | |__ _   _ _ __   ___| |_ _  ___  _ __  ___
%  |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
%  | |  | |_| | | | | (__| |_| | (_) | | | \__ \
%  |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§
