clearvars

% Initialise tasks and agent parameters
tasks = createTasks(15);
agentIDs = 1:5;
maxTasks = 3;

% Run CBBA
[agents, iterations, commsEvents] = runCBBA(agentIDs, tasks, maxTasks);

% Process Results
validateAssignments(agents, tasks);
displayResults(agents, tasks, iterations, commsEvents);
plotResults(agents, tasks);

