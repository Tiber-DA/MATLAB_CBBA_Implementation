clearvars
tasks = createTasks(20);
agentIDs = [1 2 3 4 5 6 7 8 9 10];
maxTasks = 1;
% Run algorithm
agents = runCBBA(agentIDs, tasks, maxTasks);

% Per-agent: duplicates within a single bundle
for a = 1:length(agents)
    b = agents(a).bundle;
    if ~isempty(b) && numel(b) ~= numel(unique(b))
        warning('Agent %d has duplicate tasks in its bundle: %s', agents(a).id, mat2str(b));
    end
end

% Cross-agent: tasks assigned to multiple agents
numTasks = length(tasks);
assignmentOwners = cell(1, numTasks); % cell of agent IDs that claim each task

for a = 1:length(agents)
    for t = agents(a).bundle
        assignmentOwners{t} = [assignmentOwners{t}, agents(a).id];
    end
end

conflictFound = false;
for t = 1:numTasks
    owners = assignmentOwners{t};
    if ~isempty(owners) && numel(unique(owners)) > 1
        conflictFound = true;
        warning('Task %d assigned to multiple agents: %s', t, mat2str(owners));
    end
end

if ~conflictFound
    fprintf('No cross-agent assignment conflicts detected.\n');
end


