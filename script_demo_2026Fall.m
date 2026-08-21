%% Introduction to and Purpose of the Code
% This is the explanation of the code that can be found by running
%
%       script_demo_2026Spring.m
%
% This is a script to demonstrate the functions within the VD2026 code
% library. This code repo is typically located at:
%
%   https://github.com/ivsg-psu/Classes_VehicleDynamics_2026Spring
%
% If you have questions or comments, please contact Sean Brennan at
% sbrennan@psu.edu
%
% The purpose of the code is deploy content - assignments, presentations,
% documents, codes - in support of the 2026 Vehicle Dynamics course.

% REVISION HISTORY:
% 
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - First edit of the repo from the "Laps" library template
%
% 2026_02_12 by Sean Brennan, sbrennan@psu.edu
% - Cleanup of incorrect code pushed in by prior students, 
% - In script_demo_VD2026
%   % * Added automatic creation of StudentWork folder
%
% 2026_02_20 by Sean Brennan, sbrennan@psu.edu
% - In script_demo_2026Spring.m
%   % * Renamed to avoid confusion with VD subrepo


% TO-DO:
% - 2026_01_12 by Sean Brennan, sbrennan@psu.edu
%   % * Finish posting week-by-week presentations
%   % * Add quiz codes


%% Make sure we are running out of root directory
st = dbstack; 
thisFile = which(st(1).file);
[filepath,name,ext] = fileparts(thisFile);
cd(filepath);

%%% START OF STANDARD INSTALLER CODE %%%%%%%%%

%% Clear paths and folders, if needed
if 1==1
    clear flag_VD2026_Folders_Initialized
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

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/Classes_Grading_PrepareSubmission';
dependencySubfolders{ith_repo} = {''};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_GeomTools_GeomClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/FieldDataCollection_GPSRelatedCodes_GPSClass';
dependencySubfolders{ith_repo} = {'Functions'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/Classes_VehicleDynamics_2026VDLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};

% ith_repo = ith_repo+1;
% dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_GeomTools_GeomClassLibrary';
% dependencySubfolders{ith_repo} = {'Functions','Data'};

% ith_repo = ith_repo+1;
% dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_MapTools_MapGenClassLibrary';
% dependencySubfolders{ith_repo} = {'Functions','testFixtures','GridMapGen'};



%% Do we need to set up the work space?
if ~exist('flag_VD2026_Folders_Initialized','var')
    
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
        'Functions','Data','Assignments'};
    fcn_DebugTools_addSubdirectoriesToPath(pwd,this_project_folders)

    flag_VD2026_Folders_Initialized = 1;
end

%%% END OF STANDARD INSTALLER CODE %%%%%%%%%

%% Set environment flags for input checking in VD2026 library
% These are values to set if we want to check inputs or do debugging
setenv('MATLABFLAG_VD2026_FLAG_CHECK_INPUTS','1');
setenv('MATLABFLAG_VD2026_FLAG_DO_DEBUG','0');

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

%% Set up warnings
thisVersion = version('-release');

% Confirm that this is 2025b
if ~strcmpi(thisVersion,'2025b')
	warning('Expected release version 2025b, but found %s instead.',thisVersion);
	fcn_DebugTools_cprintf('*red','Many errors may be introduced by using an out-of-date MATLAB version. Students using out of date versions are far more likely to face additional challenges in completing assignments.');
	fprintf(1,'Press any key to continue.\n');
	pause;
end

thisPath = pwd;

% Confirm that path contains no spaces
if contains(thisPath,' ') 
	warning('A space character was found in the working path: %s. Spaces in file names and paths can cause evaluation errors in some of the functions within this code set.',thisPath);
	fcn_DebugTools_cprintf('*red','Please consider installing the code into a folder that has no spaces.');
	fprintf(1,'Press any key to continue.\n');
	pause;
end

% Confirm that path contains no minus signs
if contains(thisPath,'-') 
	warning('A minus character was found in the working path: %s. Minus signs in file names and paths will cause evaluation errors in some of the functions within this code set.',thisPath);
	fcn_DebugTools_cprintf('*red','Please re-install the code into a folder that has no minus signs in the path name.');
	fprintf(1,'Press any key to continue.\n');
	pause;
end


%% Create Submissions folder
if ~exist(fullfile(pwd,'Submissions'),'dir')
	mkdir('Submissions');
end

%% Create StudentWork folder
if ~exist(fullfile(pwd,'StudentWork'),'dir')
	mkdir('StudentWork');
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

disp('Welcome to the demo code for the VD2026 library!')
fprintf(1,'Press any key to continue to the open assignments.\n');
pause;

% script_Week01_HW01
% script_Week02_HW02

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

