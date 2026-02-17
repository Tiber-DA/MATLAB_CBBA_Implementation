function agent = receiveMessages(agent, messagePool)
% Receive messages from other agents
% messagePool contains all broadcasts from this iteration.
% Each agent reads every message except its own.
% Clear old messages from previous iteration
agent.msgBuffer = struct('from', {}, 'y', {}, 'z', {}, 's', {});

for m = 1:length(messagePool)

    msg = messagePool(m);

    % Ignore own broadcast
    if msg.from ~= agent.id
        
        % Store the message for conflict resolution phase
        agent.msgBuffer(end + 1) = msg;

    end
end
end
