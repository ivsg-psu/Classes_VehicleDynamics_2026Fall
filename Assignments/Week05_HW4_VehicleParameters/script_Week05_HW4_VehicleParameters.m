% script_Week05_HW4_VehicleParameters.m
% Assignment for: Week05
% Homework: HW4_VehicleParameters.m
% Written by: sbrennan@psu.edu
% 2026_11_04

% REVISION HISTORY:
%
% 2026_11_04 by Sean Brennan, sbrennan@psu.edu
% - In script_Week05_HW4_VehicleParameters
%   % * First write of the code 
%   % * Using script_Week05_HW4_VehicleParameters as a starter
%
% (new release)

% TO-DO:
% - 2026_11_04 by Sean Brennan, sbrennan@psu.edu
%   % * (add help)

thisName = 'HW4_VehicleParameters';

thisStudentID = fcn_VDCore_getStudentID((figNum));

%% Initialize the Random Number Generator to this specific machine and user
% Build machine-specific ID
host = getenv('COMPUTERNAME'); if isempty(host), host = getenv('HOSTNAME'); end
user = getenv('USERNAME'); if isempty(user), user = getenv('USER'); end
idstr = [host '_' user];

% MD5 hash the string (Java, available in MATLAB)
md = java.security.MessageDigest.getInstance('MD5');
digest = md.digest(uint8(idstr));
hexstr = sprintf('%02x', typecast(digest, 'uint8'));

% Use first 8 hex chars -> 32-bit seed
seed = double(hex2dec(hexstr(1:8)));

% Initialize RNG
rng(seed, 'twister');  % or choose another algorithm


%%

% Fill in test data
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections
selections(1).AssignmentString = thisName;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = num2str(numQuestions);
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = [') Identity information: What is the 7-digit folder number that was emailed to you?' ...
	'\n' ...
	'\n' ...
	'This assignment requires students to calculate the parking maneuver necessary to move into a given parking space.'];
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


%% VehicleParameters2
numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = num2str(numQuestions);
selections(numQuestions).Name = sprintf('VehicleParameters%.0d',numQuestions);
selections(numQuestions).Text = ')  What is the name of the folder, under Week05_HW4_VehicleParameters, where your script and data files are saved (suggestion: ''7XXXXXX_HW4'' with the XXXXXX portion changed to match your Canvas number)?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '_of_char_strings';
selections(numQuestions).AnswerConversionFunction = '';
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).AnswerAllowableRange = [];
selections(numQuestions).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+1)
	};
selections(numQuestions).FunctionPreMenu = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
	};
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = false;
selections(numQuestions).AnswerGradingCorrect = '0';
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'not empty';
selections(numQuestions).AnswerGradingOptions = {[]};


%% VehicleParameters4
numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = num2str(numQuestions);
selections(numQuestions).Name = sprintf('VehicleParameters%.0d',numQuestions);
selections(numQuestions).Text = 'By editing the script given to you, create a file of vehicle parameters for your vehicle, making sure to name it correctly. NOTE: you will have to exit this menu to run your simulations!';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_numbers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.2f';
selections(numQuestions).AnswerAllowableRange = [0 1000];
selections(numQuestions).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+1)
	};
selections(numQuestions).FunctionPreMenu = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
	};
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = false;
selections(numQuestions).AnswerGradingCorrect = '0';
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'exact match';
selections(numQuestions).AnswerGradingOptions = {[], 1};

% %% VehicleParameters5
% numQuestions = numQuestions+1;
% selections(numQuestions).MenuChar = num2str(numQuestions);
% selections(numQuestions).Name = sprintf('VehicleParameters%.0d',numQuestions);
% selections(numQuestions).Text = ') Produce a plot of the XY position. Make sure the title of the plot you produce has your initials so that the assignment is easy to grade. What are your initials?';
% selections(numQuestions).AnswerDefault = '-missing-';
% selections(numQuestions).AnswerType = '_of_char_strings';
% selections(numQuestions).AnswerConversionFunction = '';
% selections(numQuestions).AnswerTypeOptions = [];
% selections(numQuestions).AnswerPrintFormat = '%s';
% selections(numQuestions).AnswerAllowableRange = [];
% selections(numQuestions).FunctionMore = {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+1)
% 	};
% selections(numQuestions).FunctionPreMenu = {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
% 	};
% selections(numQuestions).FunctionMoreInputs = {30};
% selections(numQuestions).FunctionSubmission = { ...
% 	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
% 	};
% selections(numQuestions).FunctionSubmissionOptions = {'.'};
% selections(numQuestions).isAllowableMenuOption = false;
% selections(numQuestions).AnswerGradingCorrect = '0';
% selections(numQuestions).AnswerGradingPoints = 1;
% selections(numQuestions).AnswerGradingType = 'not empty';
% selections(numQuestions).AnswerGradingOptions = {[]};
% 
% %% VehicleParameters6
% numQuestions = numQuestions+1;
% selections(numQuestions).MenuChar = num2str(numQuestions);
% selections(numQuestions).Name = sprintf('VehicleParameters%.0d',numQuestions);
% selections(numQuestions).Text = ') Save your plot as a PNG format, in a file with the name in the form 7XXXXXX_HW4.png, where the number matches your Canvas number. What is the name of the image file you have saved?';
% selections(numQuestions).AnswerDefault = '-missing-';
% selections(numQuestions).AnswerType = '_of_char_strings';
% selections(numQuestions).AnswerConversionFunction = '';
% selections(numQuestions).AnswerTypeOptions = [];
% selections(numQuestions).AnswerPrintFormat = '%s';
% selections(numQuestions).AnswerAllowableRange = [];
% selections(numQuestions).FunctionMore = {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+1)
% 	};
% selections(numQuestions).FunctionPreMenu = {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
% 	};
% selections(numQuestions).FunctionMoreInputs = {30};
% selections(numQuestions).FunctionSubmission = { ...
% 	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
% 	};
% selections(numQuestions).FunctionSubmissionOptions = {'.'};
% selections(numQuestions).isAllowableMenuOption = false;
% selections(numQuestions).AnswerGradingCorrect = '0';
% selections(numQuestions).AnswerGradingPoints = 1;
% selections(numQuestions).AnswerGradingType = 'not empty';
% selections(numQuestions).AnswerGradingOptions = {[]};

%% Grade

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 'g';
selections(numQuestions).Name = 'Grade';
selections(numQuestions).Text = '(G)rade this assignment.';
selections(numQuestions).AnswerDefault = '-unsubmitted-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = sprintf('fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions);
selections(numQuestions).FunctionPreMenu = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
	};
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = { ...
    'overallScore = fcn_DebugTools_gradeAnswers(selections,answers);';
    'assignmentString = selections(1).AssignmentString;';
    'overallScoreString = sprintf(''%%.2f'',overallScore);';
    'studentNumberString = answers{1}; %%  Grab the student number - it is always the first answer';
    'resultString = cat(2,studentNumberString,overallScoreString);';
    'gradeHash = fcn_DebugTools_hashStrings(assignmentString, resultString, ([]));';
    'fcn_DebugTools_cprintf(''*Green'',''Grading completed.'');';
    'fprintf(1,''\\nThe assignment: \\t%%s\\nwas just graded.\\n'',assignmentString)';
    'fprintf(1,''Your score:\\t%%s\\n'',overallScoreString)';
    'fprintf(1,''As the final step, please enter the following code into Canvas for this assignment.\\n%%s\\n'',gradeHash);';
    'fprintf(1,''Press any key to continue\\n'');';
    'pause;';
    'answers{end-2} = ''GRADED'';';
    };
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = false;

%% Submit

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 's';
selections(numQuestions).Name = 'Submit';
selections(numQuestions).Text = '(S)ubmit this assignment.';
selections(numQuestions).AnswerDefault = '-unsubmitted-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = sprintf('fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions);
selections(numQuestions).FunctionPreMenu = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
	};
selections(numQuestions).FunctionMoreInputs = [];
submissionString = cat(2,'submissionFileName = cat(2,''SUBMISSION_',thisName,'_'',answers{1});');
selections(numQuestions).FunctionSubmission = { ...
    submissionString;
    'zipName = fullfile(pwd,''Submissions'',submissionFileName);';
    'typeList = {''var'', ''var'',''dir''};';
    'nameList = {''answers'', ''timelog'',''studentWorkDirectory''};';
	'studentWorkDirectory = fullfile(pwd,''Assignments'',''Week05_HW4_VehicleParameters'',answers{2})'
    'fcn_PrepareSubmission_packageAnswers(zipName, typeList, nameList, answers, timelog, studentWorkDirectory, (1));';
    'fcn_DebugTools_cprintf(''*Green'',''Submission prepared.'');';
    'fprintf(1,''\\nThe file: \\n\\t%%s\\nwas just created.\\n'',zipName)';
    'fprintf(1,''As the final step, you must manually copy this SUBMISSION zip file out of \\nthe ''''Submissions'''' folder and into the OneDrive folder shared with you.\\n This is to force the user to check that files were created and uploaded, before exiting.\\n'');';
    'fprintf(1,''Press any key to continue'');';
    'pause;';
    'answers{end-1} = ''SUBMITTED'';';
    };
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = false;

%% Quit

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 'q';
selections(numQuestions).Name = 'Quit';
selections(numQuestions).Text = '(Q)uit this menu.';
selections(numQuestions).AnswerDefault = ' ';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = sprintf('fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions);
selections(numQuestions).FunctionPreMenu = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+100)
	};
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = 'flag_exitMain = 1; fprintf(1,''Quitting\\n'');';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

% Enter menu loop
fcn_DebugTools_menuManageSelections(selections, (1))




%% Week05_HW4_VehicleParameters
%  0C53085503020353175109
%%
if 1==0
	% Fill in the Canvas IDs
	CanvasIDs = [
		7085227
		7085590
		7145438
		7155055
		7156922
		7157589
		7194990
		7197975
		7199509
		7199628
		7199973
		7199975
		7202507
		7203486
		7203748
		7204194
		7205481
		7205689
		7205928
		7207851
		7210018
		7213254
		7214680
		7215457
		7215757
		7220197
		7222040
		7223846
		7273950
		7363368
		9000000
		9111111
		9222222
        ];

    assignmentString = selections(1).AssignmentString;
    overallScoreString = sprintf('%.2f',1.00);

    fprintf(1,'\n\nGrade Hashes for: %s\n',assignmentString);
    for ith_ID = 1:length(CanvasIDs)
        studentNumberString = sprintf('%.0d',CanvasIDs(ith_ID)); %  Grab the student number - it is always the first answer
        resultString = cat(2,studentNumberString,overallScoreString);
        gradeHash = fcn_DebugTools_hashStrings(assignmentString, resultString, ([]));
        fprintf(1,'%s\n',gradeHash);
    end

end

% Grade Hashes for: Week05_HW4_VehicleParameters
% 0253005001000453175109
% 02530050060B0353175109
% 02520C5007010B53175109
% 02520D5003070653175109
% 02520D530A000153175109
% 02520D52060A0A53175109
% 025201510A0B0353175109
% 025201520A050653175109
% 0252015C06020A53175109
% 0252015C05000B53175109
% 0252015C0A050053175109
% 0252015C0A050653175109
% 0251085706020453175109
% 02510856070A0553175109
% 0251085604060B53175109
% 02510851020B0753175109
% 02510850070A0253175109
% 02510850050A0A53175109
% 025108500A000B53175109
% 025108520B070253175109
% 0251095503030B53175109
% 0251095601070753175109
% 02510951050A0353175109
% 0251095007070453175109
% 0251095004070453175109
% 02510A55020B0453175109
% 02510A5703060353175109
% 02510A560B060553175109
% 02510F560A070353175109
% 02500E5600040B53175109
% 0C53085503020353175109
% 0C52095402030253175109
% 0C510A5701000153175109