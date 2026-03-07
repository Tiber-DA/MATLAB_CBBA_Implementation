function displayResults(agents, tasks, iterations, commsEvents)

numAgents = length(agents);
numTasks = length(tasks);

fprintf('\n========== FINAL RESULTS ==========\n');

% Per-agent bundles
fprintf('\nPer-agent bundles:\n');
for a = 1:numAgents
    fprintf('Agent %d: ', agents(a).id);
    
    if isempty(agents(a).bundle)
        fprintf('(none)\n');
    else
        fprintf('%s\n', mat2str(agents(a).bundle));
    end
end

% % Final assignment
% finalZ = agents(1).z;
% finalY = agents(1).y;
% 
% fprintf('\nFinal task -> agent assignment:\n');
% 
% for j = 1:numTasks
%     if finalZ(j) == -1
%         fprintf('Task %d: (unassigned)\n', j);
%     else
%         fprintf('Task %d: Agent %d (bid = %.3f)\n', ...
%             j, finalZ(j), finalY(j));
%     end
% end

% Timestamp display
% fprintf('\nFinal timestamps (s) from Agent %d:\n', agents(1).id);
% fprintf('s: %s\n', mat2str(agents(1).s));

fprintf('\nConverged on Iteration: %d\n', iterations);
fprintf('Communication Events: %d\n', commsEvents);

end