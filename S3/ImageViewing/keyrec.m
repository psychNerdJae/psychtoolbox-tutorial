function [userInput, RT, flag] = keyrec(keysAllowed, timeLimit, continuousPress)

% Initialize time/response variables
startTime = GetSecs;  % Gets start time of trial
userInput = 'NaN';    % Default value of user's keypress
RT = NaN;             % Default value of reaction time
flag = 0;             % flag = 1 indicates that the user has responded

% Set time limit to infinity if not otherwise specified
if ~exist('timeLimit', 'var')
    timeLimit = inf;
end

% Turn continuous press OFF if not otherwise specified
if ~exist('continuousPress', 'var')
    continuousPress = 0;
end

% Get keyboard responses
while GetSecs - startTime < timeLimit
    
    % Continuously check for keypress
    [keyDown, keyTime, whichKey] = KbCheck(-1);
    
    % Runs if keypress is made
    if keyDown == 1
        
        % Identifies which key was pressed
        userInput = KbName(whichKey);
        
        % Deal with cases, spaces, and numbers
        if strcmp(userInput, '1!')
            userInput = '1';
        elseif strcmp(userInput, '2@')
            userInput = '2';
        elseif strcmp(userInput, '3#')
            userInput = '3';
        elseif strcmp(userInput, '4$')
            userInput = '4';
        elseif strcmp(userInput, '5%')
            userInput = '5';
        elseif strcmp(userInput, '6^')
            userInput = '6';
        elseif strcmp(userInput, '7&')
            userInput = '7';
        elseif strcmp(userInput, '8*')
            userInput = '8';
        elseif strcmp(userInput, '9(')
            userInput = '9';
        elseif strcmp(userInput, '0)')
            userInput = '0';
        elseif strcmp(userInput, 'space')
            userInput = 'space';
        elseif strcmp(userInput, '`~')
            userInput = '`~';
        elseif strcmp(userInput, '-_')
            userInput = '-';
        elseif strcmp(userInput, '=+')
            userInput = '=';
        elseif strcmp(userInput, ',<')
            userInput = ',';
        elseif strcmp(userInput, '.>')
            userInput = '.';
        elseif strcmp(userInput, '/?')
            userInput = '/';
        elseif strcmp(userInput, '[{')
            userInput = '[';
        elseif strcmp(userInput, ']}')
            userInput = ']';
        elseif strcmp(userInput, '\|')
            userInput = '\';
        elseif strcmp(userInput, ';:')
            userInput = ';';
        elseif strcmp(userInput, '''"')
            userInput = '''';
        else
            userInput = lower(userInput);
        end
        
        % Runs if keypress matches one of the keys allowed
        if any(strmatch(userInput, lower(keysAllowed))) %#ok<MATCH2>
            RT = keyTime - startTime;
            flag = 1;
            
            % Treats extended key depression as a single event
            if continuousPress == 0
                KbReleaseWait;
            end
            
            return
        end
    end
end

end