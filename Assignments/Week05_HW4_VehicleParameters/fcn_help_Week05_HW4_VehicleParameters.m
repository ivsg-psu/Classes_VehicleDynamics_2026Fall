function selections = fcn_help_HW4_VehicleParameters(entry, answers, selections)

% fcn_help_Week04_HW4_VehicleParameters
% Written by: sbrennan@psu.edu
% 2026_11_04

% REVISION HISTORY:
%
% 2026_11_04 by Sean Brennan, sbrennan@psu.edu
% - In fcn_help_Week04_HW4_VehicleParameters
%   % * First write of the code using HW+3_Rung+eKuttaKinematics as a starter
%
% (new release)

% TO-DO:
% - 2026_11_04 by Sean Brennan, sbrennan@psu.edu
%   % * (add help)

studentNumberString = answers{1};
studentNumber = str2double(studentNumberString); %#ok<NASGU>

if entry<100
    thisName = selections(entry).Name;

    if contains(thisName, 'VehicleParameters')
        thisName = 'VehicleParameters';
    end

	switch thisName
		case 'WhatNumber'
			fprintf(1,'The 7-digit number will have the form, usually, of 7XXXXXX. \nThis number is the name of the OneDrive folder shared with you. \nEach student has their own number, and this number should not be shared.\n');
		case 'VehicleParameters'
			fprintf(1,'Please see the Powerpoint instructions for details on how to answer this question.\n');    		
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
	allNames = {selections.Name}; %#ok<NASGU>

    if contains(premenuName, 'VehicleParameters')
        premenuName = 'VehicleParameters';
    end

	switch premenuName
		case 'WhatNumber'
			% Do nothing
		case 'VehicleParameters'
			% Do nothing		
		case 'Grade'
            % Do nothing
			% if ~isnan(studentNumber) && ~isempty(answers{3}) && ~isempty(answers{4})
            % 
			% 	% Set the simulation time/state arguments
			% 	initialStates = [0 0 0]; % [X Y phi] in [m],[m],[rad]
			% 	deltaT = 0.01; % Units are [sec]
			% 	startTime = 0;
			% 	endTime = 60;
			% 	timeInterval = [startTime endTime];  % Units are [sec]
            % 
			% 	% Set up inputs
			% 	steering_amplitude_degrees = str2double(studentNumberString(2));
			% 	if 0==steering_amplitude_degrees
			% 		steering_amplitude_degrees = 10;
			% 	end
            % 
			% 	% steering_amplitude_degrees = 10; % degrees of steering amplitude, roadwheel angle
			% 	simulationTimes = (startTime:deltaT:endTime)';
			% 	simulationInputs = steering_amplitude_degrees*pi/180*ones(size(simulationTimes));
			% 	inputsVsTime = [simulationTimes simulationInputs]; % [times steeringAnglesInRadians]
            % 
			% 	% Set up parameters
			% 	clear parameters
			% 	parameters.U = 2;  % U is forward velocity of vehicle in longitudinal direction, [m/s] (rule of thumb: 5 mph ~= 2* m/s)
			% 	parameters.L = str2double(answers{3}); % wheelbase in meters of student's vehicle
            % 
			% 	% Call the function
			% 	[stateTrajectory, t, ~] = ...
			% 		fcn_VD_kinematicBicycleModelRK4(initialStates, deltaT, ...
			% 		timeInterval, inputsVsTime, parameters, (-1));
            % 
			% 	if 1==0
			% 		% Solve for the expected radius
			% 		expectedR = parameters.L/tan(steering_amplitude_degrees*pi/180);
            % 
			% 		% Get the actual radius
			% 		% Note: stateTrajectory is [X Y Phi] in units of [m],[m],[rad].
			% 		% See "help fcn_VD_kinematicBicycleModelRK4"
			% 		actualR = max(stateTrajectory(:,1)); % use "max" function to pull out largest value
            % 
			% 		% Make sure they match to 2 decimal places
			% 		try
			% 			assert(isequal(round(expectedR,2),round(actualR,2)));
			% 		catch
			% 			warning('The expected and simulated radii do not match exactly. This indicates a likely round-off error. Hit any key to continue.');
			% 			pause;
			% 		end
			% 	end
            % 
			% 	% Get the Y position at 30 seconds
			% 	timeToFind = 30.00; % Seconds
			% 	indexToUse = find(t>=timeToFind,1);
			% 	statesAtTimeToFind = stateTrajectory(indexToUse,:);
			% 	correctAnswer = sprintf('%.2f',statesAtTimeToFind(1,2));
            % 
			% 	problemToChange = fcn_INTERNAL_nameToNumber('RKBicycleKinematics4',allNames);
			% 	selections(problemToChange).AnswerGradingCorrect = correctAnswer;
			% end

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


end % Ends function

%% fcn_INTERNAL_nameToNumber
function number = fcn_INTERNAL_nameToNumber(nameToFind,allNames) %#ok<DEFNU>
number = find(strcmp(allNames,nameToFind),1);
end % Ends fcn_INTERNAL_nameToNumber