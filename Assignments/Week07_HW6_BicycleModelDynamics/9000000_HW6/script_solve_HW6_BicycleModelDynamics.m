% script_solve_HW6_BicycleModelDynamics.m.m
% uses fcn_VD_2DOFBicycleModelRK4 to simulate the bicycle model

% REVISION HISTORY:
%
% 2026_11_13 by Sean Brennan, sbrennan@psu.edu
% - In script_solve_HW6_BicycleModelDynamics.m
%   % * Wrote the code originally, 
%   % * Using script_HW2_FirstOrderEngineModelRK4 as starter

% TO-DO:
%
% 2026_11_13 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)


%% Set up the workspace
close all

%% Code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   _____                              ____   __    _____          _
%  |  __ \                            / __ \ / _|  / ____|        | |
%  | |  | | ___ _ __ ___   ___  ___  | |  | | |_  | |     ___   __| | ___
%  | |  | |/ _ \ '_ ` _ \ / _ \/ __| | |  | |  _| | |    / _ \ / _` |/ _ \
%  | |__| |  __/ | | | | | (_) \__ \ | |__| | |   | |___| (_) | (_| |  __/
%  |_____/ \___|_| |_| |_|\___/|___/  \____/|_|    \_____\___/ \__,_|\___|
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Demos%20Of%20Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 1

close all;

%% Set up vehicle parameters 
% below is a DEMO case: simulating a 2013 Prius. 
% STUDENTS MUST CHANGE TO MATCH THEIR VEHICLE!
thisDataFileName = 'vehicleParameters.mat';
vehicleParametersFile = fullfile(pwd,'Data',thisDataFileName);
if ~exist(vehicleParametersFile,'file')
	error(['The code requires that the vehicleParameters.mat file exist ' ...
		'inside the "Data" folder, but it was not found. This file ' ...
		'        should have been created in a prior homework assignment, ' ...
		'        and it may have been saved as a different name. If this ' ...
		'        file exists as a different name, please copy the file to ' ...
		'        vehicleParameters.mat and restart this script. Otherwise, ' ...
		'        the prior homework will need to be redone to fill in the ' ...
		'        parameters.'])
end
% Call a function to load the vehicle parameters out of the file, skipping
% menu. 
% Set figNum to anything but -1 to enter menu. Set to -1 to skip menu.
vehicleParameters = fcn_VD_getStudentVehicle((vehicleParametersFile), (-1));

%% Set the simulation time/state arguments
initialStates = [0 0 0 0 0]; % [V r X Y phi] in [m/s], [rad/sec], [m],[m],[rad]
deltaT = 0.001; % Units are [sec]
startTime = 0;
endTime = 10;
timeInterval = [startTime endTime];  % Units are [sec]

%% Use a function to generate a steering input
% See the function for more details. The test ID we want is "1", which
% generates a lane change maneuver, namely one sinewave input. There are
% lots of different standard steering inputs, and the function allows us to
% quickly set one up without much effort.
testCaseID = 1;
testCaseOptions = cell(3,1); % Initialize a variable to fill
testCaseOptions{1} = 5;  % steeringAmplitudeDegrees
testCaseOptions{2} = 3;  % periodOfSineWave, units are seconds
testCaseOptions{3} = 1;  % start time of the wave, in seconds
simulationTimes = (startTime:deltaT:endTime)'; % make sure the simulation times match the inputs listed above

% Call a function to fill in the steering test case
steeringInputsVsTime = fcn_VD_steeringFillTestCase( (testCaseID), (testCaseOptions), (simulationTimes), (-1));




%% Set a figure number to plot in
figNum = 1;
titleString = sprintf('DEMO case: basic call');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

%% Set the speed
U = 20; % Forward velocity, in m/s

%% Call the function
[stateTrajectory, t, steeringUsed] = ...
	fcn_VD_st2dofRK4(initialStates, deltaT, timeInterval, steeringInputsVsTime, vehicleParameters, U, (figNum));
set(gcf, 'Name', 'HW6_XYsolution');
sgtitle('SB');

%% Plot the inputs and states that were not plotted in function call
figNum = 2;
figure(figNum);
clf;
hold on;

subplot(4,1,1);
fcn_VD_plotTimeSteeringInputs(t,steeringUsed, (figNum));
set(gca,'FontSize',10);

subplot(4,1,2);
fcn_VD_plotTimeLateralVelocity(t,stateTrajectory(:,1), (figNum));
set(gca,'FontSize',10);

subplot(4,1,3);
fcn_VD_plotTimeYawRate(t,stateTrajectory(:,2), (figNum));
set(gca,'FontSize',10);

subplot(4,1,4);
fcn_VD_plotTimeYaw(t,stateTrajectory(:,5), (figNum));
set(gca,'FontSize',10);

set(gcf, 'Name', 'HW6_InputsAndStates');

%% Get the inputs and states at the requested time
timeToFind = 3; % Seconds
indexToUse = find(t>=timeToFind,1);
statesAtTimeToFind = stateTrajectory(indexToUse,:);
steeringAtTimeToFind = steeringUsed(indexToUse,:);

% The Y value is in the 1st row, 2nd column
fprintf(1,'\nAt time: %.2f seconds, the states are as follows:\n',timeToFind);
fprintf(1,'steering  : %.2f rad\n',    steeringAtTimeToFind(1,1));
fprintf(1,'V value   : %.2f m/s\n',    statesAtTimeToFind(1,1));
fprintf(1,'r value   : %.2f rad/sec\n',statesAtTimeToFind(1,2));
fprintf(1,'X value   : %.2f meters\n', statesAtTimeToFind(1,3));
fprintf(1,'Y value   : %.2f meters\n', statesAtTimeToFind(1,4));
fprintf(1,'yaw value : %.2f radians\n',statesAtTimeToFind(1,5));

% Dr B's results (copy and pasted, then commented out):
% At time: 3.00 seconds, the states are as follows:
% steering  : -0.08 rad
% V value   : 0.18 m/s
% r value   : -0.36 rad/sec
% X value   : 58.39 meters
% Y value   : 9.31 meters
% yaw value : 0.36 radians


 
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
