function ImageRatingSolution(subNumber, debugMode)
%% README
% Written by Jae-Young Son
% Last updated 12-12-18

% There are many functions & idioms here that you have not yet encountered
% in this workshop. However, at this point, you should familiar enough with
% the principles of programming that you can guess what different blocks of
% code accomplish, and more importantly, *how*.

% For the sake of time, I have provided a lot of starter code. Instead of
% glossing over it, I encourage you to read through it and think about...
%   1. the design choices and how they contribute to the user's experience
%   2. the computational problems that were posed by those design choices
%   3. the algorithmic logic underlying how these problems were solved
%   4. whether you could solve these problems differently/more efficiently

% I have left certain computational problems unsolved. They are indicated
% by comments that say FILL IN HERE. In solving these problems, it is 
% likely that you will have to teach yourself new functions, write new
% algorithms that you've never written before, and generally exercise your
% creative problem-solving capacities. As I've said before, 90% of all
% programming is knowing how to google solutions to your error messages!


%% Initialize task

% Return error if subject number is not provided
if ~exist('subNumber', 'var')
    error('No subject number provided!')
end

% Return error if subject number already exists
if exist([num2str(subNumber) '_imgRating_workspace.mat'], 'file') == 2
    warning = ['That subject already exists.' ...
        'Use a different number to avoid overwriting data!'];
    error(warning)
end

% Set debug mode defaults
if ~exist('debugMode', 'var')
    debugMode = 0;
end

% Sets window opacity depending on whether debug mode is turned on
if debugMode == 1
    PsychDebugWindowConfiguration([], 0.25);  % Turns on debugging screen
else
    PsychDebugWindowConfiguration([], 1);  % Keeps debugging screen off
    HideCursor;
end

% Shuffle the seed of the random number generator
% Very important! Otherwise, Matlab defaults to the same seed when restarted
rng('shuffle')


%% Initialize screen

% Skip screen calibration tests! Comment out if this is important to you!
Screen('Preference', 'SkipSyncTests', 1);

% VisualDebugLevel 0 turns off most error warnings! Change to 3 for default setting
Screen('Preference', 'VisualDebugLevel', 0);

% Turns off all warnings! Comment out if warnings are important to you!
Screen('Preference', 'SuppressAllWarnings', 1);

% Returns an array of screen numbers
screen = Screen('Screens');

% Actually opens screen
[wPtr, screenres] = Screen('OpenWindow', screen(1));


%% Define colors + screen dimensions

black = BlackIndex(wPtr);
white = WhiteIndex(wPtr);
bottom = screenres(4);               % screenres(4) relative to screen bottom
right = screenres(3);                % screenres(3) relative to screen right
xCenter = right/2;                   % Calculates center of screen on x-axis
yCenter = bottom/2;                  % Calculates center of screen on y-axis
midRight = xCenter + xCenter/2;      % Calculates right quarter of screen on x-axis
midLeft = xCenter - xCenter/2;       % Calculates left quarter of screen on x-axis
midTop = yCenter - yCenter/4;        % Calculates top quarter of screen on y-axis
midBottom = yCenter + yCenter/4;     % Calculates bottom quarter of screen on y-axis
textWrap = round(right*0.05);        % Number of characters displayed on single line before wrapping


%% Reads in animal and chair images & randomizes order

% Find images
animalPics = dir('animal*.jpg'); chairPics = dir('chair*.jpg');
animalNum = numel(animalPics); chairNum = numel(chairPics);

% Initialize storage arrays
animalNames = {};
chairNames = {};
animalTextures = [];
chairTextures = [];
resultsTrialOrder = {};

% Read in animal images
for j = 1:animalNum
    filename = animalPics(j).name;
    image = imread(filename);
    texture = Screen('MakeTexture', wPtr, image);
    animalNames = [animalNames filename];
    animalTextures = [animalTextures texture];
end

% Read in chair images
for j = 1:chairNum
    filename = chairPics(j).name;
    image = imread(filename);
    texture = Screen('MakeTexture', wPtr, image);
    chairNames = [chairNames filename];
    chairTextures = [chairTextures texture];
end

% Create a single "trial matrix" containing all of your stimuli's filenames
% and texture identifier numbers
resultsTrialOrder(1, :) = [animalNames, chairNames];
resultsTrialOrder(2, :) = [num2cell(animalTextures), num2cell(chairTextures)];

% Randomize trial order
resultsTrialOrder = Shuffle(resultsTrialOrder, 1);
randomTextureOrder = cell2mat(resultsTrialOrder(2, :));


%% Define task instructions text

instructionText{1} = ['Welcome to the study! You will now review the ' ...
    'instructions for the task you are about to complete.'];
instructionText{2} = ['You will see some images, and then you will be ' ...
    'asked to make a rating of how much you like that image.\n\n', ...
    'A rating of 1 indicates that you strongly dislike the image. A ' ...
    'rating of 5 indicates that you strongly like the image. A rating', ...
    ' of 3 indicates that you have no feelings about the image.'];
instructionText{3} = ['You will have 3 seconds to respond before the ' ...
    'computer automatically advances to the next trial.'];
spaceText= 'Please press the SPACEBAR to continue';


%% Displays instructions

for j = 1:length(instructionText)
    textDisplay = instructionText{j};
    Screen('FillRect', wPtr, black);
    DrawFormattedText(wPtr, textDisplay, midLeft, 'center', white, textWrap);
    DrawFormattedText(wPtr, spaceText, 'center', midBottom+100, white);
    Screen('Flip', wPtr);
    
    % Puts script on pause until user hits the spacebar
    [~, ~, ~] = keyrec('space', inf, 0);
end

DrawFormattedText(wPtr, 'Get Ready!', 'center', 'center', white);
Screen(wPtr, 'Flip');
WaitSecs(2);

DrawFormattedText(wPtr, '+', 'center', 'center', white);
Screen(wPtr, 'Flip');
WaitSecs(2);


%% Main body of task

% Instruction text and scale
rateInstruction = 'Please rate how much you like this image.';
responseText = '[1: strongly dislike]    2    3    4    [5: strongly like]';

% Initializing storage arrays
resultsRT = [];
resultsRatings = {};

% Define how long trials should be
trialTime = 3;

for j = 1:length(randomTextureOrder)
    % Draws stimulus to be rated
    Screen('DrawTexture', wPtr, randomTextureOrder(j));
    
    % Draws/positions instruction text
    DrawFormattedText(wPtr, rateInstruction, 'center', midTop-100, white);
    
    % Draws/positions response text
    DrawFormattedText(wPtr, responseText, 'center', midBottom+100, white);
    
    % Display
    Screen('Flip', wPtr);
    
    % Get user response
    [userInput, RT, ~] = keyrec({'1', '2', '3', '4', '5'}, trialTime, 0);
    
    % Record each trial's rating & RT in the arrays previously initialized
    resultsRatings = [resultsRatings, userInput];
    resultsRT = [resultsRT, RT];
    
    % Save the workspace after every response to recover data in case
    % the program unexpectedly crashes
    eval(['save ' ...
    num2str(subNumber) ...
    '_imgRating_workspace'])
    
    % Draw/display fixation cross
    DrawFormattedText(wPtr, '+', 'center', 'center', white);
    Screen(wPtr, 'Flip');
    WaitSecs(2);
end


%% Exit out of program

% Save workspace
eval(['save ' ...
    num2str(subNumber) ...
    '_imgRating_workspace'])

% Draw/display exit text
endText = 'Thank you for participating. Please press any key to exit.';
DrawFormattedText(wPtr, endText, 'center', 'center', white);
Screen(wPtr, 'Flip');

% Wait for keystroke before closing out
KbStrokeWait;
Screen('CloseAll');
ShowCursor;


end