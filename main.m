clearvars

% Edit these values to change initialisation
numTasks = 15;
numAgents = 5;
maxTasks = 3;

% Initialise tasks and agent parameters
tasks = createTasks(numTasks);
agentIDs = 1:numAgents;

% Run CBBA
[agents, iterations, commsEvents] = runCBBA(agentIDs, tasks, maxTasks);

% Process Results
validateAssignments(agents, tasks);
displayResults(agents, tasks, iterations, commsEvents);
plotResults(agents, tasks);

