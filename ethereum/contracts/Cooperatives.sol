pragma solidity ^0.4.24;

contract Cooperatives {
  /* EVENTS */
  event MemberRegistered(address indexed account);
  event MemberRemoval(address indexed account);
  event DirectorRegistered(address indexed account);
  event DirectorRemoval(address indexed account);
  event Deposit(address indexed sender, uint amount);
  event Withdraw(address indexed sender, uint amount);
  event Confirmation(address indexed sender, uint indexed transactionId);
  event Revocation(address indexed sender, uint indexed transactionId);
  event Submission(uint indexed transactionId);
  event Execution(uint indexed transactionId);
  event ExecutionFailure(uint indexed transactionId);
  event RequirementChange(uint required);

  /* PUBLIC DATA */
  string private name;
  string private description;
  address[] private members;
  address[] private directors;
  uint private transactionCount;
  uint private required;
  uint256 private defaultJoinFee = 200000000000000000; // 25 USD

  mapping (uint => Transaction) private transactions;
  mapping (uint => mapping (address => bool)) private confirmations;
  mapping (address => bool) private isDirector;
  mapping (address => bool) private isMember;
  mapping (address => uint) private balance;

  struct Transaction {
    address destination;
    uint value;
    bytes data;
    bool executed;
  }

  /* Sets the contract deployer as the director and a member temporarily */
  constructor(string _name, string _desc) public {
    name = _name;
    description = _desc;
    required = 1;
    directors.push(msg.sender);
    isDirector[msg.sender] = true;
    emit DirectorRegistered(msg.sender);
    members.push(msg.sender);
    isMember[msg.sender] = true;
    emit MemberRegistered(msg.sender);
  }

  function addTransaction(address destination, uint value, bytes data)
  internal returns (uint transactionId) {
    require(destination != 0);
    transactionId = transactionCount;
    transactions[transactionId] = Transaction({
      destination: destination,
      value: value,
      data: data,
      executed: false
    });
    transactionCount += 1;
    emit Submission(transactionId);
  }

  function () payable public{
  }

  function joinCoop(uint amount) payable public {
    require(
      !isMember[msg.sender] &&
      msg.value == amount &&
      msg.value >= defaultJoinFee
    );
    members.push(msg.sender);
    isMember[msg.sender] = true;
    emit MemberRegistered(msg.sender);
  }

  function setDirector(address member) public {
    require(
      isMember[member] &&
      isDirector[msg.sender]
    );
    directors.push(member);
    isDirector[member] = true;
    emit DirectorRegistered(member);
  }

  function deposit(uint amount) payable public {
    require(
      msg.value == amount &&
      isMember[msg.sender]
    );
    balance[msg.sender] += amount;
    emit Deposit(msg.sender, amount);
  }

  function withdraw(uint amount) public {
    require(
      isMember[msg.sender] &&
      balance[msg.sender]>=amount
    );
    msg.sender.transfer(amount);
    balance[msg.sender] -= amount;
    emit Withdraw(msg.sender, amount);
  }

  function submitRequest(address destination, uint value, bytes data)
  public returns (uint transactionId){
    require(isMember[msg.sender]);
    transactionId = addTransaction(destination, value, data);
  }

  function confirmTransaction(uint transactionId) public {
    require(
      isDirector[msg.sender] &&
      transactions[transactionId].destination != 0 &&
      !confirmations[transactionId][msg.sender]
    );
    confirmations[transactionId][msg.sender] = true;
    emit Confirmation(msg.sender, transactionId);
    executeTransaction(transactionId);
  }

  function revokeTransaction(uint transactionId) public {
    require(
      isDirector[msg.sender] &&
      confirmations[transactionId][msg.sender] &&
      !transactions[transactionId].executed
    );
    confirmations[transactionId][msg.sender] = false;
    emit Revocation(msg.sender, transactionId);
  }

  function executeTransaction(uint transactionId) public {
    require(
      !transactions[transactionId].executed
    );
    if (isConfirmed(transactionId)) {
      Transaction storage txn = transactions[transactionId];
      txn.executed = true;
      if (txn.destination.call.value(txn.value)(txn.data))
        emit Execution(transactionId);
      else {
        emit ExecutionFailure(transactionId);
        txn.executed = false;
      }
    }
  }

  /* View Functions */
  function getDirectors()
  public view returns (address[]) {
      return directors;
  }

  function isConfirmed(uint transactionId)
  public view returns (bool)  {
    uint count = 0;
    for (uint i=0; i<directors.length; i++) {
      if (confirmations[transactionId][directors[i]])
        count += 1;
      if (count == required)
        return true;
    }
    return false;
  }

  function getCoopName()
  public view returns (string) {
    return name;
  }

  function getCoopMembers()
  public view returns (address[]) {
    return members;
  }

  function getCoopDescription()
  public view returns (string) {
    return description;
  }

  function getConfirmationCount(uint transactionId)
  public view returns (uint count) {
    for (uint i=0; i<directors.length; i++)
      if (confirmations[transactionId][directors[i]])
        count += 1;
  }

  function getTransactionCount(bool pending, bool executed)
  public view returns (uint count) {
    for (uint i=0; i<transactionCount; i++)
      if (pending && !transactions[i].executed
          || executed && transactions[i].executed)
          count += 1;
  }

}
