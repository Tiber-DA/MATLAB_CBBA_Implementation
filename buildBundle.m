function agent = buildBundle(agent, taskList)

% y = best known bid for each task
% z = agent currently believed to win each task
y = agent.y;
z = agent.z;

% bundle = tasks this agent has committed to
% path   = execution order of those tasks
bundle = agent.bundle;
path   = agent.path;

agent.changed = true;

% Keep adding tasks until reaching capacity
while length(bundle) < agent.maxTasks

    nTasks = length(taskList);

    % bestGain(j) = best marginal improvement for inserting task j
    bestGain = -inf(1, nTasks);

    % feasible(j) = whether agent is allowed to bid on task j
    feasible  = false(1, nTasks);

    % bestPos(j) = best insertion position for task j
    bestPos   = zeros(1, nTasks);


    % Evaluate every task not already in our bundle
    for idx = 1:nTasks

        taskID = taskList(idx).id;

        % Skip tasks agent has already committed to
        if ~ismember(taskID, bundle)

            bestGainValue = -inf;
            bestP = -1;

            % Current score of existing path
            currentScore = score(path, taskList, agent);

            % Insert this task in every possible position
            for pos = 1:length(path)+1

                % Create temporary path with task inserted
                tempPath = [path(1:pos-1), taskID, path(pos:end)];

                % Compute new total score
                newScore = score(tempPath, taskList, agent);

                % Marginal gain = how much better than current path
                gain = newScore - currentScore;

                % Keep best insertion position
                if gain > bestGainValue
                    bestGainValue = gain;
                    bestP = pos;
                end
            end

            % Store best marginal gain for this task
            bestGain(idx) = bestGainValue;
            bestPos(idx)  = bestP;

            % Only bid if our marginal gain beats current winner
            feasible(idx) = bestGain(idx) > y(taskID);

        end
    end

    % Invalidate non-feasible tasks (another agent already has a better
    % bid)
    bestGain(~feasible) = -inf;

    % Select task with highest marginal gain
    [maxGain, bestIdx] = max(bestGain);

    % If no valid task remains, stop building bundle
    if isinf(maxGain) && maxGain < 0   % covers -inf
        break;
    end

    chosenTaskID = taskList(bestIdx).id;
    insertPos    = bestPos(bestIdx);

    % Commit the selected tasK

    % Insert into execution path at best position
    path   = [path(1:insertPos-1), chosenTaskID, path(insertPos:end)];

    % Add to bundle
    bundle = [bundle, chosenTaskID];

    % Update local winning belief
    y(chosenTaskID) = maxGain;
    z(chosenTaskID) = agent.id;

end
% Mark that agent state changed this iteration
agent.changed = true;

if isequal(bundle, agent.bundle)
    agent.changed = false;
else
    % Write updated values back into agent
    agent.bundle = bundle;
    agent.path   = path;
    agent.y      = y;
    agent.z      = z;
end
end
