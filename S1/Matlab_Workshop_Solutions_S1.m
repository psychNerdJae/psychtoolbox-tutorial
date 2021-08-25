%% Checkpoint #1: Basic addition calculator

num1 = input('Please enter a number: ');
num2 = input('Please enter another number: ');
result = num1 + num2;
disp([num2str(num1) '+' num2str(num2) '=' num2str(result)])


%% Checkpoint #2: Four-function arithmetic calculator

% Not usually good coding practice to clear all of your variables, but
% since I'm compiling multiple exercises into a single script...
clear all

% Find out what operation the user wants to perform
userInput = input('What sort of operaton would you like to perform? ', 's');
userInput = upper(userInput);  % Lets you treat ADD and add as being the same

% Compare the user input with a list of known operations
if strcmp(userInput, 'ADD') || strcmp(userInput, 'ADDITION') || ...
        strcmp(userInput, 'PLUS') || strcmp(userInput, '+')
    operationType = '+';
elseif strcmp(userInput, 'SUBTRACT') || strcmp(userInput, 'SUBTRACTION') || ...
        strcmp(userInput, 'MINUS') || strcmp(userInput, '-')
    operationType = '-';
elseif strcmp(userInput, 'MULTIPLY') || strcmp(userInput, 'MULTIPLICATION') || ...
        strcmp(userInput, 'TIMES') || strcmp(userInput, '*')
    operationType = '*';
elseif strcmp(userInput, 'DIVIDE') || strcmp(userInput, 'DIVISION') || ...
        strcmp(userInput, '/')
    operationType = '/';
else
    disp('That''s not a valid command!');
    return
end

% Get two numbers from the user
num1 = input('Please enter a number: ');
num2 = input('Please enter another number: ');

% Compute the result
if strcmp(operationType, '+')
    result = num1 + num2;
elseif strcmp(operationType, '-')
    result = num1 - num2;
elseif strcmp(operationType, '*')
    result = num1*num2;
elseif strcmp(operationType, '/')
    result = num1/num2;
end

% Display the result
disp([num2str(num1) operationType num2str(num2) '=' num2str(result)])


%% Checkpoint #3: Quadratic equation calculator

clear all

% Get user inputs
a = input('Please input a number: ');
b = input('Please input another number: ');
c = input('One more number, please! ');

if a == 0 || ((b^2)-(4*a*c)) < 0  % Let people know if there are non-real solutions
    disp('There are no real solutions to this equation!')
else  % Otherwise, compute the two answers
    x1 = (-b + sqrt((b^2)-(4*a*c))) / (2*a);
    x2 = (-b - sqrt((b^2)-(4*a*c))) / (2*a);
    disp(['The first solution is ', num2str(x1)])
    disp(['The second solution is ', num2str(x2)])
end


%% Checkpoint #4: Summary statistics calculator

clear all

% Initialize empty array
userNumbers = [];

% Collect user-inputted numbers until sentinel is recorded
while 1  % Creates an infinite loop
    % Note that userInput is saved as a string, not a number!
    userInput = input('Enter a number, or type ''STOP'' to stop: ', 's');
    userInput = upper(userInput);
    
    % Check for sentinel
    if strcmp(userInput, 'STOP')
        break
    end
    
    % Convert string to number
    userInput = str2double(userInput);
    
    % This is a programming idiom that lets you save new elements to the
    % end of an array
    userNumbers = [userNumbers userInput];
end

% Calculate N, max, min, and range
N = length(userNumbers);
maxValue = max(userNumbers);
minValue = min(userNumbers);
rangeValue = maxValue - minValue;
meanValue = mean(userNumbers);
sdValue = std(userNumbers);

% Display results of calculations
disp(['The number of observations is ', num2str(N)])
disp(['The maximum value is ', num2str(maxValue)])
disp(['The minimum value is ', num2str(minValue)])
disp(['The range is ', num2str(rangeValue)])
disp(['The mean is ', num2str(meanValue)])
disp(['The standard deviation is ', num2str(sdValue)])


%% Checkpoint #5: Kind messages

clear all

% Initialize empty cell array
userNames = {};

% Collect user-inputted names until sentinel is recorded
while 1
    userInput = input('Enter a name, or type ''STOP'' to stop: ', 's');
    
    % Check for sentinel
    if strcmpi(userInput, 'STOP')  % strcmpi is case-insensitive strcmp
        break
    end
    
    % This is a programming idiom that lets you save new elements to the
    % end of an array
    userNames = [userNames userInput];
end

for j = 1:length(userNames)
    disp(['I appreciate ' cell2mat(userNames(j)) '''s impact on my life!'])
end

