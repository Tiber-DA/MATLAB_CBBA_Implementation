function plotResults(agents, tasks)

figure
hold on

% Plot tasks
for i = 1:length(tasks)
    hTasks = scatter(tasks(i).pos(1), tasks(i).pos(2), 80, 'r', 'filled');
    text(tasks(i).pos(1)+1, tasks(i).pos(2)+1, num2str(tasks(i).id))
end

% Plot agents
for i = 1:length(agents)
    hAgents = scatter(agents(i).startPos(1), agents(i).startPos(2), 120, 'g','^','filled');

    % label agent ID
    text(agents(i).startPos(1)+1, agents(i).startPos(2)+1, ['A' num2str(agents(i).id)])
end

% Plot paths
for i = 1:length(agents)

    agent = agents(i);

    if isempty(agent.path)
        continue
    end

    prevPos = agent.startPos;

    for j = 1:length(agent.path)

        taskID = agent.path(j);
        taskPos = tasks(taskID).pos;

        plot([prevPos(1) taskPos(1)], [prevPos(2) taskPos(2)], 'k-')

        prevPos = taskPos;

    end
end

xlim([0 100])
ylim([0 100])
grid on
axis equal

title('CBBA Task Allocation')

legend([hTasks hAgents], {'Tasks','Agents'})

hold off

end