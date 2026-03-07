function [agents, t, commsEvents] = runCBBA(allAgentIDs, taskList, maxTasks)
numTasks = length(taskList);
numAgents = length(allAgentIDs);
agents(1, numAgents) = agentInit(allAgentIDs(1), maxTasks, numAgents, allAgentIDs, numTasks);

t = 0;
commsEvents = 0;

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
        commsEvents = commsEvents + (numAgents - 1);
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

end

