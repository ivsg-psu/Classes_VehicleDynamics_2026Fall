% script_HW2_FirstOrderEngineModelRK4.m
% uses fcn_VD_FirstOrderEngineModelRK4 to simulate an engine

% REVISION HISTORY:
%
% 2026_09_25 by Sean Brennan, sbrennan@psu.edu
% - In script_HW2_FirstOrderEngineModelRK4
%   % * Wrote the code originally, 
%   % * Using script_test_fcn_VD_FirstOrderEngineModelRK4 as starter

% TO-DO:
%
% 2026_09_25 by Sean Brennan, sbrennan@psu.edu
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

%% DEMO case: simulating a 2013 Prius
figNum = 10001;
titleString = sprintf('DEMO case: basic call');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Set the simulation time/state arguments
initialStates = 0; % [Omega] in [rad/sec]
deltaT = 0.01; % Units are [sec]
startTime = 0;
endTime = 4.5;
timeInterval = [startTime endTime];  % Units are [sec]

% Set up inputs
simulationTimes = (startTime:deltaT:endTime)';
torque_amplitude_Nm = 142 ; % Newton-meters, this is for a 2013 Prius

% % Set up a sinewave input
% Period = 3; % Units are seconds. A typical lane change is about 3 to 4 seconds based on experimental highway measurements
% inputsVsTime = [simulationTimes torque_amplitude_Nm*pi/180*sin((2*pi/Period)*simulationTimes)]; % [times steering angles]

% Set up a step input
stepTorqueInput = ones(length(simulationTimes),1);
stepTorqueInput(1,1) = 0;
inputsVsTime = [simulationTimes torque_amplitude_Nm*stepTorqueInput]; % [times torques]

% Set up parameters
clear parameters
% Use the 2nd and 3rd numbers in your Canvas number to fill in J and B. 
% if 2nd number is 1 then J is 1, if 2 then J is 2. If it is 0, use 10
% if 3rd number is 1 then B is 1, if  then B is 2. If it is 0, use 10
parameters.J = 10;  % J is the rotational inertia of the vehicle, in kg-m^2
parameters.B = 10; % B is the rotational viscous drag, in (N-m)/(rad/sec)

% Call the function
[stateTrajectory, t, inputHistory] = ...
fcn_VD_FirstOrderEngineModelRK4(initialStates, deltaT, ...
timeInterval, inputsVsTime, parameters, (figNum));

% Get the torque at the first instant at or after 1 second
timeToFind = 1.00; % Seconds
indexToUse = find(t>=timeToFind,1);
statesAtTimeToFind = stateTrajectory(indexToUse,:);
fprintf(1,'\nAt time: %.2f, the speed was: %.2f\n',timeToFind,statesAtTimeToFind(1,1));
% Dr B's result: 8.92 rad/sec. This is ~90 RPM so the engine isn't really
% running. Why is this so wrong? the viscous friciton is WAY too high
% compared to the real engine. For reference, an engine at 1000 RPM is
% about 100 rad/sec, and this value, times friction, is the steady-state
% engine loss. This should be about 10% or less of the peak torque. So we
% can see that the actual B value for the Prius is roughly 14.2 N-m / 100
% rad/sec, or about 0.14. The the number used here is 100 times too large.
% We just doing simulations, so that's OK. But we can see that it's easy to
% back-calculate core parameters in engine models even with limited
% manufacturer data.

% sgtitle(titleString, 'Interpreter','none');
sgtitle('SB','Interpreter','none');

% Check variable types
assert(isnumeric(stateTrajectory));
assert(isnumeric(t));
assert(isnumeric(inputHistory));

% Check variable sizes
assert(size(stateTrajectory,1)>=1); 
assert(size(stateTrajectory,2)==1); 
assert(size(t,1)==size(stateTrajectory,1)); 
assert(size(t,2)==1); 
assert(size(inputHistory,1)==size(stateTrajectory,1)); 
assert(size(inputHistory,2)==1); 

% Check variable values
% (too complex to check)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

% Label the figure
subplot(2,1,1);
xlabel('Time (sec)');
ylabel('Torque Input (N-m)')

subplot(2,1,2);
xlabel('Time (sec)');
ylabel('Speed (rad/sec)')
% 
% 
% %% Test cases start here. These are very simple, usually trivial
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% %  _______ ______  _____ _______ _____
% % |__   __|  ____|/ ____|__   __/ ____|
% %    | |  | |__  | (___    | | | (___
% %    | |  |  __|  \___ \   | |  \___ \
% %    | |  | |____ ____) |  | |  ____) |
% %    |_|  |______|_____/   |_| |_____/
% %
% %
% %
% % See: https://patorjk.com/software/taag/#p=display&f=Big&t=TESTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Figures start with 2
% 
% close all;
% fprintf(1,'Figure: 2XXXXXX: TEST mode cases\n');
% 
% 
% %% Fast Mode Tests
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% %  ______        _     __  __           _        _______        _
% % |  ____|      | |   |  \/  |         | |      |__   __|      | |
% % | |__ __ _ ___| |_  | \  / | ___   __| | ___     | | ___  ___| |_ ___
% % |  __/ _` / __| __| | |\/| |/ _ \ / _` |/ _ \    | |/ _ \/ __| __/ __|
% % | | | (_| \__ \ |_  | |  | | (_) | (_| |  __/    | |  __/\__ \ |_\__ \
% % |_|  \__,_|___/\__| |_|  |_|\___/ \__,_|\___|    |_|\___||___/\__|___/
% %
% %
% % See: http://patorjk.com/software/taag/#p=display&f=Big&t=Fast%20Mode%20Tests
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Figures start with 8
% 
% close all;
% fprintf(1,'Figure: 8XXXXXX: FAST mode cases\n');
% 
% %% Basic example - NO FIGURE
% figNum = 80001;
% fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
% figure(figNum); close(figNum);
% 
% % Set the simulation time/state arguments
% initialStates = 0; % [Omega] in [rad/sec]
% deltaT = 0.01; % Units are [sec]
% startTime = 0;
% endTime = 4.5;
% timeInterval = [startTime endTime];  % Units are [sec]
% 
% % Set up inputs
% torque_amplitude_Nm = 400; % 2 degrees of steering amplitude for input sinewave
% Period = 3; % Units are seconds. A typical lane change is about 3 to 4 seconds based on experimental highway measurements
% simulationTimes = (startTime:deltaT:endTime)';
% inputsVsTime = [simulationTimes torque_amplitude_Nm*pi/180*sin((2*pi/Period)*simulationTimes)]; % [times steering angles]
% 
% % Set up parameters
% clear parameters
% parameters.J = 2;  % J is the rotational inertia of the vehicle, in kg-m^2
% parameters.B = 2.5; % B is the rotational viscous drag, in (N-m)/(rad/sec)
% 
% % Call the function
% [stateTrajectory, t, inputHistory] = ...
% fcn_VD_FirstOrderEngineModelRK4(initialStates, deltaT, ...
% timeInterval, inputsVsTime, parameters, ([]));
% 
% % sgtitle(titleString, 'Interpreter','none');
% 
% % Check variable types
% assert(isnumeric(stateTrajectory));
% assert(isnumeric(t));
% assert(isnumeric(inputHistory));
% 
% % Check variable sizes
% assert(size(stateTrajectory,1)>=1); 
% assert(size(stateTrajectory,2)==1); 
% assert(size(t,1)==size(stateTrajectory,1)); 
% assert(size(t,2)==1); 
% assert(size(inputHistory,1)==size(stateTrajectory,1)); 
% assert(size(inputHistory,2)==1); 
% 
% % Check variable values
% % (too complex to check)
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% 
% %% Basic fast mode - NO FIGURE, FAST MODE
% figNum = 80002;
% fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
% figure(figNum); close(figNum);
% 
% % Set the simulation time/state arguments
% initialStates = 0; % [Omega] in [rad/sec]
% deltaT = 0.01; % Units are [sec]
% startTime = 0;
% endTime = 4.5;
% timeInterval = [startTime endTime];  % Units are [sec]
% 
% % Set up inputs
% torque_amplitude_Nm = 400; % 2 degrees of steering amplitude for input sinewave
% Period = 3; % Units are seconds. A typical lane change is about 3 to 4 seconds based on experimental highway measurements
% simulationTimes = (startTime:deltaT:endTime)';
% inputsVsTime = [simulationTimes torque_amplitude_Nm*pi/180*sin((2*pi/Period)*simulationTimes)]; % [times steering angles]
% 
% % Set up parameters
% clear parameters
% parameters.J = 2;  % J is the rotational inertia of the vehicle, in kg-m^2
% parameters.B = 2.5; % B is the rotational viscous drag, in (N-m)/(rad/sec)
% 
% % Call the function
% [stateTrajectory, t, inputHistory] = ...
% fcn_VD_FirstOrderEngineModelRK4(initialStates, deltaT, ...
% timeInterval, inputsVsTime, parameters, (-1));
% 
% % sgtitle(titleString, 'Interpreter','none');
% 
% % Check variable types
% assert(isnumeric(stateTrajectory));
% assert(isnumeric(t));
% assert(isnumeric(inputHistory));
% 
% % Check variable sizes
% assert(size(stateTrajectory,1)>=1); 
% assert(size(stateTrajectory,2)==1); 
% assert(size(t,1)==size(stateTrajectory,1)); 
% assert(size(t,2)==1); 
% assert(size(inputHistory,1)==size(stateTrajectory,1)); 
% assert(size(inputHistory,2)==1); 
% 
% % Check variable values
% % (too complex to check)
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% 
% %% Compare speeds of pre-calculation versus post-calculation versus a fast variant
% figNum = 80003;
% fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
% figure(figNum);
% close(figNum);
% 
% % Set the simulation time/state arguments
% initialStates = 0; % [Omega] in [rad/sec]
% deltaT = 0.01; % Units are [sec]
% startTime = 0;
% endTime = 4.5;
% timeInterval = [startTime endTime];  % Units are [sec]
% 
% % Set up inputs
% torque_amplitude_Nm = 400; % 2 degrees of steering amplitude for input sinewave
% Period = 3; % Units are seconds. A typical lane change is about 3 to 4 seconds based on experimental highway measurements
% simulationTimes = (startTime:deltaT:endTime)';
% inputsVsTime = [simulationTimes torque_amplitude_Nm*pi/180*sin((2*pi/Period)*simulationTimes)]; % [times steering angles]
% 
% % Set up parameters
% clear parameters
% parameters.J = 2;  % J is the rotational inertia of the vehicle, in kg-m^2
% parameters.B = 2.5; % B is the rotational viscous drag, in (N-m)/(rad/sec)
% 
% Niterations = 50;
% 
% % Do calculation without pre-calculation
% tic;
% for ith_test = 1:Niterations
% 	% Call the function
% 	[stateTrajectory, t, inputHistory] = ...
% 		fcn_VD_FirstOrderEngineModelRK4(initialStates, deltaT, ...
% 		timeInterval, inputsVsTime, parameters, ([]));
% end
% slow_method = toc;
% 
% % Do calculation with pre-calculation, FAST_MODE on
% tic;
% for ith_test = 1:Niterations
% 	% Call the function
% 	[stateTrajectory, t, inputHistory] = ...
% 		fcn_VD_FirstOrderEngineModelRK4(initialStates, deltaT, ...
% 		timeInterval, inputsVsTime, parameters, (-1));
% end
% fast_method = toc;
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% % Plot results as bar chart
% figure(373737);
% clf;
% hold on;
% 
% X = categorical({'Normal mode','Fast mode'});
% X = reordercats(X,{'Normal mode','Fast mode'}); % Forces bars to appear in this exact order, not alphabetized
% Y = [slow_method fast_method ]*1000/Niterations;
% bar(X,Y)
% ylabel('Execution time (Milliseconds)')
% 
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));


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
