function tasks = createTasks(n)
tasks = struct('id', {}, 'pos', {}, 'reward', {}, 'duration', {});

for t = 1:n
    tasks(t).id = t;                    
    tasks(t).pos = rand(1,2) * 100;      
    tasks(t).reward = randi(500);                 
end
end
