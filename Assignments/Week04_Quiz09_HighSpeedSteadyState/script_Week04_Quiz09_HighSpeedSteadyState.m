% script_Week04_Quiz09_HighSpeedSteadyState
% Assignment for: Week04
% Homework: Week04_Quiz09_HighSpeedSteadyState
% Written by: sbrennan@psu.edu
% 2026_10_02

% REVISION HISTORY:
%
% 2026_10_02 by Sean Brennan, sbrennan@psu.edu
% - In script_Week04_Quiz09_HighSpeedSteadyState
%   % * First write of the code using HW2 as a starter
%
% (new release)

% TO-DO:
% - 2026_10_02 by Sean Brennan, sbrennan@psu.edu
%   % * (add help)

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

thisName = 'Week04_Quiz09_HighSpeedSteadyState';

% Fill in problems
numProblems = 0;

%% High speed behavior
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [')  Which of the following situations characterizes high-speed vehicle behavior? (enter a number from 1 to 4):\n' ...
	'1: the speedometer is reading a high number\n' ...
	'2: there are skid marks on the pavement after the vehicle moves\n' ...
	'3: the vehicle is a sports car\n' ...
	'4: the tires on the vehicle exhibit slip that produces force\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '4';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};

%% Steering forces on rear
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [')  In which steady-state condition do the rear tires not produce any force? (enter a number from 1 to 4):\n' ...
	'1: the steering was 0 for a long time, then is suddenly steered to the right\n' ...
	'2: the steering was 0 for a long time and is held at zero\n' ...
	'3: the steering is held to the right for a long time (infinite)\n' ...
	'4: none of the above\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};

%% Aerodynamics
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [')  At what range of speeds do aerodynamics become so significant that they cannot be ignored, generally? (enter a number from 1 to 4):\n' ...
	'1: at any speed\n' ...
	'2: above 30 mph\n' ...
	'3: above the posted speed limit\n' ...
	'4: above 70 mph\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '4';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Speed limits
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') The fastest posted speed limit in the us is 85 mph. In what situation is this particularly dangerous? (enter a number from 1 to 4):\n' ...
	'1: the manufacturer-installed rear spoiler has broken off\n' ...
	'2: the weight of the vehicle is higher than normal\n' ...
	'3: the weight of the vehicle is lower than normal\n' ...
	'4: the side mirrors are broken\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Tire force curves
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is NOT a region of the tire curve? (enter a number from 1 to 4):\n' ...
	'1: the frictional or full-sliding region\n' ...
	'2: the transitional region\n' ...
	'3: the deformation region\n' ...
	'4: the linear region\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '3';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Tire force curves
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is the name for the slope of the linear area of the tire-force curve? (enter a number from 1 to 4):\n' ...
	'1: the tire slope\n' ...
	'2: the cornering stiffness\n' ...
	'3: the cornering coefficient\n' ...
	'4: the cornering constant\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Tire angle
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is the method to measure the tire slip angle? (enter a number from 1 to 4):\n' ...
	'1: measure from the tire centerline to the sideslip angle of the vehicle\n' ...
	'2: measure from the body centerline to the tire centerline\n' ...
	'3: measure from the tire centerline to the direction of the tires velocity vector\n' ...
	'4: measure from the tires velocity vector to the center of the turn\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '3';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};

%% Tire slip confusion
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Why is tire slip particularly confusing to measure? (enter a number from 1 to 4):\n' ...
	'1: because it is measuring from a force vector to a velocity vector\n' ...
	'2: because positive slip angles produce negative forces\n' ...
	'3: because slip can occur in any direction\n' ...
	'4: because the definition of positive force for a given slip is different in ISO and SAE coordinates\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Linear portion
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which portion of the tire curve is NOT used to define the cornering stiffness? (enter a number from 1 to 4):\n' ...
	'1: the peak tire force\n' ...
	'2: the portion of the curve near the origin\n' ...
	'3: the linear portion of the curve\n' ...
	'4: the slip area, generally, less than 5 degrees\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};

%% 57.3
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Why does the term 57.3 repeatedly appear in high-speed steady-state force derivations? (enter a number from 1 to 4):\n' ...
	'1: it corrects for the units from SAE to ISO coordinates\n' ...
	'2: it is the conversion of radians to degrees\n' ...
	'3: it corrects for the conversion of angles into forces\n' ...
	'4: it represents the cornering stiffness, on average, of vehicles\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Triangle
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following steps is NOT used to derive the relationship for the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: sum of angles inside a triangle is 180 degrees\n' ...
	'2: sum of angles of a right triangle is 90 degrees\n' ...
	'3: the length of an arc of X radians is the radius times X\n' ...
	'4: the slip angles of the front tire are equal to the slip angles of the rear tire\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '4';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Angles
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following angles is NOT in the relationship for the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: the Ackerman angle of the bicycle model\n' ...
	'2: the sideslip angle of the vehicle\n' ...
	'3: the slip angle of the front tire\n' ...
	'4: the slip angle of the rear tire\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};



%% Assumptions 1
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is NOT an assumption to derive the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: the Ackerman angle of the bicycle model is small\n' ...
	'2: the vehicle is moving above 30 mph\n' ...
	'3: the slip angle of the front tire is non-zero\n' ...
	'4: the slip angle of the rear tire is non-zero\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};



%% Assumptions 2
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is NOT an assumption to derive the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: the turn radius is large\n' ...
	'2: the turn radius is constant\n' ...
	'3: the turn radius is on pavement\n' ...
	'4: the turn radius is not at a 90 degree angle to either the front or rear tire\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '3';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Assumptions 3
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is NOT an assumption to derive the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: the speed is high\n' ...
	'2: the speed is constant\n' ...
	'3: the speed is in the longitudinal direction of the vehicle\n' ...
	'4: the speed produces centripetal forces\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Assumptions 4
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is NOT an assumption to derive the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: the radius is large\n' ...
	'2: the steering angles are small\n' ...
	'3: the slip angles are small\n' ...
	'4: the forces are zero\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '4';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};



%% Slip directions
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is always true from the equation for the high-speed steady-state steering angle? (enter a number from 1 to 4):\n' ...
	'1: larger Ackerman angles result in smaller steering angles, assuming front and rear slip angles are unchanged\n' ...
	'2: smaller front slip angles result in smaller steering angles, assuming Ackerman and rear slip angles are unchanged\n' ...
	'3: smaller rear slip angles result in smaller steering angles, assuming Ackerman and front slip angles are unchanged\n' ...
	'4: smaller speeds result in smaller steering angles, assuming Ackerman, front, and rear slip angles are unchanged\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Understeer calc method
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following methods was used to derive the understeer formula? (enter a number from 1 to 4):\n' ...
	'1: sum of forces is equal to mass times acceleration\n' ...
	'2: sum of moments is equal to zero\n' ...
	'3: each tire force is equal to the tires slip times the tires cornering stiffness\n' ...
	'4: all of the above\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '4';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Understeer steering increase
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following will always increase the required steering input for a high-speed steady-state condition? (enter a number from 1 to 4):\n' ...
	'1: decreasing the turn radius\n' ...
	'2: decreasing the vehicle length\n' ...
	'3: decreasing the speed\n' ...
	'4: decreasing the vehicle mass\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};

%% Understeer gradient
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is true about the undesteer gradient? (enter a number from 1 to 4):\n' ...
	'1: it is the slope of the steering versus acceleration curve\n' ...
	'2: it is the slope of the steering versus speed curve\n' ...
	'3: it is the slope of the slip versus acceleration curve\n' ...
	'4: it is the slope of the slip versus force curve\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};

%% Understeer versus oversteer
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is characteristic understeer behavior? (enter a number from 1 to 4):\n' ...
	'1: a driver has to steer more when the vehicle is longer\n' ...
	'2: a driver has to steer more when on a constant-radius turn at high speed versus the same curve at low speed\n' ...
	'3: the vehicle always steers more than the driver intends\n' ...
	'4: the vehicle always steers less than the driver intents\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '2';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Understeer versus oversteer
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Which of the following is characteristic oversteer behavior? (enter a number from 1 to 4):\n' ...
	'1: the rear slip grows faster than the front slip, if the steady-state turning speed is increased for the same radius\n' ...
	'2: a driver has to steer more when on a constant-radius turn at high speed versus the same curve at low speed\n' ...
	'3: the vehicle always steers less than the driver intends\n' ...
	'4: the vehicle skids around corners\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%% Understeer versus oversteer
numProblems = numProblems+1;
problems(numProblems).MenuChar = num2str(numProblems);
problems(numProblems).Name = sprintf('HighSpeedSteadyState%.0d',numProblems);
problems(numProblems).Text = [') Why is severe understeer preferred versus severe oversteer, despite both often ending up in crash situations? (enter a number from 1 to 4):\n' ...
	'1: crumple zones are better for understeer\n' ...
	'2: understeer vehicles are cheaper to manufacture\n' ...
	'3: understeer vehicles are more predictable\n' ...
	'4: oversteer vehicles are inherently dangerous above the posted speed limit\n'];
problems(numProblems).AnswerDefault = '-missing-';
problems(numProblems).AnswerType = '1column_of_integers';
problems(numProblems).AnswerConversionFunction = 'str2double';
problems(numProblems).AnswerTypeOptions = [1 1];
problems(numProblems).AnswerPrintFormat = '%.0f';
problems(numProblems).AnswerAllowableRange = [1 4];
problems(numProblems).FunctionMore = {...
	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+1)
	};
problems(numProblems).FunctionPreMenu = [];
% {...
% 	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numProblems+100)
% 	};
problems(numProblems).FunctionMoreInputs = {30};
problems(numProblems).FunctionSubmission = { ...
	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
	};
problems(numProblems).FunctionSubmissionOptions = {'.'};
problems(numProblems).isAllowableMenuOption = false;
problems(numProblems).AnswerGradingCorrect = '1';
problems(numProblems).AnswerGradingPoints = 1;
problems(numProblems).AnswerGradingType = 'exact match';
problems(numProblems).AnswerGradingOptions = {[]};


%%
%%

% Fill in test data
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections
selections(1).AssignmentString = thisName;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = num2str(numQuestions);
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = ') Identity information: What is the 7-digit folder number that was emailed to you?';
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

%% Fill in problems
NproblemsToUse = 3; % numProblems;

randomProblemsToUse = randperm(numProblems, NproblemsToUse);

fieldNamesSource = fieldnames(problems);
for ith_problem = 1:NproblemsToUse
    thisProblemToUse = randomProblemsToUse(ith_problem);

    numQuestions = numQuestions+1;

    for k = 1:numel(fieldNamesSource)
        selections(numQuestions).(fieldNamesSource{k}) = problems(thisProblemToUse).(fieldNamesSource{k});
    end
    selections(numQuestions).MenuChar = num2str(numQuestions);

    selections(numQuestions).FunctionMore = {...
    	sprintf('selections = fcn_help_%s(%.0f, answers, selections);',thisName,numQuestions+1)
    	};

    selections(numQuestions).FunctionSubmission = { ...
    	'[answers, numBadOptionInputs, flag_exitMain, selections] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs);';
    	};

end


% 
% 
% %% HighSpeedSteadyState2
% numQuestions = numQuestions+1;
% selections(numQuestions).MenuChar = num2str(numQuestions);
% selections(numQuestions).Name = sprintf('HighSpeedSteadyState%.0d',numQuestions);
% selections(numQuestions).Text = ')  For a kinematic bicycle model with wheelbase of XXX meters and steering angle of YYY degrees, what is the turning radius in meters?  Give your answer to 2 decimal places.';
% selections(numQuestions).AnswerDefault = '-missing-';
% selections(numQuestions).AnswerType = '1column_of_numbers';
% selections(numQuestions).AnswerConversionFunction = 'str2double';
% selections(numQuestions).AnswerTypeOptions = [1 1];
% selections(numQuestions).AnswerPrintFormat = '%.2f';
% selections(numQuestions).AnswerAllowableRange = [0 10000];
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
% selections(numQuestions).AnswerGradingType = 'exact match';
% selections(numQuestions).AnswerGradingOptions = {[]};
% 
% %% HighSpeedSteadyState3
% numQuestions = numQuestions+1;
% selections(numQuestions).MenuChar = num2str(numQuestions);
% selections(numQuestions).Name = sprintf('HighSpeedSteadyState%.0d',numQuestions);
% selections(numQuestions).Text = ')  For vehicle with wheelbase of XXX meters and track width of YYY meters, what steering angle in radians is reqired for the inside front tire to steer a radius of ZZZ? Give your answer to 2 decimal places.';
% selections(numQuestions).AnswerDefault = '-missing-';
% selections(numQuestions).AnswerType = '1column_of_numbers';
% selections(numQuestions).AnswerConversionFunction = 'str2double';
% selections(numQuestions).AnswerTypeOptions = [1 1];
% selections(numQuestions).AnswerPrintFormat = '%.2f';
% selections(numQuestions).AnswerAllowableRange = [0 100];
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
% selections(numQuestions).AnswerGradingType = 'exact match';
% selections(numQuestions).AnswerGradingOptions = {[], 1};
% 
% %% HighSpeedSteadyState4
% numQuestions = numQuestions+1;
% selections(numQuestions).MenuChar = num2str(numQuestions);
% selections(numQuestions).Name = sprintf('HighSpeedSteadyState%.0d',numQuestions);
% selections(numQuestions).Text = ')  For vehicle with length of XXX meters and track width of YYY meters, what steering angle in radians is reqired for the outside front tire to steer a radius of ZZZ? Give your answer to 2 decimal places.';
% selections(numQuestions).AnswerDefault = '-missing-';
% selections(numQuestions).AnswerType = '1column_of_numbers';
% selections(numQuestions).AnswerConversionFunction = 'str2double';
% selections(numQuestions).AnswerTypeOptions = [1 1];
% selections(numQuestions).AnswerPrintFormat = '%.2f';
% selections(numQuestions).AnswerAllowableRange = [0 100];
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
% selections(numQuestions).AnswerGradingType = 'exact match';
% selections(numQuestions).AnswerGradingOptions = {[], 1};

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
    'typeList = {''var'', ''var''};';
    'nameList = {''answers'', ''timelog''};';
	'studentWorkDirectory = fullfile(pwd,''Assignments'',''Week04_Quiz09_HighSpeedSteadyState'',answers{2});'
    'fcn_PrepareSubmission_packageAnswers(zipName, typeList, nameList, answers, timelog, (1));';
    'fcn_DebugTools_cprintf(''*Green'',''Submission prepared.'');';
    'fprintf(1,''\\nThe file: \\n\\t%%s\\nwas just created.\\n'',zipName)';
    'fprintf(1,''As the final step, you must manually copy this SUBMISSION zip file out of \\nthe ''''Submissions'''' folder and into the OneDrive folder shared with you.\\n This is to force the user to check that files were created and uploaded, before exiting.\\n'');';
    'fprintf(1,''Press any key to continue'');';
    'pause;';
    'answers{end-1} = ''SUBMITTED'';';
    };
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = false;


    % 'typeList = {''var'', ''var'',''dir''};';
    % 'nameList = {''answers'', ''timelog'',''studentWorkDirectory''};';
	% 'studentWorkDirectory = fullfile(pwd,''Assignments'',''Week04_Quiz09_HighSpeedSteadyState'',answers{2})'
	%     'fcn_PrepareSubmission_packageAnswers(zipName, typeList, nameList, answers, timelog, studentWorkDirectory, (1));';

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




%% Week04_Quiz09_HighSpeedSteadyState
%  09560151045304004D0653
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

% Grade Hashes for: Week04_Quiz09_HighSpeedSteadyState
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