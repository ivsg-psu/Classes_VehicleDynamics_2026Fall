
%% Introduction to and Purpose of the Code
% This is the explanation of the code that can be found by running
%       script_demo_Laps.m
% This is a script to demonstrate the functions within the Laps code
% library. This code repo is typically located at:
%   https://github.com/ivsg-psu/FeatureExtraction_DataClean_BreakDataIntoLaps
%
% If you have questions or comments, please contact Sean Brennan at
% sbrennan@psu.edu
%
% The purpose of the code is to break data into "laps", namely portions of
% data defined by start and end points, and in some cases, even allowing
% excursion points that must be "hit" between start and end points. The
% reason for this code is that it is very common that data collection in
% the field passes repeatedly over a test area, even in one data set, and
% thus one must be able to quickly break the code into individual data
% groups with one grouping, or "lap", per traversal.

% REVISION HISTORY:
% 
% 2022_03_27 by Sean Brennan, sbrennan@psu.edu
% - Created a demo script of core debug utilities
% 
% 2022_04_02 by Sean Brennan, sbrennan@psu.edu
% - Added sample path creation
% 
% 2022_04_04 by Sean Brennan, sbrennan@psu.edu
% - Added minor edits
% 
% 2022_04_10 by Sean Brennan, sbrennan@psu.edu
% - Added comments, plotting utilities for zone definitions
% 
% 2022_05_21 by Sean Brennan, sbrennan@psu.edu
% - More cleanup
% 
% 2022_07_23 by Sean Brennan, sbrennan@psu.edu
% - Enable index-based look-up
% 
% 2023_02_01 by Sean Brennan, sbrennan@psu.edu
% - Enable web-based installs
% 
% 205_04_25 by Sean Brennan, sbrennan@psu.edu
% - Updated header structure to enable global flagging from main script
% - Added global flags for setting test conditions and plotting in fcns
% - Updated DebugTools_v2024_12_18 dependency
% - Updated PathClass_v2024_03_14 dependency
% - Updated GetUserInputPath_v2025_04_27 dependency
% - Added PlotRoad_v2025_04_12 dependency
% - Updated headers in all functions
% - Added no-plot and fast-mode tests in all test scripts
% - Added global test script
% 
% 2025_07_02 by Sean Brennan, sbrennan@psu.edu
% -  Updated PathClass_v2025_07_02 dependency
% 
% 2025_07_04 by Sean Brennan, sbrennan@psu.edu
% -  Cleaned up plotting and assertion testing throughout
% (new release)
%
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated installer to use fcn_DebugTools_autoInstallRepos
% - Updated script_test_all_functions to current release from DebugTools
% - Cleared out clc / clear all commands in scripts and functions:
%   % * script_test_fcn_Laps_breakDataIntoLapIndices
%   % * script_test_fcn_Laps_breakDataIntoLaps
%   % * script_test_fcn_Laps_findPointZoneStartStopAndMinimum
%   % * script_test_fcn_Laps_findSegmentZoneStartStop
% - Fixed missing "warning('backtrace','on');" in several files
% - Fixed extra "figure(figNum);" that was in Input section of all fcns
% - Cleaned up README.md a bit including lint, simplification of commands.
% (new release)
%
% 2025_11_13 by Sean Brennan, sbrennan@psu.edu
% - Updated script_test_all_functions
% - Updated header flags for clearing path, to do fast checking without
%   % skipping
% (new release)
%
% 2025_11_21 by Sean Brennan, sbrennan@psu.edu
% - Updated rev list on files to standard format
% - Replaced all fig+_num with figNum
% (new release)
%
% 2026_02_10 by Sean Brennan, sbrennan@psu.edu
% - In script_demo_Laps
%   % * Added check if repo is ready for release
%   % * Removed script_test_all_functions
% (new release)

% TO-DO:
% - 2025_11_12 by Sean Brennan, sbrennan@psu.edu
%   % * Main code runs, but could use some better outputs to workspace via
%   %   % fprintf.
%   % * Not the greatest money plot outputs in main script - these could
%   %   % be more clear.


%% Make sure we are running out of root directory
st = dbstack; 
thisFile = which(st(1).file);
[filepath,name,ext] = fileparts(thisFile);
cd(filepath);

%%% START OF STANDARD INSTALLER CODE %%%%%%%%%

%% Clear paths and folders, if needed
if 1==1
    clear flag_Laps_Folders_Initialized
end

if 1==0
    fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
end

if 1==0
    % Resets all paths to factory default
    restoredefaultpath;
end

%% Install dependencies
% Define a universal resource locator (URL) pointing to the repos of
% dependencies to install. Note that DebugTools is always installed
% automatically, first, even if not listed:
clear dependencyURLs dependencySubfolders
ith_repo = 0;

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_PathTools_GetUserInputPath';
dependencySubfolders{ith_repo} = {''};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad';
dependencySubfolders{ith_repo} = {'Functions','Data'};

% ith_repo = ith_repo+1;
% dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_GeomTools_GeomClassLibrary';
% dependencySubfolders{ith_repo} = {'Functions','Data'};

% ith_repo = ith_repo+1;
% dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_MapTools_MapGenClassLibrary';
% dependencySubfolders{ith_repo} = {'Functions','testFixtures','GridMapGen'};



%% Do we need to set up the work space?
if ~exist('flag_Laps_Folders_Initialized','var')
    
    % Clear prior global variable flags
    clear global FLAG_*

    % Navigate to the Installer directory
    currentFolder = pwd;
    cd('Installer');
    % Create a function handle
    func_handle = @fcn_DebugTools_autoInstallRepos;

    % Return to the original directory
    cd(currentFolder);

    % Call the function to do the install
    func_handle(dependencyURLs, dependencySubfolders, (0), (-1));

    % Add this function's folders to the path
    this_project_folders = {...
        'Functions','Data'};
    fcn_DebugTools_addSubdirectoriesToPath(pwd,this_project_folders)

    flag_Laps_Folders_Initialized = 1;
end

%%% END OF STANDARD INSTALLER CODE %%%%%%%%%

%% Set environment flags for input checking in Laps library
% These are values to set if we want to check inputs or do debugging
setenv('MATLABFLAG_LAPS_FLAG_CHECK_INPUTS','1');
setenv('MATLABFLAG_LAPS_FLAG_DO_DEBUG','0');

%% Set environment flags that define the ENU origin
% This sets the "center" of the ENU coordinate system for all plotting
% functions
% Location for Test Track base station
setenv('MATLABFLAG_PLOTROAD_REFERENCE_LATITUDE','40.86368573');
setenv('MATLABFLAG_PLOTROAD_REFERENCE_LONGITUDE','-77.83592832');
setenv('MATLABFLAG_PLOTROAD_REFERENCE_ALTITUDE','344.189');


%% Set environment flags for plotting
% These are values to set if we are forcing image alignment via Lat and Lon
% shifting, when doing geoplot. This is added because the geoplot images
% are very, very slightly off at the test track, which is confusing when
% plotting data
setenv('MATLABFLAG_PLOTROAD_ALIGNMATLABLLAPLOTTINGIMAGES_LAT','-0.0000008');
setenv('MATLABFLAG_PLOTROAD_ALIGNMATLABLLAPLOTTINGIMAGES_LON','0.0000054');

%% Check if repo is ready for release
if 1==0
	figNum = 999999;
	repoShortName = '_Laps_';
	fcn_DebugTools_testRepoForRelease(repoShortName, (figNum));
end

%% Start of Demo Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   _____ _             _            __   _____                          _____          _
%  / ____| |           | |          / _| |  __ \                        / ____|        | |
% | (___ | |_ __ _ _ __| |_    ___ | |_  | |  | | ___ _ __ ___   ___   | |     ___   __| | ___
%  \___ \| __/ _` | '__| __|  / _ \|  _| | |  | |/ _ \ '_ ` _ \ / _ \  | |    / _ \ / _` |/ _ \
%  ____) | || (_| | |  | |_  | (_) | |   | |__| |  __/ | | | | | (_) | | |___| (_) | (_| |  __/
% |_____/ \__\__,_|_|   \__|  \___/|_|   |_____/ \___|_| |_| |_|\___/   \_____\___/ \__,_|\___|
%
%
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Start%20of%20Demo%20Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Welcome to the demo code for the Laps library!')

%% Using Zone Definitions to Define Start, End, and Excursion Locations
% To define the start, end, and excursion locations for data, the data must
% pass through or nearby a geolocation which is hereafter called a "zone
% definition". There are two types of zone definitions used in this code:
%%
%
% * Point methods of zone definitions - this is when a start, stop, or
% excursion is defined by "passing by" a point. For example, if a journey
% is said to start at someone's house and go to someone's office, then the
% location of the house and office define the start and end of the journey.
% The specification is given by an X,Y location and a radius in the form of
% [X Y radius], as a 3x1 matrix. Whenever the path passes within the radius
% with a specified number of points within that radius, the minimum
% distance point then "triggers" the zone.
% * Line segment methods of zone definitions - this when a start, stop, or
% excursion condition is defined by a path passing through a line segment.
% The line segment is given by the X,Y coordinates of the start and stop of
% the line segment, in the form [Xstart Ystart; Xend Yend], thus producing
% a 2x2 matrix. An example of a line segment definition is the start line
% and finish line of a race.
%
% To illustrate both definitions, we first create some data to plot:

full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<PREALL>

path_examples = cell(2,1);
path_examples{1} = [-1*ones_full_steps full_steps];
path_examples{2} = [1*ones_full_steps full_steps];

% Each of the path_example matrices above can be plotted easily using the
% "plotLapsXY" subfunction

% Plot the results via fcn_Laps_plotLapsXY
figNum = 222;
fcn_Laps_plotLapsXY(path_examples,figNum);

%%
% Now, use a zone plotting tool to show the point and line-segment types of
% zone definitions. The point definition is shown in green, and the segment
% definition is shown in blue. The segment definition includes an arrow
% that points in the direction of an allowable crossing.

figNum = 444;

zone_center = [0.8 0];
zone_radius = 2;
num_points = 3;
point_zone_definition = [zone_radius num_points zone_center];
fcn_Laps_plotPointZoneDefinition(point_zone_definition,'g',figNum);

segment_zone_definition = [0.8 0; 1.2 0];
fcn_Laps_plotSegmentZoneDefinition(segment_zone_definition,'b',figNum);


%%
% Show we can get the same plot now via a combined function

figNum = 4443;
fcn_Laps_plotZoneDefinition(point_zone_definition,'g',figNum);
fcn_Laps_plotZoneDefinition(segment_zone_definition,'b',figNum);

%% Point zone evaluations
% The function, fcn_Laps_findPointZoneStartStopAndMinimum, uses a point
% zone evaluation to determine portions of a segment that are within a
% point zone definition. For example, if the path does not cross into the
% zone, nothing is returned:
figNum = 1;

query_path = ...
    [full_steps 0.4*ones_full_steps];

zone_center = [0 0 0.2]; % Located at [0,0]
zone_radius = 0.2; % with radius 0.2
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));

%%
% And, the default is that three points must be within the zone. So, if a
% path only crosses one or two points, then nothing is returned.

figNum = 2;

query_path = ...
    [full_steps 0.2*ones_full_steps];

zone_center = [0 0 0.2]; % Located at [0,0]
zone_radius = 0.2; % with radius 0.2
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));


% Show that 2 points still doesn't work
query_path = ...
    [full_steps 0.2*ones_full_steps];

zone_center = [0.05 0 0.2]; % Located at [0.05,0]
zone_radius = 0.23; % with radius 0.23
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));


%%
% But, if a path crosses the zone with at least three points, then the
% indices of the start, end, and minimum of the path are returned.
figNum = 3;

query_path = ...
    [half_steps zero_half_steps];

zone_center = [-0.02 0 0.2]; % Located at [-0.02,0]
zone_radius = 0.2; % with radius 0.2
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

assert(isequal(zone_start_indices,9));
assert(isequal(zone_end_indices,11));
assert(isequal(zone_min_indices,11));

%%
% If there are multiple crossings of the zone, then indices of the
% start/stop/minimum are returned for each crossing:
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1);

minimum_number_of_indices_in_zone = 3;
figNum = 5;


query_path = ...
    [full_steps 0*ones_full_steps; -full_steps 0.1*ones_full_steps; full_steps 0.2*ones_full_steps ];

zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    minimum_number_of_indices_in_zone,...
    figNum);

assert(isequal(zone_start_indices,[10; 30]));
assert(isequal(zone_end_indices,  [13; 33]));
assert(isequal(zone_min_indices,  [12; 31]));


%% Create sample paths
% To illustrate the functionality of this library, we call the library
% function fillPathViaUserInputs which fills in an array of "path" types.
% Load some test data and plot it in figure 1

% Call the function to fill in an array of "path" type
laps_array = fcn_Laps_fillSampleLaps;


% Plot all the laps one at a time
figNum = 22323;
for ith_example = 1:length(laps_array)
    single_lap = laps_array{ith_example};
    fcn_Laps_plotLapsXY({single_lap},figNum);
end

% Plot all the laps at once
figNum = 22324;
fcn_Laps_plotLapsXY(laps_array,figNum);

%% Show fcn_Laps_plotZoneDefinition.m
% Plots the zone, allowing user-defined colors. For example, the figure
% below shows a radial zone for the start, and a line segment for the end.
start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0 0]
fcn_Laps_plotZoneDefinition(start_definition,'g',figNum);

end_definition = [40 -40; 80 -40]; % must cross a line segment starting at [40 -40], ending at [80 -40]
fcn_Laps_plotZoneDefinition(end_definition,'r',figNum);

%% Call the fcn_Laps_breakDataIntoLaps function, plot in figure 2
% Test of fcn_Laps_breakDataIntoLaps.m : This is the core function for this
% repo that breaks data into laps. Note: for radial zone definitions, the
% image illustrates how a lap starts at the first point within a start
% zone, and ends at the last point before exiting the end zone.
start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0 0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]

excursion_definition = []; % empty
figNum = 2;
lap_traversals = fcn_Laps_breakDataIntoLaps(...
    laps_array{1},...
    start_definition,...
    end_definition,...
    excursion_definition,...
    figNum);

% Do we get 3 laps?
assert(isequal(3,length(lap_traversals)));


%% Show the use of segment definition
figNum = 10004;
titleString = sprintf('DEMO case: Show the use of segment definition');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

dataSetNumber = 9;

% Load some test data by calling the function to fill in an array of "path" type
laps_array = fcn_Laps_fillSampleLaps(-1);

% Use the last data
tempXYdata = laps_array{dataSetNumber};

start_definition = [10 0; -10 0]; % start at [10 0], end at [-10 0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    figNum);


% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 3;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isequal(86,length(lap_cellArrayOfPaths{1}(:,1))));
assert(isequal(97,length(lap_cellArrayOfPaths{2}(:,1))));
assert(isequal(78,length(lap_cellArrayOfPaths{3}(:,1))));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

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

%% function fcn_INTERNAL_clearUtilitiesFromPathAndFolders
function fcn_INTERNAL_clearUtilitiesFromPathAndFolders
% Clear out the variables
clear global flag* FLAG*
clear flag*
clear path

% Clear out any path directories under Utilities
path_dirs = regexp(path,'[;]','split');
utilities_dir = fullfile(pwd,filesep,'Utilities');
for ith_dir = 1:length(path_dirs)
    utility_flag = strfind(path_dirs{ith_dir},utilities_dir);
    if ~isempty(utility_flag)
        rmpath(path_dirs{ith_dir});
    end
end

% Delete the Utilities folder, to be extra clean!
if  exist(utilities_dir,'dir')
    [status,message,message_ID] = rmdir(utilities_dir,'s');
    if 0==status
        error('Unable remove directory: %s \nReason message: %s \nand message_ID: %s\n',utilities_dir, message,message_ID);
    end
end

end % Ends fcn_INTERNAL_clearUtilitiesFromPathAndFolders

