% script_test_fcn_Laps_breakDataIntoLaps.m
% tests fcn_Laps_breakDataIntoLaps.m

% REVISION HISTORY:
%
% 2022_04_03 by Sean Brennan, sbrennan@psu.edu
% - first write of the code
% 
% 2022_04_03 by Sean Brennan, sbrennan@psu.edu
% - added external call to zone calculation function
% 
% 2022_07_11 by Sean Brennan, sbrennan@psu.edu
% - corrected calls to zone function to allow number of points,
% changed format to allow 3d circles
% 
% 2025_07_03 by Sean Brennan, sbrennan@psu.edu
% - cleanup of Debugging area codes
% - turn on fast mode for Path calls
% 
% 2025_07_03 by Sean Brennan, sbrennan@psu.edu
% - standardized headers on all test scripts

% TO-DO:
%
% 2025_11_21 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)

%% Set up the workspace
close all

%% Code demos start here
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
fprintf(1,'Figure: 1XXXXXX: DEMO cases\n');

%% DEMO case: Basic demo
figNum = 10001;
titleString = sprintf('DEMO case: Basic demo');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);

start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0,0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 3;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isequal(87,length(lap_cellArrayOfPaths{1}(:,1))));
assert(isequal(98,length(lap_cellArrayOfPaths{2}(:,1))));
assert(isequal(79,length(lap_cellArrayOfPaths{3}(:,1))));

% Check variable values
% Are the laps starting at expected points?

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

if 1==0
    % Plot the lap traversals (should have 3)
    figNum = 1101;
    fcn_Laps_plotLapsXY(lap_cellArrayOfPaths,figNum);
end


%% DEMO case: Using full argument list
% This returns the input and exit traversals
figNum = 10002;
titleString = sprintf('DEMO case: Using full argument list');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);

start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0,0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 3;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isequal(87,length(lap_cellArrayOfPaths{1}(:,1))));
assert(isequal(98,length(lap_cellArrayOfPaths{2}(:,1))));
assert(isequal(79,length(lap_cellArrayOfPaths{3}(:,1))));
assert(isequal(2,length(entry_traversal(:,1))));
assert(isequal(28,length(exit_traversal(:,1))));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

if 1==0
    % Plot the results
    figNum = 333;
    figure(figNum);
    subplot(1,3,1);
    fcn_Laps_plotLapsXY(lap_cellArrayOfPaths,figNum);
    axis_limits = axis;
    title('All laps');

    subplot(1,3,2);
    single_lap.traversal{1} = entry_traversal;
    fcn_Laps_plotLapsXY(single_lap,figNum);
    axis(axis_limits); % Inheret axis limits from main laps plot
    title('Entry segment');

    subplot(1,3,3);
    single_lap.traversal{1} = exit_traversal;
    fcn_Laps_plotLapsXY(single_lap,figNum);
    axis(axis_limits); % Inheret axis limits from main laps plot
    title('Exit segment');    
end

%% DEMO case: Show how a lap is missed if start zone is not big enough
figNum = 10003;
titleString = sprintf('DEMO case: Show how a lap is missed if start zone is not big enough');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);

start_definition = [6 3 0 0]; % Radius 10, 3 points must pass near [0,0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 2;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isequal(86,length(lap_cellArrayOfPaths{1}(:,1))));
assert(isequal(78,length(lap_cellArrayOfPaths{2}(:,1))));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

if 1==0
    % Plot the lap traversals (should have 2)
    figNum = 444;
    fcn_Laps_plotLapsXY(lap_cellArrayOfPaths,figNum);
end

%% DEMO case: Show the use of segment definition
figNum = 10004;
titleString = sprintf('DEMO case: Show the use of segment definition');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);


start_definition = [10 0; -10 0]; % start at [10 0], end at [-10 0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

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

if 1==0
    % Plot the lap traversals (should have 2)
    figNum = 5555;
    fcn_Laps_plotLapsXY(lap_cellArrayOfPaths,figNum);
end

%% Check assertions for basic path operations and function testing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              _   _                 
%      /\                     | | (_)                
%     /  \   ___ ___  ___ _ __| |_ _  ___  _ __  ___ 
%    / /\ \ / __/ __|/ _ \ '__| __| |/ _ \| '_ \/ __|
%   / ____ \\__ \__ \  __/ |  | |_| | (_) | | | \__ \
%  /_/    \_\___/___/\___|_|   \__|_|\___/|_| |_|___/
%                                                    
%                                                    
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Assertions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEST case: Returns nothing since there is no portion of the path in the
% criteria
figNum = 20001;
titleString = sprintf('DEMO case: call the function to show it operating on the 9th data set');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


input_path = [-1 1; 1 1];
start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points

[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Returns nothing since there is one point in criteria
figNum = 20002;
titleString = sprintf('TEST case: Returns nothing since there is one point in criteria');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

input_path = [-1 1; 0 0; 1 1];
start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points
[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Returns nothing since there is only two points in criteria
figNum = 20003;
titleString = sprintf('TEST case: Returns nothing since there is only two points in criteria');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;



input_path = [-1 1; 0 0; 0.1 0; 1 1];
start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points
[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Returns nothing since the minimum point is at the start
figNum = 20003;
titleString = sprintf('TEST case: Returns nothing since the minimum point is at the start');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% and so there is no strong minimum inside the zone
input_path = [-1 1; 0 0; 0.01 0; 0.02 0; 0.03 0; 1 1];
start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points
[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Returns nothing since the minimum point is at the end
figNum = 20004;
titleString = sprintf('TEST case: Returns nothing since the minimum point is at the end');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% and so there is no strong minimum inside the zone
input_path = [-1 1; -0.03 0; -0.02 0; -0.01 0; 0 0; 1 1];
start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points
[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Returns nothing since the path doesn't come back to start
figNum = 20005;
titleString = sprintf('TEST case: Returns nothing since the path doesn''t come back to start');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% There is no end after the start
figNum = 123;
input_path = [-1 1; -0.03 0; -0.02 0; 0 0; 0.1 0; 1 1];
start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points

[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition,...
    [],...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Returns nothing since the end is incomplete
figNum = 20006;
titleString = sprintf('TEST case: Returns nothing since the end is incomplete');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;

input_path = ...
    [full_steps zero_full_steps; zero_half_steps half_steps];

start_definition = [0.2 3 0 0]; % Located at [0,0] with radius 0.2, 3 points

[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition,...
    [],...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 0;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isempty(lap_cellArrayOfPaths));
assert(isequal(entry_traversal,input_path));
assert(isempty(exit_traversal));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Show that the start and end points can overlap by their boundaries
figNum = 20007;
titleString = sprintf('TEST case: Show that the start and end points can overlap by their boundaries');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;



% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
% half_steps = (-1:0.1:0)';
% zero_half_steps = 0*half_steps;


input_path = ...
    [full_steps zero_full_steps];
start_definition = [0.5 3 -0.5 0]; % Located at [-0.5,0] with radius 0.5, 3 points
end_definition = [0.5 3 0.5 0]; % Located at [0.5,0] with radius 0.5, 3 points

[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition,...
    end_definition,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 1;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

% Check variable values
% Are the laps starting at expected points?

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: Show that the start and end points can be at the absolute ends
figNum = 20008;
titleString = sprintf('TEST case: Show that the start and end points can be at the absolute ends');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;


input_path = ...
    [full_steps zero_full_steps];

start_definition = [0.5 3 -1 0]; % Located at [-1,0] with radius 0.5, 3 points
end_definition = [0.5 3 1 0]; % Located at [1,0] with radius 0.5, 3 points

[lap_cellArrayOfPaths, entry_traversal,exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    input_path,...
    start_definition,...
    end_definition,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 1;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

% Check variable values

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));



%% Fast Mode Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ______        _     __  __           _        _______        _
% |  ____|      | |   |  \/  |         | |      |__   __|      | |
% | |__ __ _ ___| |_  | \  / | ___   __| | ___     | | ___  ___| |_ ___
% |  __/ _` / __| __| | |\/| |/ _ \ / _` |/ _ \    | |/ _ \/ __| __/ __|
% | | | (_| \__ \ |_  | |  | | (_) | (_| |  __/    | |  __/\__ \ |_\__ \
% |_|  \__,_|___/\__| |_|  |_|\___/ \__,_|\___|    |_|\___||___/\__|___/
%
%
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Fast%20Mode%20Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 8

close all;
fprintf(1,'Figure: 8XXXXXX: FAST mode cases\n');

%% Basic example - NO FIGURE
figNum = 80001;
fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
figure(figNum); close(figNum);

dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);

start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0,0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    ([]));

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 3;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isequal(87,length(lap_cellArrayOfPaths{1}(:,1))));
assert(isequal(98,length(lap_cellArrayOfPaths{2}(:,1))));
assert(isequal(79,length(lap_cellArrayOfPaths{3}(:,1))));


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);

start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0,0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty

[lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
    tempXYdata,...
    start_definition,...
    end_definition,...
    excursion_definition,...
    (-1));

% Check variable types
assert(iscell(lap_cellArrayOfPaths));
assert(isnumeric(entry_traversal));
assert(isnumeric(exit_traversal));

% Check variable sizes
Nlaps = 3;
assert(isequal(Nlaps,length(lap_cellArrayOfPaths))); 

assert(isequal(87,length(lap_cellArrayOfPaths{1}(:,1))));
assert(isequal(98,length(lap_cellArrayOfPaths{2}(:,1))));
assert(isequal(79,length(lap_cellArrayOfPaths{3}(:,1))));


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

dataSetNumber = 9;

% Load some test data 
tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber);

start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0,0]
end_definition = [30 3 0 -60]; % Radius 30, 3 points must pass near [0,-60]
excursion_definition = []; % empty


Niterations = 50;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
    % Call the function
    [lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
        tempXYdata,...
        start_definition,...
        end_definition,...
        excursion_definition,...
        ([]));

end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
    % Call the function
    [lap_cellArrayOfPaths, entry_traversal, exit_traversal] = fcn_Laps_breakDataIntoLaps(...
        tempXYdata,...
        start_definition,...
        end_definition,...
        excursion_definition,...
        (-1));

end
fast_method = toc;

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Plot results as bar chart
figure(373737);
clf;
hold on;

X = categorical({'Normal mode','Fast mode'});
X = reordercats(X,{'Normal mode','Fast mode'}); % Forces bars to appear in this exact order, not alphabetized
Y = [slow_method fast_method ]*1000/Niterations;
bar(X,Y)
ylabel('Execution time (Milliseconds)')


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% BUG cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ____  _    _  _____
% |  _ \| |  | |/ ____|
% | |_) | |  | | |  __    ___ __ _ ___  ___  ___
% |  _ <| |  | | | |_ |  / __/ _` / __|/ _ \/ __|
% | |_) | |__| | |__| | | (_| (_| \__ \  __/\__ \
% |____/ \____/ \_____|  \___\__,_|___/\___||___/
%
% See: http://patorjk.com/software/taag/#p=display&v=0&f=Big&t=BUG%20cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All bug case figures start with the number 9

% close all;

%% BUG 
%% Fail conditions
if 1==0
    
    %% Fails because start_definition is not correct type
    start_definition = [1 2];
    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition); %#ok<*ASGLU>
    
    %% Fails because start_definition is not correct type
    % Radius input is negative
    start_definition = [-1 2 3 4];
    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition); 

    %% Fails because start_definition is not correct type
    % Radius input is negative
    start_definition = [0 2 3 4];
    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition); 
    
    %% Fails because start_definition is not correct type
    % Num_inputs input is not positive
    start_definition = [1 0 3 4];
    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition); 
    
    %% Warning because start_definition is 3D not 2D
    % Start_zone definition is a 3D point [radius num_points X Y Z]
    start_definition = [1 2 3 4 5];
    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition); 
    
    %% Warning because start_definition is 3D not 2D
    % Start_zone definition is a 3D point [X Y Z; X Y Z]
    start_definition = [1 2 3; 4 5 6];
    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition); 
    
    %% Warning because end_definition is 3D not 2D
    % End_zone definition is a 3D point [radius num_points X Y Z]
    start_definition = [1 2 3 4];
    end_definition = [1 2 3 4 5];

    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition,...
        end_definition); 
    
    %% Warning because excursion_definition is 3D not 2D
    % Excursion_zone definition is a 3D point [radius num_points X Y Z]
    start_definition = [1 2 3 4];
    end_definition = [1 2 3 4];
    excursion_definition = [1 2 3 4 5];

    [lap_cellArrayOfPaths, input_and_exit_traversals] = fcn_Laps_breakDataIntoLaps(...
        single_lap.traversal{1},...
        start_definition,...
        end_definition,...
        excursion_definition); 
end

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

%% fcn_INTERNAL_loadExampleData
function tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber)
% Call the function to fill in an array of "path" type
laps_array = fcn_Laps_fillSampleLaps(-1);

% Use the last data
tempXYdata = laps_array{dataSetNumber};

end % Ends fcn_INTERNAL_loadExampleData
