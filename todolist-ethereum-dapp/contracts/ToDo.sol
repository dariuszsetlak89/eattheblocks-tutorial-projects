// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ToDo {

  struct Task {
    uint id;
    uint date;
    string content;
    string author;
    bool done;
  }

  // Task[] tasks;
  uint lastTaskId;
  mapping(uint => Task) tasks;
  uint[] taskIds;

  event TaskCreated(uint, uint, string, string, bool);

  constructor() {
    lastTaskId = 0;
  }

  function createTask(string memory _content, string memory _author) public {
    // tasks.push(Task(tasks.length, block.timestamp, _content, _author, false));
    lastTaskId++;
    tasks[lastTaskId] = Task(lastTaskId, block.timestamp, _content, _author, false);
    taskIds.push(lastTaskId);
    emit TaskCreated(lastTaskId, block.timestamp, _content, _author, false);
  }

  function getTaskIds() public view returns(uint[] memory) {
    return taskIds;
  }

  function getTask(uint _id) public view taskExists(_id)
    returns(
      uint, 
      uint, 
      string memory, 
      string memory, 
      bool
    ) {
      return(
        _id, 
        tasks[_id].date, 
        tasks[_id].content, 
        tasks[_id].author, 
        tasks[_id].done
      );
    }

  // function getTasks() public view returns(Task[] memory) {
  //   return tasks;
  // }

  modifier taskExists(uint _id) {
    if(tasks[_id].id == 0) {
        revert();
    }
    _;
  }
}