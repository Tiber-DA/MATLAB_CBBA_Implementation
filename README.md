## MATLAB CBBA Implementation

A simple MATLAB implementation of the Consensus-Based Bundle Algorithm (CBBA).

This repository was created to understand how the CBBA algorithm works in practice by implementing the core components of the algorithm, including bundle construction, message passing and conflict resolution.

## Files

- main.m – entry point that creates tasks and agents and runs the algorithm
- runCBBA.m – main loop that runs bundle building, communication, and consensus
- agentInit.m – initializes agent state
- buildBundle.m – bundle construction phase
- resolveConflicts.m – conflict resolution between agents
- sendMessage.m – creates broadcast messages
- receiveMessages.m – receives messages from other agents
- score.m – scoring function used to evaluate tasks
- createTasks.m – generates random tasks
- plotResults – plots the paths of each agent
- displayResults – prints the final task allocations
- validateAssignments – checks for per-agent an cross-agent duplicate task allocations
  
## Running
Run the main script in MATLAB:

- main.m

This will create a set of agents and tasks and execute the CBBA algorithm until convergence.

## References 

H.-L. Choi, L. Brunet, and J. P. How, “Consensus-based decentralized auctions for robust task allocation,” IEEE Trans. Robot., vol. 25, no. 4, pp. 912–926, Aug. 2009.
