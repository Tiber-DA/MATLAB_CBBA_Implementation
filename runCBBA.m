function agents = runCBBA(allAgentIDs, taskList, maxTasks)
numTasks = length(taskList);
numAgents = length(allAgentIDs);
agents(1, numAgents) = agentInit(allAgentIDs(1), maxTasks, numAgents, allAgentIDs, numTasks);

t = 0;

for i = 1:numAgents
    agents(i) = agentInit(allAgentIDs(i), maxTasks, numAgents, allAgentIDs, numTasks);
end

while any([agents.changed])

    for i = 1:numAgents
        agents(i).changed = false;
    end

    % ---- Phase 1: Bundle Building ---- %
    for i = 1:numAgents
        agents(i) = buildBundle(agents(i), taskList);
    end

    % ---- Phase 2: Broadcast ---- %
    messagePool = struct('from', {}, 'y', {}, 'z', {}, 's', {});
    for i = 1:numAgents
        messagePool = sendMessage(agents(i), messagePool);
    end

    % ---- Phase 3: Receive ---- %
    for i = 1:numAgents
        agents(i) = receiveMessages(agents(i), messagePool);
    end

    % ---- Phase 4: Resolve Conflicts ---- %
    for i = 1:numAgents
        for m = 1:length(agents(i).msgBuffer)
            agents(i) = resolveConflicts(agents(i).msgBuffer(m), agents(i));
        end
    end
    for i = 1:numAgents
        for m = 1:length(agents(i).msgBuffer)
            agents(i) = resolveConflicts(agents(i).msgBuffer(m), agents(i));
        end
        idx_i = agents(i).idToIdx(agents(i).id);
        agents(i).s(idx_i) = agents(i).s(idx_i) + 1;
    end
    t = t + 1;
end

% ------------- RESULTS ------------ %

fprintf('\n========== FINAL RESULTS ==========\n');

fprintf('\nPer-agent bundles:\n');
for a = 1:numAgents
    fprintf('Agent %d: ', agents(a).id);
    if isempty(agents(a).bundle)
        fprintf('(none)\n');
    else
        fprintf('%s\n', mat2str(agents(a).bundle));
    end
end

finalZ = agents(1).z;
finalY = agents(1).y;

fprintf('\nFinal task -> agent assignment:\n');
for j = 1:numTasks
    if finalZ(j) == -1
        fprintf('Task %d: (unassigned)\n', j);
    else
        fprintf('Task %d: Agent %d (bid = %.3f)\n', ...
            j, finalZ(j), finalY(j));
    end
end

fprintf('\nFinal timestamps (s) from Agent %d:\n', agents(1).id);
fprintf('s: %s\n', mat2str(agents(1).s));

disp("Converged on Iteration: " + t);

end

