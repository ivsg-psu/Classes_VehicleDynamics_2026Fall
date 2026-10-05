function selections = fcn_help_Week04_Quiz09_HighSpeedSteadyState(entry, answers, selections)

% fcn_help_Week04_Quiz09_HighSpeedSteadyState
% Written by: sbrennan@psu.edu
% 2026_10_02

% REVISION HISTORY:
%
% 2026_10_02 by Sean Brennan, sbrennan@psu.edu
% - In fcn_help_Week04_Quiz09_HighSpeedSteadyState
%   % * First write of the code using fcn_help_Week03_HW2_ as a starter
%
% (new release)

% TO-DO:
% - 2026_10_02 by Sean Brennan, sbrennan@psu.edu
%   % * (add help)

studentNumberString = answers{1};
studentNumber = str2double(studentNumberString);

if entry<100
	thisName = selections(entry).Name;
	switch thisName
		case 'WhatNumber'
			fprintf(1,'The 7-digit number will have the form, usually, of 7XXXXXX. \nThis number is the name of the OneDrive folder shared with you. \nEach student has their own number, and this number should not be shared.\n');
		case contains('HighSpeedSteadyState')
			fprintf(1,'Please see the Powerpoint lectures for the answers!\n');
		case 'Grade'
			fprintf(1,'This grades the assignment. Note: the grading will not work unless the help option is chosen in each image-based question.\n');
		case 'Submit'
			fprintf(1,'This submits the results for grading. \nNote: students can submit as many times as desired, up until the due date');
		case 'Quit'
			fprintf(1,'This quits the software. Results will be saved and are used to initialize answers the next time the software is run.');
		otherwise
			fprintf(1,'Unrecognized entry: %.0f\n',entry);
			fprintf(1,'Hit any key to continue.\n');
			pause;
	end
else
	% This is for pre-menu functions
	premenuName = selections(entry-100).Name;
	allNames = {selections.Name};
	switch premenuName
		case {'WhatNumber','AckermanSteeringAngle2','AckermanSteeringAngle3','AckermanSteeringAngle4'}
			if isempty(answers{1})
				% Shut off this and all following AckermanSteeringAngle problems
				for ith_problem = 2:4
					nameToFind = sprintf('AckermanSteeringAngle%.0d',ith_problem);
					problemToChange = fcn_INTERNAL_nameToNumber(nameToFind,allNames);
					selections(problemToChange).isAllowableMenuOption = false;
				end
			else
				
				if ~isnan(studentNumber) && ~isempty(answers{1})

					% Fill in answers
					wheelbasePercentage = str2double(studentNumberString(2))/10;
					wheelbase = 1.5+wheelbasePercentage*2;

					steeringAnglePercentage = str2double(studentNumberString(3));
					steeringAngleDegrees = 1 + steeringAnglePercentage;

					trackWidthPercentage = str2double(studentNumberString(4));
					trackWidth = 0.8 + trackWidthPercentage*0.1;

					goalRadiusPercentage = str2double(studentNumberString(5));
					goalRadius = 10 + goalRadiusPercentage*10;

					% Generate answers
					problemToChange = fcn_INTERNAL_nameToNumber('AckermanSteeringAngle2',allNames);
					predictedRadius = wheelbase/tan(steeringAngleDegrees*pi/180);
					correctAnswer = sprintf('%.2f',round(predictedRadius,2));
					textToChange = selections(problemToChange).Text;
					newText = replace(textToChange,'XXX',sprintf('%.8f',wheelbase));
					newText = replace(newText,'YYY',sprintf('%.8f',steeringAngleDegrees));
					selections(problemToChange).Text = newText;
					selections(problemToChange).AnswerGradingCorrect = correctAnswer;
					selections(problemToChange).isAllowableMenuOption = true;

					% Generate answers
					problemToChange = fcn_INTERNAL_nameToNumber('AckermanSteeringAngle3',allNames);
					effectiveRadius = goalRadius - trackWidth/2;
					steeringToUse = atan(wheelbase/effectiveRadius);					
					correctAnswer = sprintf('%.2f',round(steeringToUse,2));
					textToChange = selections(problemToChange).Text;
					newText = replace(textToChange,'XXX',sprintf('%.8f',wheelbase));
					newText = replace(newText,'YYY',sprintf('%.8f',trackWidth));
					newText = replace(newText,'ZZZ',sprintf('%.8f',goalRadius));
					selections(problemToChange).Text = newText;
					selections(problemToChange).AnswerGradingCorrect = correctAnswer;
					selections(problemToChange).isAllowableMenuOption = true;


					% Generate answers
					problemToChange = fcn_INTERNAL_nameToNumber('AckermanSteeringAngle4',allNames);
					effectiveRadius = goalRadius + trackWidth/2;
					steeringToUse = atan(wheelbase/effectiveRadius);					
					correctAnswer = sprintf('%.2f',round(steeringToUse,2));
					textToChange = selections(problemToChange).Text;
					newText = replace(textToChange,'XXX',sprintf('%.8f',wheelbase));
					newText = replace(newText,'YYY',sprintf('%.8f',trackWidth));
					newText = replace(newText,'ZZZ',sprintf('%.8f',goalRadius));
					selections(problemToChange).Text = newText;
					selections(problemToChange).AnswerGradingCorrect = correctAnswer;
					selections(problemToChange).isAllowableMenuOption = true;
				end

			end

		case 'Grade'
			% Do nothing
		case 'Submit'
			% Do nothing
		case 'Quit'
			% Do nothing
		otherwise
			fprintf(1,'Unrecognized entry: %.0f\n',entry);
			fprintf(1,'Hit any key to continue.\n');
			pause;
	end


end




%% Fixing images
if 1==0
	figNum = 999;
	sourceDirectory = fullfile(pwd,'Data','Week03_CoordSysX_imagesConvertToJPG_source');
	destinationDirectory = fullfile(pwd,'Data','Week03_CoordSysX_imagesConvertToJPG_destination');
	imageSize = [256 256];

	% Call the function
	fcn_DebugTools_imagesConvertToJPG(sourceDirectory, destinationDirectory, imageSize, (figNum))


	% Load or create
	resultsFile = fullfile(pwd,'Data','Images_Week03_CoordinateSystemX.mat');
	if exist(resultsFile,'file')
		load(resultsFile,'labels');
		oldLabels = labels;
	else
		oldLabels = [];
	end

	% Call the function
	labels = fcn_DebugTools_imagesAddLabelsInteractive(destinationDirectory, oldLabels, (figNum));
	save(resultsFile,'labels','-v7.3');
end

%% Solve problem
if 1==0
	steeringAngle = 1*pi/180;
	wheelbase = 1.5;
	radius = wheelbase/tan(steeringAngle)

	desiredRadius = 10;
	trackwidth = 0.8;
	steeringAngleInside = atan(wheelbase/(desiredRadius-trackwidth/2))

	steeringAngleInside = atan(wheelbase/(desiredRadius+trackwidth/2))


	% radius: 85.9349
	% inside: 0.1550
	% outside: 0.1432


	% TRUE: 85.9349
	% 0.1550
	% 0.1432
end

end % Ends function

%% fcn_INTERNAL_nameToNumber
function number = fcn_INTERNAL_nameToNumber(nameToFind,allNames)
number = find(strcmp(allNames,nameToFind),1);
end % Ends fcn_INTERNAL_nameToNumber
