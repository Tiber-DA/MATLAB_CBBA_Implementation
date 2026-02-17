function totalScore = score(path, taskList, agent)

    Lambda   = 0.95;   % Discount factor
    velocity = 1;      % Constant velocity
    totalScore   = 0;

    % If path is empty → score is zero
    if isempty(path)
        return
    end

    % Start from agent position
    currentPos = agent.startPos;

    % ----- First Task -----
    firstTask = taskList(path(1));
    distanceAccum = norm(currentPos - firstTask.pos);

    totalScore = (Lambda^(distanceAccum/velocity)) * firstTask.reward;

    % ----- Remaining Tasks -----
    for i = 2:length(path)

        prevTask = taskList(path(i-1));
        currTask = taskList(path(i));

        % Add incremental distance
        distanceAccum = distanceAccum + ...
            norm(prevTask.pos - currTask.pos);

        % Add discounted reward
        totalScore = totalScore + ...
            (Lambda^(distanceAccum/velocity)) * currTask.reward;
    end

end
