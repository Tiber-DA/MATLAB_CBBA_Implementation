function agent = agentInit(agentID, maxTasks, numAgents, allAgentIDs, numTasks)

% ---------------- Agent Identity ----------------
% Unique identifier for this agent
agent.id = agentID;

% Maximum number of tasks this agent is allowed to win
agent.maxTasks = maxTasks;

% Total number of agents in the swarm
agent.numAgents = numAgents;

% ---------------- ID Mapping ----------------
% Store full list of agent IDs 
agent.idList = allAgentIDs;  

% Create a lookup table so we can convert an agent ID
% into its index position 
agent.idToIdx = containers.Map(allAgentIDs, 1:numAgents);

% ---------------- Bundle & Path ----------------
% Bundle = ordered list of tasks this agent has committed to
agent.bundle = [];

% Path = execution order of tasks 
agent.path = [];

% ---------------- CBBA Belief Vectors ----------------
% y(j) = best known bid value for task j
agent.y = -inf(1, numTasks);

% z(j) = ID of the agent currently believed to be winning task j
% -1 = none
agent.z = -ones(1, numTasks);

% ---------------- Timestamp ----------------
% s(i) = last known update time for agent i
% determines whose information is more recent
agent.s = zeros(1, numAgents);

% Local logical clock
agent.timeStep = 0;

% ---------------- Messaging ----------------
% Buffer that stores received messages during consensus phase
agent.msgBuffer = struct('from', {}, 'y', {}, 'z', {}, 's', {});

% ---------------- Convergence Tracking ----------------
% Flag used to check whether this agent changed during an iteration
agent.changed = true;

% ---------------- Initial Position ----------------
agent.startPos = rand(1,2) * 100;

end
