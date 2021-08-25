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

% Define screen dimensions
bottom = screenres(4);
right = screenres(3);
xCenter = right/2;
yCenter = bottom/2;        

% Define colors
black = BlackIndex(wPtr);
white = WhiteIndex(wPtr);
blue = [0 0 255];

% Fill entire screen with blue
Screen('FillRect', wPtr, blue);

% Display
Screen(wPtr, 'Flip');

% Wait for keypress
KbStrokeWait;

% Draw centered rectangle
rectSize = [0 0 300 100];
rectCentered = CenterRectOnPointd(rectSize, xCenter, yCenter);
Screen('FillRect', wPtr, white, rectCentered);

% Display
Screen(wPtr, 'Flip');

% Wait for keypress and close screen
KbStrokeWait;
Screen('CloseAll');

