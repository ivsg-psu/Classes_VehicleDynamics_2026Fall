% script_solve_HW4_VehicleParameters.m
% shows how to enter vehicle parameters

% REVISION HISTORY:
%
% 2026_11_03 by Sean Brennan, sbrennan@psu.edu
% - In script_solve_HW4_VehicleParameters.m
%   % * Wrote the code originally, 
%   % * Using script_HW2_FirstOrderEngineModelRK4 as starter

% TO-DO:
%
% 2026_11_03 by Sean Brennan, sbrennan@psu.edu
% - (fill in to-do items here)


%% Set up the workspace
close all

%% Code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  __  __       _
% |  \/  |     (_)
% | \  / | __ _ _ _ __
% | |\/| |/ _` | | '_ \
% | |  | | (_| | | | | |
% |_|  |_|\__,_|_|_| |_|
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Demos%20Of%20Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 1

close all;

% Set up vehicle parameters. RENAME the file to match the year,
% manufacturer, make, and trim line following the same format here: same
% order, no spaces, first letter capitalized and other letters lower-case
% CHANGE THIS NAME TO MATCH THE VEHICLE
thisDataFileName = 'vehicleParameters_2013ToyotaPriusFour.mat';
vehicleParametersFile = fullfile(pwd,'Data',thisDataFileName);

%%%%%%%%%%
% Call the function
% Set figNum to anything but -1 to enter menu. Set to -1 to skip menu.
figNum = 1;
vehicleParameters = fcn_VD_getStudentVehicle((vehicleParametersFile), (figNum));

% Copy results to this folder
fprintf(1,'Copying parameters file to student folder:\n');
f = which('script_solve_HW4_VehicleParameters');      % full path or 'built-in' or empty
thisFolder = fileparts(f);
[status,msg] = copyfile(vehicleParametersFile,fullfile(thisFolder,thisDataFileName));


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
