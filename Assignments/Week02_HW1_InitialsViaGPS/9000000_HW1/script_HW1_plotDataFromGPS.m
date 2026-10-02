%% Set the file names
% Specify the folder and file names associated with the data. Edit these
% names to match your folder structure. Note: the PWD command returns the
% path up to and including the 2026Fall directory.
dataStorageFolder = fullfile(pwd,'Assignments','Week02_HW1_InitialsViaGPS','9000000_HW1');

% Make sure the variable isn't used yet
clear filesToLoad

% There are several ways to load data, either automatically or hard-coded.
% The if statement shows both
if 1==1
	matFilesInFolder = dir(fullfile(dataStorageFolder,'*.mat'));
	for ith_file = 1:length(matFilesInFolder)
		% Copy the name string into our list
		filesToLoad{ith_file} = matFilesInFolder(ith_file).name; %#ok<SAGROW>
	end
else
	% Change the names below to match your data. Add more files if needed to
	% fill in the 3rd, 4th, etc. entries.
	filesToLoad{1} = 'sensorlog_20260918_092151.mat';
	filesToLoad{2} = 'sensorlog_20260918_092723.mat';
end
Nfiles = length(filesToLoad);

%% Load the data
% Make sure variables are cleared before filling them, to avoid using old
% data accidentally
clear positionsAndSpeeds
positionsAndSpeeds = [];
% Loop through all the files, loading data
for ith_file = 1:Nfiles
	% % NOTE: the variables within each file can be seen by running the following
	% % command:
	% info = whos('-file', filesToLoad{ith_file});

	thisPositionDataTable = load(filesToLoad{ith_file},'Position');
	thisLatitude = thisPositionDataTable.Position.latitude;
	thisLongitude = thisPositionDataTable.Position.longitude;
	thisSpeed = thisPositionDataTable.Position.speed;

	positionsAndSpeeds = [positionsAndSpeeds; thisLatitude thisLongitude thisSpeed]; %#ok<AGROW>

	% If this is NOT the last file, add NaN values between the data so that
	% the data will plot with gaps. NaN forces the "drawing pen" to "lift"
	% when plotting data to disconnect parts of data from each other. We
	% fill in a row of NaN values by simply multiplying the first row by
	% NaN and appending it to the end.

	if ith_file<Nfiles
		positionsAndSpeeds = [positionsAndSpeeds; nan*positionsAndSpeeds(1,:)]; %#ok<AGROW>
	end
end

positionsAndSpeeds = data;

%% Plot the position data
% Type "edit script_test_fcn_plotRoad_plotLL" to see a script that shows
% how the function below is used.
clear plotFormat
plotFormat.Color = [0 1 1];
plotFormat.Marker = '.';
plotFormat.MarkerSize = 50;
plotFormat.LineStyle = '-';
plotFormat.LineWidth = 3;

figNum = 1111; % Set an arbitrary figure number
figure(figNum); clf; % Clear the figure

% Plot the data into the figure
fcn_plotRoad_plotLL(positionsAndSpeeds(:,1:2), plotFormat, figNum);

%% Plot the positions, colored by speeds
% Type "edit script_test_fcn_plotRoad_plotLLI" to see a script that shows
% how the function below is used.

LLIdata = positionsAndSpeeds(:,1:3);

figNum = 2222; % Set an arbitrary figure number
figure(figNum); clf; % Clear the figure


clear plotFormat
plotFormat.LineStyle = 'none';
plotFormat.LineWidth = 3;
plotFormat.Marker = '.';
plotFormat.MarkerSize = 5;
colorMapString = 'turbo';

% Reduce the colormap
Ncolors = 10;
colorMapMatrix = colormap(colorMapString);
reducedColorMap = fcn_plotRoad_reduceColorMap(colorMapMatrix, Ncolors, -1);

% Specify the sizes (must be same size as reducedColorMap)
markerSizeMatrix = 2*(1:Ncolors)';
plotFormat.MarkerSize = markerSizeMatrix;

[h_plot, indiciesInEachPlot]  = fcn_plotRoad_plotLLI(LLIdata, (plotFormat),  (reducedColorMap), (figNum));

h_colorbar = colorbar;
h_colorbar.Ticks = linspace(0, 1, Ncolors) ; %Create ticks from zero to 1
% There are 2.23694 mph in 1 m/s
velocity = positionsAndSpeeds(:,3);
colorbarValues   = round(2.23694 * linspace(min(velocity), max(velocity), Ncolors));
h_colorbar.TickLabels = num2cell(colorbarValues) ;   
h_colorbar.Label.String = 'Speed (mph)';