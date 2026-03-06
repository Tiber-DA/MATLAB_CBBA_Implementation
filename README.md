## MATLAB CBBA Implementation

A simple MATLAB implementation of the Consensus-Based Bundle Algorithm (CBBA).

This repository was created to understand how the CBBA algorithm works in practice by implementing the core components of the algorithm, including bundle construction, message passing and conflict resolution.

## Files

- main.m – entry point that creates tasks and agents and runs the algorithm
- runCBBA.m – main loop that runs bundle building, communication, and consensus\
- agentInit.m – initializes agent state
- buildBundle.m – bundle construction phase
- resolveConflicts.m – conflict resolution between agents
- sendMessage.m – creates broadcast messages
- receiveMessages.m – receives messages from other agents
- score.m – scoring function used to evaluate tasks
- createTasks.m – generates random tasks

## References 

H.-L. Choi, L. Brunet, and J. P. How, “Consensus-based decentralized auctions for robust task allocation,” IEEE Trans. Robot., vol. 25, no. 4, pp. 912–926, Aug. 2009.
