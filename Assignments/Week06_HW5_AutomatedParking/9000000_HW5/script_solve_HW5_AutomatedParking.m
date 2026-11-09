% script_solve_HW5_AutomatedParking.m
% shows how to solve the automated parking problem

% REVISION HISTORY:
%
% 2026_10_26 by Sean Brennan, sbrennan@psu.edu
% - In script_solve_HW5_AutomatedParking.m
%   % * Wrote the code originally, 
%   % * Using script_HW2_FirstOrderEngineModelRK4 as starter
%
% 2026_11_08 by Sean Brennan, sbrennan@psu.edu
% - In script_solve_HW5_AutomatedParking.m
%   % * Revised in prep for release
%   % * Renamed file to XXX_HW5_AutomatedParking


% TO-DO:
%
% 2026_10_26 by Sean Brennan, sbrennan@psu.edu
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

% Set up vehicle parameters ... DEMO case: simulating a 2013 Prius. 
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


% Set a figure number to plot in
figNum = 10001;
titleString = sprintf('DEMO case: basic call');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Load the standard parking maneuver which has associated with it each t
% and u distance, e.g. the entry and exit minimum distances for the
% maneuver. These are used in the parking calculations that follow.
dataFileName = fullfile(pwd,'Data','parkingData.mat');
if exist(dataFileName,'file')
    load(dataFileName,'standardParkingTurnPath','tDistancesEachAngle','uDistancesEachAngle')
else
	error('Need to run fcn_VD_parkingFillStandardParkingTurnPath to generate the data file');
end

% Set the starting point. Vehicle starts at origin, facing 0 degrees. 
startingPointInXYphi = [0 0 0]; % Units are [m m rad]

% YOU WILL HAVE TO ENTER THIS FOR YOUR SIMULATION
% This was copied/pasted out of the questions, and is different for each
% student.
goalParkingPointInXYphi = [15.6091 3.3487 0.8500];


% Call a function to calculate the parking maneuver itself, and plot the
% results
[approachXYPsi, curveXYPsi, exitXYPsi,...
	approachPathDistance, changeInArcAngleInRadians, exitPathDistance] = fcn_VD_parkingCalcEntryArcExitPaths(...
	standardParkingTurnPath, tDistancesEachAngle, uDistancesEachAngle, ...
	startingPointInXYphi, goalParkingPointInXYphi, (figNum));

% Plot the vehicle
L = vehicleParameters.DistancesWheelbase;
b = vehicleParameters.DistancesCGFromRearAxle;
a = L - b;
vehicleParameters.a          = a; % Distance from front axle to CG, in meters
vehicleParameters.b          = b;  % Distance from rear axle to CG, in meters

fcn_VD_plotStickFigure2DOFBicycleModel(vehicleParameters, startingPointInXYphi, [0; 0], true, (figNum));
h_fig = fcn_VD_parkingPlotParkingSpot(vehicleParameters, goalParkingPointInXYphi, (true), (figNum));
set(h_fig,'LineWidth',2);

% Add initials
title('SB');

% The Y value is in the 1st row, 2nd column
fprintf(1,'\nThe approach distance, approachPathDistance: %.2f\n',approachPathDistance);
fprintf(1,'\nThe change in angle in parking arc, changeInArcAngleInRadians: %.2f\n',changeInArcAngleInRadians);
fprintf(1,'\nThe exit distance, exitPathDistance: %.2f\n',exitPathDistance);

% Dr B's results (using 9000000 as student number): 
% approachPathDistance: 9.31 meters
% changeInArcAngleInRadians: 0.85 radians
% exitPathDistance: 1.10 meters


 
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
