clearvars

tasks = createTasks(50);
agentIDs = 1:18;
maxTasks = 5;

[agents, iterations, commsEvents] = runCBBA(agentIDs, tasks, maxTasks);

displayResults(agents, tasks, iterations, commsEvents);

validateAssignments(agents, tasks);


