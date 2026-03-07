function validateAssignments(agents, tasks)

% --- Per-agent duplicate check ---
for a = 1:length(agents)
    b = agents(a).bundle;

    if ~isempty(b) && numel(b) ~= numel(unique(b))
        warning('Agent %d has duplicate tasks in its bundle: %s', ...
            agents(a).id, mat2str(b));
    end
end

% --- Cross-agent assignment check ---
numTasks = length(tasks);
assignmentOwners = cell(1, numTasks);

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
        warning('Task %d assigned to multiple agents: %s', ...
            t, mat2str(owners));
    end
end

if ~conflictFound
    fprintf('No cross-agent assignment conflicts detected.\n');
end

end