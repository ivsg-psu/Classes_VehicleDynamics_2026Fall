function fcn_DebugTools_autoInstallRepos(...
	dependencyURLs, dependencySubfolders, varargin)
%% FCN_DEBUGTOOLS_AUTOINSTALLREPOS - MATLAB package installer from URL
%
% FCN_DEBUGTOOLS_AUTOINSTALLREPOS automatically installs GitHub repos. Each
% repo is specified by a URL pointing to the GitHub site.
%
% For each repo, GitHub is queried to determine the latest version of that
% repo. The Utilities folder, if it exists, is queried to determine if the
% latest version is installed. If the folder name matches the latest
% release, the installation is skipped. An optional input flag can be used
% to force clearing and installation of previously installed repos, even if
% these are the same version.
%
% For all installations, by default, the DebugTools latest release is
% always checked and installed if it is not the latest version. After
% install, this function, fcn_DebugTools_autoInstallRepos, is copied into
% the Functions folder so that this function can be called in code releases
% even without DebugTools installed yet.
%
% All installs are pulled from the latest version (as a zip file) into a
% default local subfolder, "Utilities", under the root folder. The install
% process also adds either the package subfoder or any specified
% sub-subfolders to the MATLAB path.
%
% If the Utilities folder does not exist, it is created.
%
% If the specified code package folder and all subfolders already exist,
% the package is not installed. Otherwise, the folders are created as
% needed, and the package is installed.
%
% If one does not wish to put these codes in different directories, the
% function can be easily modified with strings specifying the
% desired install location.
%
% For path creation, if the "DebugTools" package is being installed, the
% code installs the package, then shifts temporarily into the package to
% complete the path definitions for MATLAB. If the DebugTools is not
% already and/or successfully installed, an error is thrown as these tools
% are needed for the path creation.
%
% Finally, the code sets a global flag to indicate that the folders are
% initialized so that, in this session, if the code is called again, then
% the folders will not be installed. This global flag can be overwritten by
% an optional flag input.
%
% FORMAT:
%
%      fcn_DebugTools_autoInstallRepos(...
%           dependency_name, ...
%           dependencySubfolders, ...
%           dependencyURLs)
%
% INPUTS:
%
%      dependencyURLs: a cell array of the URLs pointing to the repo
%      location(s).
%
%      dependencySubfolders: in addition to the package subfoder, a list
%      of any specified sub-subfolders to the MATLAB path. Leave blank to
%      add only the package subfolder to the path. See the example in the
%      test script.
%
%      (OPTIONAL INPUTS)
%
%      flagForceInstalls: if any value other than zero, forces the
%      install to occur even if the global flag is set.
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. As well, if given, this forces the
%      variable types to be displayed as output and as well makes the input
%      check process verbose
%
% OUTPUTS:
%
%      (none into workspace - installs files into Utilities subfolder)
%
% DEPENDENCIES:
%
%      This code will automatically get dependent files from the internet,
%      but of course this requires an internet connection. If the
%      DebugTools are being installed, it does not require any other
%      functions. But for other packages, it uses the following from the
%      DebugTools library: fcn_INTERNAL_addSubdirectoriesToPath
%
% EXAMPLES:
%      See: script_test_fcn_DebugTools_autoInstallRepos
%
% (another example)
%
% % Define the name of subfolder to be created in "Utilities" subfolder
% dependency_name = 'DebugTools_v2023_01_18';
%
% % Define sub-subfolders that are in the code package that also need to be
% % added to the MATLAB path after install; the package install subfolder
% % is NOT added to path. OR: Leave empty ({}) to only add
% % the subfolder path without any sub-subfolder path additions.
% dependencySubfolders = {'Functions','Data'};
%
% % Define a universal resource locator (URL) pointing to the zip file to
% % install. For example, here is the zip file location to the Debugtools
% % package on GitHub:
% dependencyURLs = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_18.zip?raw=true';
%
% % Call the function to do the install
% fcn_DebugTools_autoInstallRepos(dependency_name, dependencySubfolders, dependencyURLs)
%
% This function was written on 2023_01_23 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2025_11_10 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally
%
% 2025_11_16 by Sean Brennan, sbrennan@psu.edu
% - Improved error handling. Made warnings verbose for EVERY error call.
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum
% - Updated docstrings to point to test script
%
% 2026_01_21 by Aneesh Batcu, abb6486@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Modified a few lines to make Installer compatible for MAC
%   % * Main difference: Macs require * as query instead of *.* because the
%   %   % finder keeps files that have only extensions but no name, like
%   %   % ".something". Similarly, all rmdir commands require 's' for
%   %   % sequential removes because MAC folders may contain subfolders
%
% 2026_01_25 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Fixed bug on line 343 where utilities_dir variable called but not
%   %   % defined. Now directoryPath variable used
%   % * Added input checking
%
% 2026_03_24 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Updated version of DebugTools so it will auto-install correctly
%
% 2026_10_01 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Updated flags to allow Linux/Unix usage
%   % * Updated default installer to current version
%
% 2026_11_14 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Major restructuring and rewrite to avoid internet usage
%   % * Automatically recovers previously installed packages if no internet
%   % * Confirms current packages are up-to-date if there is internet
%   % * If current package is up-to-date, does not install
%
% 2026_11_14b by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Fixed bug where dependency_name was not updated correctly
%
% 2026_11_14c by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Moved fcn_INTERNAL_addSubdirectoriesToPath internally to avoid
%   %   % issues with unrecognized function calls
%   % * Fixed several other exposed DebugTool calls with INTERNAL copies
% 
% 2026_11_16 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Changed default URL to Google's DNS to avoid issues with MacOS,
%   %   % within fcn_INTERNAL_isThisComputerOnline (same change as in external
%   %   % function)
% 
% 2026_11_17 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_autoInstallRepos
%   % * Updated fcn_INTERNAL_isThisComputerOnline
%   % * Same change as in external function

% TO-DO:
% - Would like to have the following functionality:
% During the install, the packages needed for each dependency are also
% checked and added to the dependency list. Thus, if a dependency that is
% listed contains unlisted dependencies, then the unlisted dependencies are
% also added. The only exception to this is if a dependency is listed that
% is the same as the target code set: for example, if install of the
% PathTools library depends on MapTools, and MapTools depends on PathTools,
% then PathTools is NOT installed as a Utility under PathTools alongside
% MapTools.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
	flag_do_debug = 0; %     % Flag to plot the results for debugging
	flag_check_inputs = 0; % Flag to perform input checking
	flag_max_speed = 1;
else
	% Check to see if we are externally setting debug mode to be "on"
	flag_do_debug = 0; %     % Flag to plot the results for debugging
	flag_check_inputs = 1; % Flag to perform input checking
	MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
	MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
	if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
		flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG);
		flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
	end
end

% flag_do_debug = 1;

if flag_do_debug
	st = dbstack; %#ok<*UNRCH>
	fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
	debug_figNum = 999978;
else
	debug_figNum = [];
end
%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
	if flag_check_inputs == 1
		% Are there the right number of inputs?
		narginchk(2,MAX_NARGIN);

		% Check the dependencyURLs to be sure it is a text style or cell
		% string
		if ~iscell(dependencyURLs)
			if ~ischar(dependencyURLs) && ~isstring(dependencyURLs)
				warning('backtrace','on');
				warning('Unrecognized type for input argument dependencyURLs. Must exit.');
				error('Unable to recognize dependencyURLs input. Expecting a character or string, but type was neither. Exiting');
			end
		end

		% Check the dependencySubfolders to be sure it is empty or cell
		if ~iscell(dependencySubfolders)
			if ~isempty(dependencySubfolders)
				warning('backtrace','on');
				warning('Unrecognized type for input argument dependencySubfolders. Must exit.');
				error('Unable to recognize dependency subfolder input. Exiting');
			end

		end

	end
end

% Does user want to specify the flagForceInstalls input?
flagForceInstalls = false; % Default is not to force installs
if 3 <= nargin
	temp = varargin{1};
	if ~isempty(temp)
		flagForceInstalls = temp;
	end
end

% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
	temp = varargin{end};
	if ~isempty(temp)
		figNum = temp;
		flag_do_plots = 1;
	end
end

%% Set the global variables - need this for input checking
% Create a variable name for our flag. Stylistically, global variables are
% usually all caps.
leftovers = pwd;
keepGoing = 1;
while keepGoing
	shorterPath = leftovers;
	leftovers = extractAfter(shorterPath,filesep);
	if isempty(leftovers)
		keepGoing = 0;
	end
end
dependency_name = shorterPath;

flag_varname = upper(cat(2,'flag_',dependency_name,'_Folders_Initialized'));

% Make the variable global
eval(sprintf('global %s',flag_varname));

if nargin>=3
	if flagForceInstalls
		eval(sprintf('clear global %s',flag_varname));
	end
end


%% Start of main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%See: http://patorjk.com/software/taag/#p=display&f=Big&t=Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§

% Check to see if this function should be skipped
if exist(flag_varname,'var') && ~isempty(eval(flag_varname))
	fprintf(1,'All dependency repos appear to have been previously installed.\n');
	return
end

% If user gives a string URL input, convert into cell array for consistency
if ~iscell(dependencyURLs)
	dependencyURLs = {dependencyURLs};
end


% Make a list of all repos that are requested to be installed. Make sure
% DebugTools is the first one.
[orderedListOfRequestedInstalls, orderedListOfSubfolders] = ...
	fcn_INTERNAL_confirmDebugToolsIsFirstOnInstallList(dependencyURLs, dependencySubfolders);

% Save the root directory, so we can get back to it after some of the
% operations below. We use the Print Working Directory command (pwd) to
% do this. Note: this command is from Unix/Linux world, but is so
% useful that MATLAB made their own!
root_directory_name = pwd;

%% Check to see if DebugTools is available
% This section checks to see if DebugTools is installed and, if there's
% internet, whether the installation is the latest version. There's 4
% possible results:
%
% * CASE 1: There's no internet and it is not previously installed - throw
% an error because there's nothing we can do
%
% * CASE 2: There's no internet and it was previously installed - use the
% old version and warn the user
%
% * CASE 3: There's internet and it is not previously installed - must
% install
%
% * CASE 4: There's internet and it was previously installed - check the
% old version and compare to the new, and only update if they are different
%

latestDebugReleaseName = [];
% Check if previous DebugTool installs exist?
flag_previousDebugFound = fcn_INTERNAL_checkForPriorDebugInstall;

% Check if online using internal tool
flag_isOnline = fcn_INTERNAL_isThisComputerOnline;

% Eliminate the bad case first - the computer is offline and no previous
% install found
flag_debugInstallNeeded = []; % Set equal to blank to create a fail case
if ~flag_isOnline
	% We are offline
	if ~flag_previousDebugFound
		% This is CASE1
		error('An install is needed of DebugTools, but the computer is offline and no previous installations could be found. Must exit.')

	else
		% This is CASE2
		% If a prior debug was found, get that release name and use it as
		% standby
		% Only enter here if we found a prior release and we are not
		% online. Assume using latest release if prior install, but warn user
		saved = warning("query","backtrace");
		warning("off","backtrace");
		warning('Computer is offline, but prior version of DebugTools was found. Using this prior version');
		warning(saved);
		flag_debugInstallNeeded = false;

		searchString = fullfile(pwd,'Utilities',cat(2,'DebugTools','*'));
		tempPath = dir(searchString);
		latestDebugReleaseName = tempPath(end).name;
	end
else
	% We we are online, so check latest release... Pull out owner and repoName of DebugTools
	[owner, repoName] = fcn_INTERNAL_extractOwnerAndRepoFromURL('https://github.com/ivsg-psu/Errata_Tutorials_DebugTools');
	latestReleaseStruct = fcn_INTERNAL_findLatestGitHubRelease(owner, repoName, (-1));
	latestDebugReleaseName      = latestReleaseStruct.tag_name;

	if ~flag_previousDebugFound
		% CASE 3: No previous version were found, so we MUST install
		flag_debugInstallNeeded = true;
	else

		% * CASE 4: There's internet and it was previously installed - check the
		% old version and compare to the new, and only update if they are different
		
		% Check if this exact release already exists in Utilities
		searchString = fullfile(pwd,'Utilities'); %,latestDebugReleaseName);
		tempPath = dir(searchString);
		% Is there anything inside the Utilities folder?
		if isempty(tempPath)
			% Nothing is there
			flag_debugInstallNeeded = true;
		else
			% Check if any names match the most recent DebugTools version
			installedNames = {tempPath.name}';
			matches = strcmp(installedNames,latestDebugReleaseName);
			if ~any(matches)
				% The online version does NOT match the one installed, so need
				% to install
				flag_debugInstallNeeded = true;
			else
				% The exact same version was found. No install needed!
				flag_debugInstallNeeded = false;
			end
		end
	end
end

% At this point, we should know if we need to do an install
% Check fail case
if isempty(flag_debugInstallNeeded)
	error('An unexpected fail case occurred in AutoInstall of DebugTools. Exiting!');
end

flag_debugToolsWasInstalled = false;
if flag_debugInstallNeeded
	% Check fail case
	if isempty(latestDebugReleaseName)
		error('Unable to find any DebugTools releases to add to path. Must exit!');
	end
	if flag_isOnline
		fprintf(1,'\tAdding library: %s ...',latestDebugReleaseName);

		% Install DebugTools using internal function and trusted repo
		dependency_name      = latestDebugReleaseName;
		dependency_subfolders = {'Functions','Data'};
		dependency_url        = cat(2,'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/',...
			latestDebugReleaseName,'.zip');
		fcn_INTERNAL_installDependencies(latestDebugReleaseName, dependency_subfolders, dependency_url);

		% Make sure it worked
		expectedDirectory = fullfile(pwd,'Utilities',dependency_name);
		if ~exist(expectedDirectory,'dir')
			warning('backtrace','on');
			warning('Attempted install but expected directory was not created.');
			error('Unable to add directory: %s Must quit!\n',expectedDirectory);
		else
			fprintf(1,'Done.\n');
		end


		flag_debugToolsWasInstalled = true;
	else
		% Add latest release to the path
		debugDirectory = fullfile(pwd,'Utilities',latestDebugReleaseName);
		fcn_INTERNAL_addSubdirectoriesToPath(debugDirectory,{'Functions','Data'});

	end %
else
	fprintf(1,'\tUsing previously installed library: %s\n',latestDebugReleaseName);
end

%% Other folders
% Loop over installs of non-debug folders
for ith_repo = 1:length(orderedListOfRequestedInstalls)

	thisURL = orderedListOfRequestedInstalls{ith_repo};

	% Pull out owner and repoName
	[owner, repoName] = fcn_INTERNAL_extractOwnerAndRepoFromURL(thisURL);

	% Check latest release
	latestReleaseStruct = fcn_INTERNAL_findLatestGitHubRelease(owner, repoName, (-1));

	dependency_name      = latestReleaseStruct.tag_name;
	dependency_subfolders = orderedListOfSubfolders{ith_repo,1};
	dependency_url        = cat(2,'https://github.com/',...
		owner,'/',...
		repoName,'/archive/refs/tags/',...
		dependency_name,'.zip');

	% Check if prior releases exist in Utilities
	shortDependencyName = extractBefore(dependency_name,'_');
	searchString = fullfile(pwd,'Utilities',cat(2,shortDependencyName,'*'));
	tempPath = dir(searchString);
	flagsReposToRemove = ~strcmp({tempPath.name},dependency_name);
	thisFolder = fullfile(pwd,'Utilities');
	for ith_flag = 1:length(flagsReposToRemove)
		if flagsReposToRemove(ith_flag)
			thisDirectory = tempPath(ith_flag).name;
			fprintf(1,'\tRemoving deprecated library: %s ...',thisDirectory);
			directoryPath = fullfile(thisFolder, thisDirectory);

			% Remove the folder from the path
			% Clear out any path directories under Utilities
			path_dirs = regexp(path,pathsep,'split');
			for ith_dir = 1:length(path_dirs)
				utility_flag = strfind(path_dirs{ith_dir},directoryPath);
				if ~isempty(utility_flag)
					rmpath(path_dirs{ith_dir});
				end
			end

			% Erase the folder
			[status,message,message_ID] = rmdir(directoryPath,'s');
			if 0==status
				warning('backtrace','on');
				warning('Attempted to remove a directory but encountered error.');
				error('Unable remove directory: %s \nReason message: %s \nand message_ID: %s\n',directoryPath, message,message_ID);
			else
				fprintf(1,'Done.\n');
			end
		end
	end

	% Perform install of latest version
	expectedDirectory = fullfile(pwd,'Utilities',dependency_name);

	% If the directory does not exist, or if this is DebugTools, need to
	% install or link.
	if ~exist(expectedDirectory,'dir') 
		fprintf(1,'\tAdding library: %s ...',dependency_name);
		fcn_INTERNAL_installDependencies(dependency_name, dependency_subfolders, dependency_url);

		% Make sure it worked
		if ~exist(expectedDirectory,'dir')
			warning('backtrace','on');
			warning('Attempted install but expected directory was not created.');
			error('Unable to add directory: %s Must quit!\n',expectedDirectory);
		else
			fprintf(1,'Done.\n');
		end
	else
		fprintf(1,'\tSkipping already installed library: %s\n',dependency_name);
		fcn_INTERNAL_addSubdirectoriesToPath(expectedDirectory,dependency_subfolders);
	end

	% If Debug install, copy this file into Installer folder UNLESS debugging within
	% DebugTools (as this overwrites the changes!!)
	if ith_repo==1 && flag_debugToolsWasInstalled

		% Does the directory "Installer" exist?
		installler_folder_name = fullfile(root_directory_name,'Installer');
		if ~exist(installler_folder_name,'dir')
			% If we are in here, the directory does not exist. So create it
			% using mkdir
			[success_flag,error_message,message_ID] = mkdir(root_directory_name,'Installer');

			% Did it work?
			if ~success_flag
				warning('backtrace','on');
				warning('Difficulty creating installer directory');
				error('Unable to make the Installer directory. Reason: %s with message ID: %s\n',error_message,message_ID);
			elseif ~isempty(error_message)
				warning('backtrace','on');
				warning('The Installer directory was created, but with a warning: %s\n and message ID: %s\n(continuing)\n',error_message, message_ID);
			end

		end

		st = dbstack;
		sourceFileName = st(1).file;
		fullSourcePath = fullfile(expectedDirectory,'Functions',sourceFileName);
		if exist(fullSourcePath,'file')~=2
			warning('backtrace','on');
			warning('Difficulty finding installer file.');
			error('Unable to find Installer file: \n\t%s\nfor copy into the Install folder. Exiting.',fullSourcePath);
		end

		destionationToCopy = fullfile(pwd,'Installer');

		fprintf(1,'\tCopying function %s to Installer folder...', st(1).file)

		[success_flag,error_message,message_ID] = copyfile(fullSourcePath,destionationToCopy,'f');

		% Did it work?
		if ~success_flag
			warning('backtrace','on');
			warning('Error encountered in copying into Installer directory.');
			error('Unable to copy source: \n\t%s\nTo the Installer directory: \n\t%s\n. Reason: \n\t%s\nWith message ID:\n\t %s\n',fullSourcePath, destionationToCopy, error_message, message_ID);
		elseif ~isempty(error_message)
			warning('backtrace','on');
			warning('The copy succeeded but with a warning: %s\n and message ID: %s\n(continuing)\n',error_message, message_ID);
		else
			fprintf(1,'Done.\n');
		end
	end
end


%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if flag_do_plots
	% % Extract and display release information
	% disp(['Repository: ', owner, '/', repo]);
	% if isfield(latestReleaseStruct, 'tag_name')
	%     disp(['Latest release version: ', latestReleaseStruct.tag_name]);
	% else
	%     disp('Could not find tag_name in the release information.');
	% end
	%
	% if isfield(latestReleaseStruct, 'name')
	%     disp(['Release Name: ', latestReleaseStruct.name]);
	% end
	%
	% if isfield(latestReleaseStruct, 'published_at')
	%     disp(['Published At: ', latestReleaseStruct.published_at]);
	% end
	%
	% if isfield(latestReleaseStruct, 'body')
	%     disp('Release Notes:');
	%     disp(latestReleaseStruct.body);
	% end
end % Ends the flag_do_plot if statement

if flag_do_debug
	fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end


end % Ends the function

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


function fcn_INTERNAL_installDependencies(dependency_name, dependency_subfolders, dependency_url, varargin)
%% fcn_INTERNAL_installDependencies - MATLAB package installer from URL
%
% fcn_INTERNAL_installDependencies installs code packages that are
% specified by a URL pointing to a zip file into a default local subfolder,
% "Utilities", under the root folder. It also adds either the package
% subfoder or any specified sub-subfolders to the MATLAB path.
%
% If the Utilities folder does not exist, it is created.
%
% If the specified code package folder and all subfolders already exist,
% the package is not installed. Otherwise, the folders are created as
% needed, and the package is installed.
%
% If one does not wish to put these codes in different directories, the
% function can be easily modified with strings specifying the
% desired install location.
%
% For path creation, if the "DebugTools" package is being installed, the
% code installs the package, then shifts temporarily into the package to
% complete the path definitions for MATLAB. If the DebugTools is not
% already installed, an error is thrown as these tools are needed for the
% path creation.
%
% Finally, the code sets a global flag to indicate that the folders are
% initialized so that, in this session, if the code is called again the
% folders will not be installed. This global flag can be overwritten by an
% optional flag input.
%
% FORMAT:
%
%      fcn_INTERNAL_installDependencies(...
%           dependency_name, ...
%           dependency_subfolders, ...
%           dependency_url, (flag_force_creation))
%
% INPUTS:
%
%      dependency_name: the name given to the subfolder in the Utilities
%      directory for the package install
%
%      dependency_subfolders: in addition to the package subfoder, a list
%      of any specified sub-subfolders to the MATLAB path. Leave blank to
%      add only the package subfolder to the path. See the example below.
%
%      dependency_url: the URL pointing to the code package.
%
%      (OPTIONAL INPUTS)
%      flag_force_creation: if any value other than zero, forces the
%      install to occur even if the global flag is set.
%
% OUTPUTS:
%
%      (none)
%
% DEPENDENCIES:
%
%      This code will automatically get dependent files from the internet,
%      but of course this requires an internet connection. If the
%      DebugTools are being installed, it does not require any other
%      functions. But for other packages, it uses the following from the
%      DebugTools library: fcn_INTERNAL_addSubdirectoriesToPath
%
% EXAMPLES:
%
% % Define the name of subfolder to be created in "Utilities" subfolder
% dependency_name = 'DebugTools_v2023_01_18';
%
% % Define sub-subfolders that are in the code package that also need to be
% % added to the MATLAB path after install; the package install subfolder
% % is NOT added to path. OR: Leave empty ({}) to only add
% % the subfolder path without any sub-subfolder path additions.
% dependency_subfolders = {'Functions','Data'};
%
% % Define a universal resource locator (URL) pointing to the zip file to
% % install. For example, here is the zip file location to the Debugtools
% % package on GitHub:
% dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_18.zip?raw=true';
%
% % Call the function to do the install
% fcn_INTERNAL_installDependencies(dependency_name, dependency_subfolders, dependency_url)
%
%
% See also: script_test_fcn_DebugTools_autoInstallRepos
%
% This function was written on 2023_01_23 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2025_11_11 by S. Brennan, sbrennan@psu.edu
% - wrote the code originally
%
% 2025_11_12 by S. Brennan, sbrennan@psu.edu
% - updated docstrings in header due to minor issues
% - updated header global flags
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - cleaned up variable naming:
%   % * fig_+num to figNum

% TO-DO:
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Add input argument checking

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
	flag_do_debug = 0; %     % Flag to plot the results for debugging
	flag_check_inputs = 0; % Flag to perform input checking
	flag_max_speed = 1;
else
	% Check to see if we are externally setting debug mode to be "on"
	flag_do_debug = 0; %     % Flag to plot the results for debugging
	flag_check_inputs = 1; % Flag to perform input checking
	MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
	MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
	if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
		flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG);
		flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
	end
end

% flag_do_debug = 1;

if flag_do_debug
	st = dbstack; %#ok<*UNRCH>
	fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
	debug_figNum = 3443534;
else
	debug_figNum = [];
end
%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
	if flag_check_inputs == 1
		% Are there the right number of inputs?
		narginchk(3,MAX_NARGIN);

		% if nargin>=2
		%     % Check the variableTypeString input, make sure it is characters
		%     if ~ischar(variableTypeString)
		%         error('The variableTypeString input must be a character type, for example: ''Path'' ');
		%     end
		% end

	end
end

% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
	temp = varargin{end};
	if ~isempty(temp)
		figNum = temp;
		flag_do_plots = 1;
	end
end

% Setup figures if there is debugging
if flag_do_debug
	fig_debug = 2343432;
else
	fig_debug = []; %#ok<*NASGU>
end

%% Set the global variable - need this for input checking
% Create a variable name for our flag. Stylistically, global variables are
% usually all caps.
flag_varname = upper(cat(2,'flag_',dependency_name,'_Folders_Initialized'));

% Make the variable global
eval(sprintf('global %s',flag_varname));

if nargin==4
	if varargin{1}
		eval(sprintf('clear global %s',flag_varname));
	end
end


%% Main code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if ~exist(flag_varname,'var') || isempty(eval(flag_varname))
	% Save the root directory, so we can get back to it after some of the
	% operations below. We use the Print Working Directory command (pwd) to
	% do this. Note: this command is from Unix/Linux world, but is so
	% useful that MATLAB made their own!
	root_directory_name = pwd;

	% Does the directory "Utilities" exist?
	utilities_folder_name = fullfile(root_directory_name,'Utilities');
	if ~exist(utilities_folder_name,'dir')
		% If we are in here, the directory does not exist. So create it
		% using mkdir
		[success_flag,error_message,message_ID] = mkdir(root_directory_name,'Utilities');

		% Did it work?
		if ~success_flag
			warning('backtrace','on');
			warning('Error encountered in creating Utilities directory.');
			error('Unable to make the Utilities directory. Reason: %s with message ID: %s\n',error_message,message_ID);
		elseif ~isempty(error_message)
			warning('backtrace','on');
			warning('The Utilities directory was created, but with a warning: %s\n and message ID: %s\n(continuing)\n',error_message, message_ID);
		end

	end

	% Does the directory for the dependency folder exist?
	dependency_folder_name = fullfile(root_directory_name,'Utilities',dependency_name);
	if ~exist(dependency_folder_name,'dir')
		% If we are in here, the directory does not exist. So create it
		% using mkdir
		[success_flag,error_message,message_ID] = mkdir(utilities_folder_name,dependency_name);

		% Did it work?
		if ~success_flag
			warning('backtrace','on');
			warning('Error encountered in creating dependency folder in Utilities directory.');
			error('Unable to make the dependency directory: %s. Reason: %s with message ID: %s\n',dependency_name, error_message,message_ID);
		elseif ~isempty(error_message)
			warning('backtrace','on');
			warning('The %s directory was created, but with a warning: %s\n and message ID: %s\n(continuing)\n',dependency_name, error_message, message_ID);
		end

	end

	% Do the subfolders exist?
	flag_allFoldersThere = 1;
	if isempty(dependency_subfolders{1})
		flag_allFoldersThere = 0;
	else
		for ith_folder = 1:length(dependency_subfolders)
			subfolder_name = dependency_subfolders{ith_folder};

			% Create the entire path
			subfunction_folder = fullfile(root_directory_name, 'Utilities', dependency_name,subfolder_name);

			% Check if the folder and file exists that is typically created when
			% unzipping.
			if ~exist(subfunction_folder,'dir')
				flag_allFoldersThere = 0;
			end
		end
	end

	% Do we need to unzip the files?
	if flag_allFoldersThere==0
		% Files do not exist yet - try unzipping them.
		save_file_name = tempname(root_directory_name);
		zip_file_name = websave(save_file_name,dependency_url);
		% CANT GET THIS TO WORK --> unzip(zip_file_url, debugTools_folder_name);

		% Is the file there?
		if ~exist(zip_file_name,'file')
			warning('backtrace','on');
			warning('Error encountered in downloading zip install.');
			error(['The zip file: %s for dependency: %s did not download correctly.\n' ...
				'This is usually because permissions are restricted on ' ...
				'the current directory. Check the code install ' ...
				'(see README.md) and try again.\n'],zip_file_name, dependency_name);
		end

		% Try unzipping
		unzip(zip_file_name, dependency_folder_name);

		% Did this work? If so, directory should not be empty
		directory_contents = dir(dependency_folder_name);
		if isempty(directory_contents)
			warning('backtrace','on');
			warning('Error encountered during unzip operation.');
			error(['The necessary dependency: %s has an error in install ' ...
				'where the zip file downloaded correctly, ' ...
				'but the unzip operation did not put any content ' ...
				'into the correct folder. ' ...
				'This suggests a bad zip file or permissions error ' ...
				'on the local computer.\n'],dependency_name);
		end

		% Check if is a nested install (for example, installing a folder
		% "Toolsets" under a folder called "Toolsets"). This can be found
		% if there's a folder whose name contains the dependency_name
		flag_is_nested_install = 0;
		for ith_entry = 1:length(directory_contents)
			if contains(directory_contents(ith_entry).name,dependency_name)
				if directory_contents(ith_entry).isdir
					flag_is_nested_install = 1;
					install_directory_from = fullfile(directory_contents(ith_entry).folder,directory_contents(ith_entry).name);
					if ispc
						install_files_from = fullfile(directory_contents(ith_entry).folder,directory_contents(ith_entry).name,'*.*'); % For PCs
					elseif ismac
						install_files_from = fullfile(directory_contents(ith_entry).folder,directory_contents(ith_entry).name,'*'); % For Macs
					elseif isunix
						install_files_from = fullfile(directory_contents(ith_entry).folder,directory_contents(ith_entry).name,'*'); % For Unix/Linux
					else
						error('Unrecognized OS encountered?!');
					end
					install_location_to = fullfile(directory_contents(ith_entry).folder);
				end
			end
		end

		if flag_is_nested_install
			[status,message,message_ID] = movefile(install_files_from,install_location_to);
			if 0==status
				warning('backtrace','on');
				warning('Error encountered in moving files during install.');
				error(['Unable to move files from directory: %s\n ' ...
					'To: %s \n' ...
					'Reason message: %s\n' ...
					'And message_ID: %s\n'],install_files_from,install_location_to, message,message_ID);
			end
			[status,message,message_ID] = rmdir(install_directory_from, 's');
			if 0==status
				warning('backtrace','on');
				warning('Error encountered in removing directory during install.');
				error(['Unable remove directory: %s \n' ...
					'Reason message: %s \n' ...
					'And message_ID: %s\n'],install_directory_from,message,message_ID);
			end
		end

		% Make sure the subfolders were created
		flag_allFoldersThere = 1;
		if ~isempty(dependency_subfolders{1})
			for ith_folder = 1:length(dependency_subfolders)
				subfolder_name = dependency_subfolders{ith_folder};

				% Create the entire path
				subfunction_folder = fullfile(root_directory_name, 'Utilities', dependency_name,subfolder_name);

				% Check if the folder and file exists that is typically created when
				% unzipping.
				if ~exist(subfunction_folder,'dir')
					flag_allFoldersThere = 0;
				end
			end
		end
		% If any are not there, then throw an error
		if flag_allFoldersThere==0
			warning('backtrace','on');
			warning('Error encountered in confirming dependency install.');
			error(['The necessary dependency: %s has an error in install, ' ...
				'or error performing an unzip operation. The subfolders ' ...
				'requested by the code were not found after the unzip ' ...
				'operation. This suggests a bad zip file, or a permissions ' ...
				'error on the local computer, or that folders are ' ...
				'specified that are not present on the remote code ' ...
				'repository.\n'],dependency_name);
		else
			% Clean up the zip file
			delete(zip_file_name);
		end

	end


	% For path creation, if the "DebugTools" package is being installed, the
	% code installs the package, then shifts temporarily into the package to
	% complete the path definitions for MATLAB. If the DebugTools is not
	% already installed, an error is thrown as these tools are needed for the
	% path creation.
	%
	% In other words: DebugTools is a special case because folders not
	% added yet, and we use DebugTools for adding the other directories
	if 1==1
		fcn_INTERNAL_addSubdirectoriesToPath(dependency_folder_name,dependency_subfolders);
	else
		% BELOW IS OLD METHOD THAT USED TO USE DebugTools
		if strcmp(dependency_name(1:10),'DebugTools')
			debugTools_function_folder = fullfile(root_directory_name, 'Utilities', dependency_name,'Functions');

			% Move into the folder, run the function, and move back
			cd(debugTools_function_folder);
			fcn_INTERNAL_addSubdirectoriesToPath(dependency_folder_name,dependency_subfolders);
			cd(root_directory_name);
		else
			try
				fcn_INTERNAL_addSubdirectoriesToPath(dependency_folder_name,dependency_subfolders);
			catch
				warning('backtrace','on');
				warning('Error encountered where DebugTools requested but not yet installed.');
				error(['Package installer requires DebugTools package to be ' ...
					'installed first. Please install that before ' ...
					'installing this package']);
			end
		end
	end


	% Finally, the code sets a global flag to indicate that the folders are
	% initialized.  Check this using a command "exist", which takes a
	% character string (the name inside the '' marks, and a type string -
	% in this case 'var') and checks if a variable ('var') exists in matlab
	% that has the same name as the string. The ~ in front of exist says to
	% do the opposite. So the following command basically means: if the
	% variable named 'flag_CodeX_Folders_Initialized' does NOT exist in the
	% workspace, run the code in the if statement. If we look at the bottom
	% of the if statement, we fill in that variable. That way, the next
	% time the code is run - assuming the if statement ran to the end -
	% this section of code will NOT be run twice.

	eval(sprintf('%s = 1;',flag_varname));
end

%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if flag_do_plots

	% Nothing to do!



end

if flag_do_debug
	fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends function fcn_INTERNAL_installDependencies


%% fcn_INTERNAL_confirmDebugToolsIsFirstOnInstallList
function [confirmedList, confirmedDependencyFolders] = ...
	fcn_INTERNAL_confirmDebugToolsIsFirstOnInstallList(dependencyURLs, dependencySubfolders)
% Make a list of all repos that are requested to be installed. Make sure
% DebugTools is the first one.

flagsRepoStringsIncludeDebug = contains(dependencyURLs,'DebugTools');
NreposNotDebug = sum(~flagsRepoStringsIncludeDebug);
% Debug repo is requested, but is not first on list. Rearrange list
confirmedList = cell(NreposNotDebug+1,1);
confirmedDependencyFolders = cell(NreposNotDebug+1,1);
confirmedList{1} = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools';
confirmedDependencyFolders{1,:} = {'Functions', 'Data'};
NreposThusFar = 1;
for ith_URL = 1:length(dependencyURLs)
	if flagsRepoStringsIncludeDebug(ith_URL)==0
		NreposThusFar = NreposThusFar+1;
		confirmedList{NreposThusFar,1} = dependencyURLs{ith_URL};
		confirmedDependencyFolders{NreposThusFar,1} = dependencySubfolders{ith_URL};
	end
end
end % Ends fcn_INTERNAL_confirmDebugToolsIsFirstOnInstallList

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
		warning('backtrace','on');
		warning('Error encountered where Utilities folder could not be deleted.');
		error('Unable remove directory: %s \nReason message: %s \nand message_ID: %s\n',utilities_dir, message,message_ID);
	end
end

end % Ends fcn_INTERNAL_clearUtilitiesFromPathAndFolders

%% fcn_INTERNAL_initializeUtilities
function  fcn_INTERNAL_initializeUtilities(library_name,library_folders,library_url,this_project_folders)
% Reset all flags for installs to empty
clear global FLAG*

fprintf(1,'Installing utilities necessary for code ...\n');

% Dependencies and Setup of the Code
% This code depends on several other libraries of codes that contain
% commonly used functions. We check to see if these libraries are installed
% into our "Utilities" folder, and if not, we install them and then set a
% flag to not install them again.

% Set up libraries
for ith_library = 1:length(library_name)
	dependency_name = library_name{ith_library};
	dependency_subfolders = library_folders{ith_library};
	dependency_url = library_url{ith_library};

	fprintf(1,'\tAdding library: %s ...',dependency_name);
	fcn_INTERNAL_installDependencies(dependency_name, dependency_subfolders, dependency_url);
	clear dependency_name dependency_subfolders dependency_url
	fprintf(1,'Done.\n');
end

% Set dependencies for this project specifically
fcn_INTERNAL_addSubdirectoriesToPath(pwd,this_project_folders);

disp('Done setting up libraries, adding each to MATLAB path, and adding current repo folders to path.');
end % Ends fcn_INTERNAL_initializeUtilities

%% fcn_INTERNAL_extractOwnerAndRepoFromURL
function [owner, repoName] = fcn_INTERNAL_extractOwnerAndRepoFromURL(thisURL)
% Pull out owner and repoName from URL name
remainderAfterGitHub = extractAfter(thisURL,'github.com/');
owner = extractBefore(remainderAfterGitHub,'/');
remainderAfterOwner = extractAfter(remainderAfterGitHub,'/');
if contains(remainderAfterOwner,'/')
	repoName = extractBefore(remainderAfterOwner,'/');
else
	repoName = remainderAfterOwner;
end
end % Ends fcn_INTERNAL_extractOwnerAndRepoFromURL

%% function fcn_INTERNAL_checkForPriorDebugInstall
function flag_previousInstallFound = fcn_INTERNAL_checkForPriorDebugInstall

% Initialize default outputs
flag_previousInstallFound = false;


% Navigate to the Utilities directory
utilitiesFolderSearch = fullfile(pwd,'Utilities');
if exist(utilitiesFolderSearch,'dir')
	dirCommand = fullfile(utilitiesFolderSearch,'DebugTools*.');
	debugsInstalled = dir(dirCommand);

	% Were any DebugTools installs found?
	if ~isempty(debugsInstalled)
		flag_previousInstallFound = true; % Mark flag that it was found
	end
end


end % Ends fcn_INTERNAL_checkForPriorDebugInstall


%% fcn_INTERNAL_isThisComputerOnline
function [isOnline] = fcn_INTERNAL_isThisComputerOnline(varargin)

% fcn_INTERNAL_isThisComputerOnline
% returns true if this computer is online, false if not. It does 3 layers of tests:
%  * Checks using java "isreachable" command to the URL.
%  * If this does not work, checks using the "webread" command with a
%    secure "https:\\" prefix
%  * If this does not work, checks using the "webread" command with a
%    unsecure "http:\\" prefix
%  * If this does not work, checks using a system-level "ping" command to
%    '8.8.8.8', which is the Google Public DNS (Domain Name Server) 
% If all these fail, it marks the computer as being offline. If any pass,
% it markes the computer as being online.
%
% FORMAT:
%
%     [isOnline] = fcn_INTERNAL_isThisComputerOnline((url), (timeout), (figNum))
%
% INPUTS:
%
%      (none)
%
%      (OPTIONAL INPUTS)
%
%      url: if given as a string, the URL to use for testing. Default is
%      'https://github.com'.
%
%      timeout: the timeout in milliseconds to use. Default is 1000 ms.
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      isOnline: a logical value that is true if the computer is online,
%      false if not 
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_INTERNAL_isThisComputerOnline
%     for a full test suite.
%
% This function was written on 2026_10_07 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2026_10_07 by Sean Brennan, sbrennan@psu.edu
% - In fcn_INTERNAL_isThisComputerOnline
%   * Wrote the code originally
%   * Used fcn_DebugTools_is+OnlineFromThisComputerAndUser as starter
% 
% 2026_11_16 by Sean Brennan, sbrennan@psu.edu
% - In fcn_INTERNAL_isThisComputerOnline
%   * Changed default URL to Google's DNS to avoid issues with MacOS
% 
% 2026_11_17 by Sean Brennan, sbrennan@psu.edu
% - In fcn_INTERNAL_isThisComputerOnline
%   * Added a multi-tier test to work across system OS installs including
%   % - Webread with secure URL
%   % - Webread with unsecure URL
%   % - Ping to googles DNS

% TO-DO:
% 2026_10_07 by Sean Brennan, sbrennan@psu.edu
% - Add to-do items here

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
    MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG); 
        flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978; %#ok<NASGU>
else
    debug_figNum = []; %#ok<NASGU>
end

%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(0,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% Does user want to specify url?
url = 'google.com';
% url = 'github.com';
if 1 <= nargin
    input = varargin{1};
    if ~isempty(input)
		url = input;
    end
end

% Does user want to specify timeout?
timeout = 1000;
if 2 <= nargin
    input = varargin{2};
    if ~isempty(input)
		timeout = input;
    end
end


% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp; %#ok<NASGU>
        flag_do_plots = 1;
    end
end


%% Main code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize variables
isOnline = false;
isOnline_JavaIsReachable = -1; %#ok<NASGU>
isOnline_webreadSecure = -1;
isOnline_webreadUnsecure = -1;
isOnline_ping = -1;


try
	addr = java.net.InetAddress.getByName(url);
	isOnline_JavaIsReachable = addr.isReachable(timeout); % timeout ms
catch
	isOnline_JavaIsReachable = false;
end

isOnline = isOnline || isOnline_JavaIsReachable;

% Check again, using webread secure
if ~isOnline
	try

		options = weboptions('Timeout', timeout);

		%  webread('https://github.com', options);
		webread(cat(2,'https://',url), options);

		isOnline_webreadSecure = true;

	catch

		isOnline_webreadSecure = false;

	end
	
	isOnline = isOnline || isOnline_webreadSecure;

end


% Check again, using webread unsecure
if ~isOnline
	try

		options = weboptions('Timeout', timeout);

		%  webread('https://github.com', options);
		webread(cat(2,'http://',url), options);

		isOnline_webreadUnsecure = true;

	catch

		isOnline_webreadUnsecure = false;

	end

	isOnline = isOnline || isOnline_webreadUnsecure;

end


% Check again, using system-level ping - this could work if the browser is
% not available
if ~isOnline
	try
		systemCommand = sprintf('ping -n 1 -w %d %s', timeout, '8.8.8.8');
		[pingStatus, pingOutput] = system(systemCommand);
		if pingStatus==1
			isOnline_ping = false;
		else
			isOnline_ping = ~contains(pingOutput,'Request timed out');
		end
	catch
		isOnline_ping = false;
	end

	isOnline = isOnline || isOnline_ping;

end


%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if flag_do_plots

    % Print results
	fprintf(1,'Test results for online verification: \n');
	fprintf(1,'\t isReachable method (Java) - online?: \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_JavaIsReachable));
	fprintf(1,'\t webread secure method - online?:     \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_webreadSecure));
	fprintf(1,'\t webread unsecure method - online?:   \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_webreadUnsecure));
	fprintf(1,'\t ping method - online?:               \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_ping));
	fprintf(1,'Overall, is computer online?: \t\t\t%s\n',    fcn_INTERNAL_printOnlineStatus(isOnline));

end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends isThisComputerOnline function




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

%% fcn_INTERNAL_printOnlineStatus
function statusString = fcn_INTERNAL_printOnlineStatus(status)
if -1==status
	statusString = 'Untested';
elseif 0==status
	statusString = 'Offline';
elseif 1==status
	statusString = ' Online';
else
	error('Unknown status encountered: %.0d',status);
end
end % Ends fcn_INTERNAL_printOnlineStatus (used in isThisComputerOnline)




%% fcn_INTERNAL_findLatestGitHubRelease
function latestReleaseStruct = fcn_INTERNAL_findLatestGitHubRelease(owner, repo, varargin) 
% FCN_DEBUGTOOLS_FINDLATESTGITHUBRELEASE Finds and displays the latest release of a GitHub repository.
%
%   fcn_INTERNAL_findLatestGitHubRelease(owner, repo) takes the GitHub repository owner
%   (username or organization) and the repository name as input and
%   displays information about the latest release.
% 
% FORMAT:
% 
%    latestReleaseStruct = fcn_INTERNAL_findLatestGitHubRelease(owner, repo, varargin) 
% 
% INPUTS:
% 
%     owner: a string representing the GitHub repo owner ID. 
% 
%     repo: a string representing the repo name
% 
%     (optional inputs)
%
%     figNum: any number that acts somewhat like a figure number output. 
%     If given, this forces the variable types to be displayed as output 
%     and as well makes the input check process verbose.
% 
% OUTPUTS:
% 
%     (optional outputs)
%
%     latestReleaseStruct: a structure containing the details on the latest
%     release of the repo, including: 
%
%                  url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/260467643'
%           assets_url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/260467643/assets'
%           upload_url: 'https://uploads.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/260467643/assets{?name,label}'
%             html_url: 'https://github.com/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/tag/PlotRoad_v2025_11_06'
%                   id: 260467643
%               author: [1×1 struct]
%              node_id: 'RE_kwDOMjekAc4Phmu7'
%             tag_name: 'PlotRoad_v2025_11_06'
%     target_commitish: 'main'
%                 name: 'PlotRoad_v2025_11_06'
%                draft: 0
%            immutable: 0
%           prerelease: 0
%           created_at: '2025-11-07T02:44:51Z'
%           updated_at: '2025-11-07T02:47:10Z'
%         published_at: '2025-11-07T02:47:10Z'
%               assets: []
%          tarball_url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/tarball/PlotRoad_v2025_11_06'
%          zipball_url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/zipball/PlotRoad_v2025_11_06'
%                 body: (the changelog)
% 
% 
% DEPENDENCIES:
% 
%    (none)
% 
% EXAMPLES:
% 
%     owner = 'ivsg-psu';
%     repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';
%     latestRelease = fcn_INTERNAL_findLatestGitHubRelease(owner, repo)
% 
% This function was written on 2021_12_12 by S. Brennan by modifying the
% similar function from the MapGen class.
%
% Questions or comments? contact sbrennan@psu.edu

% REVISION HISTORY:
%
% 2025_11_07 by Sean Brennan, sbrennan@psu.edu
% - first write of function
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum
%
% 2025_11_22 by Sean Brennan, sbrennan@psu.edu
% - In fcn_INTERNAL_findLatestGitHubRelease
%   % * Made error handling more verbose
%   % * Added warn+ings with 'backtrace' option on

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
    MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG); 
        flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978;
else
    debug_figNum = [];
end
%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(2,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp;
        flag_do_plots = 1;
    end
end

% Setup figures if there is debugging
if flag_do_debug
    fig_debug = 159; 
else
    fig_debug = []; %#ok<*NASGU>
end

%% Start of main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%See: http://patorjk.com/software/taag/#p=display&f=Big&t=Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§


% Construct the API URL for the latest release
apiUrl = sprintf('https://api.github.com/repos/%s/%s/releases/latest', owner, repo);

% Make the web request
try
    latestReleaseStruct = webread(apiUrl);
catch ME
    warning('backtrace','on');
    warning('Unable to find API url link - throwing error')
    error('Error fetching release information for: \n\tOwner: %s\n\tRepo: %s\n\t Error message: %s\n', owner, repo, ME.message);
    return;
end


%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if flag_do_plots
    % Extract and display release information
    disp(['Repository: ', owner, '/', repo]);
    if isfield(latestReleaseStruct, 'tag_name')
        disp(['Latest release version: ', latestReleaseStruct.tag_name]);
    else
        disp('Could not find tag_name in the release information.');
    end

    if isfield(latestReleaseStruct, 'name')
        disp(['Release Name: ', latestReleaseStruct.name]);
    end

    if isfield(latestReleaseStruct, 'published_at')
        disp(['Published At: ', latestReleaseStruct.published_at]);
    end

    if isfield(latestReleaseStruct, 'body')
        disp('Release Notes:');
        disp(latestReleaseStruct.body);
    end
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end


end % Ends the function fcn_INTERNAL_findLatestGitHubRelease


%% fcn_INTERNAL_addSubdirectoriesToPath
function fcn_INTERNAL_addSubdirectoriesToPath(root_path, subdirectories, varargin)
% fcn_INTERNAL_addSubdirectoriesToPath
% Given a path, and a cell array of subdirectories, adds the subdirectories
% to the path, if they exist under the given path. It throws an error if
% the subdirectories do not exist
%
% FORMAT:
%
%      fcn_INTERNAL_addSubdirectoriesToPath(root_path,subdirectories, (figNum))
%
% INPUTS:
%
%      root_path: a string of the path location
% 
%      subdirectories: a cell array of strings containing subdirectories,
%      for example {'Functions','Data','Utilities'}
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      (none)
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
% See the script: script_test_fcn_INTERNAL_addSubdirectoriesToPath
% for a full test suite.
%
% This function was written on 2022_03_27 by S. Brennan 
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2022_03_27 by Sean Brennan, sbrennan@psu.edu
% - first write of the code
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%   % * input_variable to inputVariable
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum


% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - (none)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
    MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG); 
        flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978; 
else
    debug_figNum = []; 
end

%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(2,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end


% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp; 
        flag_do_plots = 1;
    end
end




%% Start of main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% add necessary directories
if isempty(subdirectories)
    if(exist(root_path,'dir'))
        addpath(root_path);
    else % Throw an error?
        error('There was an attempt to add directory: \n%s \nto the path but the subdirectory does not exist. Suggest checking the README file to ensure correct folders are included.',...
            root_path);
    end
else
    for ith_subdirectory = 1:length(subdirectories)
        subdirectory_name = subdirectories{ith_subdirectory};
        if(exist([root_path, filesep,  subdirectory_name],'dir'))
            addpath(genpath([root_path, filesep, subdirectory_name]))
        else % Throw an error?
            error('There was an attempt to add subdirectory: \n%s \nto the path: \n%s\nbut the subdirectory does not exist. Suggest checking the README file to ensure correct folders are included.',...
                subdirectory_name,root_path);
        end
    end
end


%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1 == flag_do_plots
    %     figure(figNum);
    %     clf;
    %     hold on;
    %     grid on;
    %
    %        
    
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file); 
end

end % Ends the function fcn_INTERNAL_addSubdirectoriesToPath

