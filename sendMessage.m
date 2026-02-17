function messagePool = sendMessage(agent, messagePool)
% Create a message containing this agent's current beliefs

% ID of the sender
msg.from = agent.id;

% Current winning bid values for all tasks
% y = best known bid for each task 
msg.y = agent.y; 

% Current winning agent assignments
% z = agent believed to be winning each task
msg.z = agent.z;

% s(k) = how recent this agent believes agent k info is
msg.s = agent.s;

% Add this message to the shared message pool
messagePool(end+1) = msg;

end
