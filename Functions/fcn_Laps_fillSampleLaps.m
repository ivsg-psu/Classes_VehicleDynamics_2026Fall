function laps_array = fcn_Laps_fillSampleLaps(varargin)
% fcn_Laps_fillSampleLaps
% Produces dummy data to test lap functions. Note: can go into the function
% and change flag to allow user-selected paths.
%
% FORMAT:
%
%       laps_array = fcn_Laps_fillSampleLaps((figNum))
%
% INPUTS:
%
%     (optional inputs)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      laps_array: an cell array of paths that exhibit different lap
%      characteristics
%
% DEPENDENCIES:
%
%      fcn_Path_fillRandomPathsAboutPath
%      fcn_Path_fillPathViaUserInputs
%
% EXAMPLES:
%
%       See the script:
%       script_test_fcn_Laps_fillSampleLaps for a full
%       test suite.
%
% This function was written on 2022_04_02 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2022_04_02 by Sean Brennan, sbrennan@psu.edu
% - wrote the code, started with circle and figure 8 laps
% 
% 2022_04_03 by Sean Brennan, sbrennan@psu.edu
% - added teardrop laps, manual lap
% 
% 2022_07_23 by Sean Brennan, sbrennan@psu.edu
% - typo fix in script name in comments
% 
% 2025_04_27 by Sean Brennan, sbrennan@psu.edu
% - added figure number optional input
% - added plotting
% 
% 2025_04_27 by Sean Brennan, sbrennan@psu.edu
% - added global debugging options
% 
% 2025_07_02 by Sean Brennan, sbrennan@psu.edu
% - updated Path library calls to use paths, not traversals
% - updated docstrings
% 
% 2025_07_03 by Sean Brennan, sbrennan@psu.edu
% - cleanup of Debugging area codes
% - turn on fast mode for Path calls

% TO-DO:
%
% 2025_11_21 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)



%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 1; % The largest Number of argument inputs to the function
flag_max_speed = 0; % The default. This runs code with all error checking
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_LAPS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_LAPS_FLAG_CHECK_INPUTS");
    MATLABFLAG_LAPS_FLAG_DO_DEBUG = getenv("MATLABFLAG_LAPS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_LAPS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_LAPS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_LAPS_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_LAPS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug % If debugging is on, print on entry/exit to the function
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978; %#ok<NASGU>
else
    debug_figNum = []; %#ok<NASGU>
end

%% check input arguments?
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
if 0==flag_max_speed
    if flag_check_inputs
        % Are there the right number of inputs?
        narginchk(0,MAX_NARGIN);
    end
end

% Does user want to show the plots?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
        figNum = temp;
        flag_do_plots = 1;
    end
end

%% Main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Create a lap data array that is a simple circle
Nlaps = 3;
angles_in_radians = pi/180*(-45:5:(Nlaps*360 + 45))';

radius = 50; 
laps_array{1,1} = radius * ( [cos(angles_in_radians) sin(angles_in_radians)] - [1 0]);




%% Create a lap data array that is a double circle, e.g. figure 8
% Nlaps = 3;
radius = 50; 

entry_angles_in_radians = pi/180*(-45:5:-5)';
entry_XY = [cos(entry_angles_in_radians) sin(entry_angles_in_radians)] - [1 0];

exit_angles_in_radians = pi/180*(0:5:45)';
exit_XY = [cos(exit_angles_in_radians) sin(exit_angles_in_radians)] - [1 0];

first_circle_angles_in_radians = pi/180*(0:5:355)';
first_circle_XY = [cos(first_circle_angles_in_radians) sin(first_circle_angles_in_radians)] - [1 0];
second_circle_angles_in_radians = pi/180*(180:-5:-175)';
second_circle_XY = [2+cos(second_circle_angles_in_radians) sin(second_circle_angles_in_radians)] - [1 0];
one_lap_XY = [first_circle_XY; second_circle_XY] ;


laps_array{2,1} = radius * ...
    ([entry_XY; one_lap_XY; one_lap_XY; one_lap_XY; exit_XY]);



%% Create a lap data array that is a an out-and-back, using a teardrop
% See https://mathworld.wolfram.com/TeardropCurve.html

start_angle = 0;
end_angle = 360;
angles_in_radians = pi/180*(start_angle:5:end_angle)';

order = 5; % The higher order, the more squished the teardrop shape
left_lobe = [cos(angles_in_radians) sin(angles_in_radians).*(sin(angles_in_radians/2)).^order] - [1 0];
step_distance = 0.05;
entry_straight_distances = (0.4:-step_distance:step_distance)';
exit_straight_distances  = (step_distance:step_distance:0.5)';
entry_straight = [entry_straight_distances zeros(size(entry_straight_distances))];
exit_straight  = [exit_straight_distances zeros(size(exit_straight_distances))];
laps_array{3,1} = radius * [entry_straight; left_lobe; exit_straight];



%% Create a lap that is a teardrop figure 8
% See https://mathworld.wolfram.com/TeardropCurve.html

Nlaps = 3;

start_angle = 0;
end_angle = 355;
angles_in_radians = pi/180*(start_angle:5:end_angle)';

order = 5; % The higher order, the more squished the teardrop shape
left_lobe =  [cos(angles_in_radians) sin(angles_in_radians).*(sin(angles_in_radians/2)).^order] - [1 0];
right_lobe = [-1*left_lobe(:,1) left_lobe(:,2)];
one_lap = [left_lobe; right_lobe];
many_laps = repmat(one_lap,Nlaps,1);
laps_array{4,1} = radius * [entry_straight; many_laps; -exit_straight];



%% Create lap data that are randomly varying versions of ideal shapes

emtpy_value = [];

rng(123);


% Set flags for random generation
flag_generate_random_stations = 0; % Keep the stations from before
num_trajectories = 1;
spatial_smoothness = 7;  % Units are meters
std_deviation = 3;  % Units are meters

Nideal = length(laps_array);
for ith_ideal = 1:Nideal
    % Convert to traversal using Path function
    reference_path = laps_array{ith_ideal,1};
    
    % Call a Paths function to fill in the result
    random_paths = ...
        fcn_Path_fillRandomPathsAboutPath(...
        reference_path,...
        std_deviation,... % (std_deviation),...
        num_trajectories,... % (num_trajectories),...
        emtpy_value,... % (num_points),...
        flag_generate_random_stations,... % (flag_generate_random_stations),...
        spatial_smoothness, -1);   % (spatial_smoothness),...
    laps_array{Nideal+ith_ideal,1} = random_paths{1};
end


%% Create sample laps by hand? If so, use fcn_Path_fillPathViaUserInputs to fill

% Intentionally comment this out so that doesn't autorun. This forces the
% user to read the instructions!
if 1==0  
    
    figNum = 1;
    clf;
    grid on;
    axis equal
    axis(1.5*[-radius radius -radius radius]);
    % h = figure(figNum);
    hold on;
    
    % Figure out how many paths we are created
    num_iterations = input('How many paths do you want to draw? [Hit enter for default of 1]:','s');
    if isempty(num_iterations)
        num_iterations = 1;
    else
        num_iterations = str2double(num_iterations);
    end
    fprintf(1,'\n Filling in %.0d paths.\n',num_iterations);
    
    % Show the instructions:
    fprintf(1,'Instructions: \n');
    fprintf(1,'Left click on the plot to create points. \n');
    fprintf(1,'Right click on the plot to remove points \n');
    fprintf(1,'Double click on the plot to end the path creation. \n');
    fprintf(1,'When the last path is completed, another plot will be created to show results. \n');
    
    
    % Initialize the paths_array
    clear paths_array
    manual_laps_array{num_iterations} = [0 0];
    
    % Loop through creation of each path
    for i_path = 1:num_iterations
        
        % Set the title header
        UserData.title_header = sprintf('Path %.0d of %.0d',i_path,num_iterations);
        
        % Save the results
        set(gcf,'UserData',UserData);
        
        pathXY = fcn_Path_fillPathViaUserInputs(figNum);
        manual_laps_array{i_path} = pathXY;

        % show results to screen
        % disp(manual_laps_array{i_path});

    end
    
     
end




laps_array{end+1} = [
    0.2961  -13.9145
    0.4934   -9.9671
   -0.0987   -4.0461
   -0.2961    0.4934
   -0.4934    4.6382
   -0.8882    9.9671
   -3.4539   12.9276
   -7.7961   16.2829
  -13.7171   17.8618
  -19.6382   18.8487
  -25.7566   19.2434
  -30.0987   19.8355
  -33.4539   19.8355
  -38.3882   19.8355
  -45.2961   20.4276
  -50.2303   21.6118
  -52.4013   22.5987
  -55.5592   25.3618
  -57.7303   29.7039
  -59.1118   34.8355
  -58.1250   37.9934
  -55.9539   41.9408
  -51.8092   44.3092
  -46.0855   46.2829
  -39.5724   46.6776
  -33.4539   43.9145
  -31.8750   42.1382
  -30.2961   38.7829
  -28.9145   33.4539
  -29.5066   29.3092
  -30.6908   25.1645
  -33.0592   21.0197
  -36.2171   18.2566
  -39.3750   17.6645
  -43.5197   16.4803
  -45.0987   15.8882
  -47.0724   15.0987
  -49.4408   15.0987
  -56.5461   18.0592
  -61.2829   24.1776
  -63.4539   29.3092
  -64.2434   33.4539
  -63.4539   37.9934
  -61.0855   43.7171
  -55.7566   48.8487
  -48.6513   51.6118
  -43.3224   52.2039
  -34.0461   52.7961
  -26.3487   52.7961
  -19.6382   52.0066
   -7.2039   51.0197
    2.0724   50.6250
    7.7961   51.0197
   12.3355   50.0329
   22.9934   46.6776
   30.2961   41.3487
   40.3618   39.3750
   49.2434   39.1776
   53.5855   41.3487
   57.3355   50.0329
   56.3487   54.7697
   50.2303   60.4934
   41.3487   63.6513
   32.8618   62.6645
   29.1118   59.9013
   26.5461   54.3750
   27.9276   45.6908
   30.0987   39.3750
   33.2566   33.6513
   36.0197   24.3750
   37.0066   20.4276
   38.1908   12.7303
   38.1908    7.0066
   37.7961    1.0855
   37.2039   -6.4145
   37.2039  -15.0987
   37.4013  -17.2697
   40.3618  -20.6250
   44.9013  -22.4013
   55.7566  -25.5592
   59.9013  -28.5197
   64.2434  -41.7434
   61.2829  -46.8750
   53.9803  -55.1645
   37.5987  -58.9145
   22.0066  -62.0724
    0.4934  -65.0329
  -23.3882  -63.0592
  -32.0724  -58.7171
  -37.0066  -52.4013
  -39.5724  -44.1118
  -38.5855  -37.0066
  -34.2434  -31.4803
  -27.7303  -27.9276
  -22.7961  -26.1513
  -17.0724  -24.7697
  -11.1513  -22.9934
   -5.8224  -21.2171
   -1.0855  -19.4408
    1.0855  -17.4671
    3.0592  -12.7303
    1.8750   -7.9934
    0.8882   -1.4803
   -0.4934    4.4408
   -1.4803    7.9934
   -3.8487   11.7434
  -11.7434   14.7039
  -14.9013   16.4803
  -21.8092   17.8618
  -29.9013   19.0461
  -35.2303   19.8355
  -43.7171   21.4145
  -48.2566   22.5987
  -53.3882   24.3750
  -54.3750   27.3355
  -56.3487   31.8750
  -56.9408   36.6118
  -56.1513   39.1776
  -53.5855   40.9539
  -48.8487   42.5329
  -43.9145   44.1118
  -38.3882   44.3092
  -34.4408   43.1250
  -31.0855   40.7566
  -29.5066   37.5987
  -29.1118   31.6776
  -31.0855   26.7434
  -33.0592   22.0066
  -37.5987   18.0592
  -45.4934   13.7171
  -52.7961   13.1250
  -58.1250   16.0855
  -62.2697   22.0066
  -65.0329   29.1118
  -65.0329   36.4145
  -62.2697   43.7171
  -57.1382   49.4408
  -50.4276   52.9934
  -42.5329   53.3882
  -35.4276   54.3750
  -27.9276   55.1645
  -23.3882   54.9671
  -17.8618   53.7829
  -11.7434   52.9934
   -5.2303   52.9934
   -0.4934   52.7961
    1.6776   52.7961
    7.2039   52.5987
   11.1513   51.8092
   16.0855   50.6250
   20.0329   47.6645
   22.4013   45.4934
   28.9145   44.9013
   32.0724   43.5197
   35.4276   41.3487
   42.3355   40.1645
   47.0724   39.5724
   53.9803   40.7566
   56.7434   42.7303
   59.1118   47.8618
   60.4934   53.3882
   58.1250   57.7303
   51.4145   62.0724
   44.1118   64.4408
   36.2171   66.0197
   32.0724   64.4408
   29.3092   61.4803
   27.9276   55.5592
   29.5066   47.6645
   32.0724   41.1513
   35.8224   33.8487
   38.9803   28.3224
   40.1645   24.5724
   42.3355   18.6513
   41.9408   12.3355
   40.7566    7.4013
   40.3618    3.6513
   39.1776   -7.4013
   39.1776   -9.3750
   39.5724  -12.9276
   40.9539  -16.2829
   44.9013  -20.0329
   51.4145  -21.2171
   56.5461  -23.1908
   59.7039  -27.1382
   61.2829  -30.6908
   62.6645  -38.9803
   62.0724  -42.1382
   56.3487  -49.6382
   49.8355  -54.1776
   41.5461  -56.9408
   35.2303  -57.1382
   29.7039  -58.9145
   19.6382  -60.6908
   10.3618  -64.0461
   -4.2434  -65.2303
  -12.9276  -65.0329
  -20.8224  -64.0461
  -28.1250  -61.8750
  -34.6382  -58.9145
  -36.8092  -55.5592
  -38.3882  -51.0197
  -38.9803  -46.2829
  -36.6118  -39.3750
  -33.2566  -35.6250
  -31.0855  -33.4539
  -23.9803  -29.3092
  -16.2829  -25.1645
  -11.1513  -22.7961
   -7.0066  -21.6118
   -0.8882  -20.6250
    0.4934  -18.0592
    1.4803  -14.3092
    1.4803  -12.5329
    1.4803   -9.1776
    1.6776   -3.8487
    1.6776    1.4803
    1.6776    5.2303
    1.2829   10.1645
   -2.0724   17.2697
  -10.3618   20.8224
  -19.6382   22.4013
  -26.7434   22.7961
  -36.2171   23.9803
  -41.5461   23.7829
  -46.6776   24.5724
  -49.2434   25.9539
  -52.9934   27.9276
  -54.3750   31.4803
  -54.7697   36.0197
  -51.2171   39.1776
  -47.0724   41.5461
  -41.7434   43.9145
  -34.6382   44.1118
  -29.7039   41.7434
  -27.5329   37.5987
  -27.7303   30.2961
  -30.8882   23.5855
  -35.6250   17.8618
  -42.5329   13.1250
  -53.7829   12.7303
  -61.4803   16.4803
  -65.8224   25.7566
  -66.4145   31.6776
  -62.8618   38.1908
  -55.9539   43.5197
  -47.2697   51.6118
  -39.9671   54.3750
  -30.4934   56.7434
  -16.4803   54.7697
   -5.8224   53.3882
    3.8487   51.0197
   10.3618   49.2434
   22.5987   45.2961
   30.2961   42.9276
   40.9539   40.7566
   48.2566   39.7697
   55.9539   40.1645
   61.4803   45.8882
   62.4671   54.7697
   59.9013   60.0987
   43.7171   66.2171
   36.4145   70.1645
   29.9013   65.2303
   26.5461   59.1118
   26.3487   51.0197
   28.9145   43.5197
   33.2566   36.8092
   40.7566   25.1645
   43.7171   18.8487
   45.6908   11.7434
   44.5066    4.6382
   43.1250    1.4803
   42.9276   -3.6513
   45.2961  -11.9408
   46.0855  -12.9276
   50.6250  -15.6908
   60.2961  -23.7829
   63.4539  -25.9539
   64.4408  -31.6776
   65.2303  -39.1776
   64.0461  -48.2566
   60.2961  -50.2303
   52.0066  -56.5461
   47.8618  -58.7171
   37.0066  -62.0724
   31.8750  -62.2697
   24.9671  -64.8355
   13.1250  -64.8355
    0.8882  -66.0197
   -8.3882  -66.0197
  -15.0987  -65.6250
  -27.3355  -62.4671
  -30.2961  -59.1118
  -35.6250  -55.3618
  -37.5987  -51.2171
  -38.3882  -48.0592
  -37.9934  -41.7434
  -35.2303  -36.0197
  -31.6776  -32.8618
  -25.5592  -31.0855
  -20.6250  -29.5066
  -16.8750  -28.5197
  -12.9276  -26.7434
  -10.1645  -24.3750
   -3.8487  -22.0066
   -2.4671  -19.8355
   -0.6908  -15.8882
    0.2961  -11.9408
    0.6908   -7.5987
    0.8882   -4.0461
    0.6908    0.4934
    0.2961    4.8355
   -0.8882   11.9408
   -1.8750   15.6908
   -3.4539   19.4408
   -4.8355   21.4145
   -7.0066   23.5855
   -8.5855   27.3355
   -9.9671   29.5066];



%% Any debugging?
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
    % Prep a figure
    figure(figNum);
    clf;

    tiledlayout('flow');

    % Show results
    for ith_Lap = 1:length(laps_array)

        nexttile

        hold on;
        axis equal;
        grid on;
        grid minor;        
        
  
        plot(laps_array{ith_Lap}(:,1),laps_array{ith_Lap}(:,2),'-');
        text(laps_array{ith_Lap}(1,1),laps_array{ith_Lap}(1,2),'Start');
        title(sprintf('Demo lap %.0d',ith_Lap))

        xlabel('X [m]');
        ylabel('Y [m]');
        
    end
    sgtitle('All demonstration laps');
end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end
end
