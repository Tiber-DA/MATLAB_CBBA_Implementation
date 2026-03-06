function agent = resolveConflicts(senderMsg, agent)

i = agent.id;
k = senderMsg.from;
y_k = senderMsg.y;
z_k = senderMsg.z;
s_k = senderMsg.s;
s_i = agent.s;

for a = 1:length(agent.s)
    agent.s(a) = max(agent.s(a), s_k(a));
end

for j = 1:length(agent.y)

    y_ij = agent.y(j);
    z_ij = agent.z(j); 
    y_kj = y_k(j);
    z_kj = z_k(j);

    % -------- Sender Case 1: z_kj = k -------- %
    if z_kj == k
        switch z_ij

            % Case: 1 (i)
            case i
                if y_kj > y_ij
                    agent = update(agent,j, y_kj, z_kj);
                    
                else
                    agent = leave(agent);
                end

            % Case: 2 (k)
            case k
                agent = update(agent,j, y_kj, z_kj);
                

            % Case: 3 (none)
            case -1
                agent = update(agent,j, y_kj, z_kj);
                

            % Case: 4 (m)
            otherwise
                m = z_ij;
                idx_m = agent.idToIdx(m);
                if (s_k(idx_m) > s_i(idx_m)) || (y_kj > y_ij)
                    agent = update(agent,j, y_kj, z_kj);
                    
                end
        end

    % -------- Sender Case 2: z_kj = i -------- %
    elseif z_kj == i
        switch z_ij

            % Case: 5 (i)
            case i
                agent = leave(agent);

            % Case: 6 (k)
            case k
                agent = reset(agent, j);
                

            % Case: 7 (none)
            case -1
                agent = leave(agent);

            % Case: 8 (m)
            otherwise
                m = z_ij;
                idx_m = agent.idToIdx(m);
                if s_k(idx_m) > s_i(idx_m)
                    agent = reset(agent, j);
                    
                end
        end

    % -------- Sender Case 3: z_kj = none -------- %
    elseif z_kj == -1
        switch z_ij

            % Case: 9 (i)
            case i
                agent = leave(agent);

            % Case: 10 (k)    
            case k 
                agent = update(agent,j, y_kj, z_kj);
                

            % Case: 11 (none)
            case -1
                agent = leave(agent);

            % Case: 12 (m) 
            otherwise
                m = z_ij;
                idx_m = agent.idToIdx(m);
                if s_k(idx_m) > s_i(idx_m)
                    agent = update(agent,j, y_kj, z_kj);
                    
                end
        end

    % -------- Sender Case 4: z_kj = m -------- %
    else
        m = z_kj;
        idx_m = agent.idToIdx(m);

        switch z_ij 
            
            % Case: 13 (i)
            case i 
                if (s_k(idx_m) > s_i(idx_m)) && (y_kj > y_ij)
                    agent = update(agent,j, y_kj, z_kj);
                    
                end
                
            % Case: 14 (k)    
            case k
                if s_k(idx_m) > s_i(idx_m)
                    agent = update(agent,j, y_kj, z_kj);
                    
                else 
                    agent = reset(agent, j);
                    
                end 

            % Case: 15 (m)
            case m
                if s_k(idx_m) > s_i(idx_m)
                    agent = update(agent,j, y_kj, z_kj);
                    
                end

            % Case: 16 (none)    
            case -1
                if s_k(idx_m) > s_i(idx_m)
                    agent = update(agent,j, y_kj, z_kj);
                    
                end 

            % Case: 17 (n)    
            otherwise
                n = z_ij;
                if n ~= -1
                    idx_n = agent.idToIdx(n);

                    if (s_k(idx_m) > s_i(idx_m)) && (s_k(idx_n) > s_i(idx_n))
                        agent = update(agent,j, y_kj, z_kj);
                        

                    elseif (s_k(idx_m) > s_i(idx_m)) && (y_kj > y_ij)
                        agent = update(agent,j, y_kj, z_kj);
                        

                    elseif (s_k(idx_n) > s_i(idx_n)) && (s_i(idx_m) > s_k(idx_m))
                        agent = reset(agent, j);
                        
                    else 
                        agent = leave(agent);
                    end
                end            
        end
    end
end
agent = pruneBundle(agent);
end

function agent = reset(agent, j)
agent.y(j) = -inf;
agent.z(j) = -1;
end

function agent = leave(agent)
% no change
end

function agent = update(agent,j, y_kj, z_kj)
agent.y(j) = y_kj;
agent.z(j) = z_kj;
end

function agent = pruneBundle(agent)
bundle = agent.bundle;
path   = agent.path;

for idx = 1:length(bundle)

    task = bundle(idx);

    
    if agent.z(task) ~= agent.id

        tasksToRemove = bundle(idx:end);

        agent.y(tasksToRemove) = -inf;
        agent.z(tasksToRemove) = -1;

        bundle = bundle(1:idx-1);
        path   = path(~ismember(path, tasksToRemove));

        break;
    end
end
agent.bundle = bundle;
agent.path   = path;
end