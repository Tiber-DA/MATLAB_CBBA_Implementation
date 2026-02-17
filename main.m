clearvars
tasks = createTasks(20);
agentIDs = [1 2 3 4];
maxTasks = 5;
agents = runCBBA(agentIDs, tasks, maxTasks);

