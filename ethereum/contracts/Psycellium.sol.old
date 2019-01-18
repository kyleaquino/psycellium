pragma solidity ^0.4.24;

contract Psycellium{
  event MemberRegistered(address indexed account);
  event MemberRemoval(address indexed account);
  event DirectorRegistered(address indexed account);
  event DirectorRemoval(address indexed account);
  event Confirmation(address indexed sender, uint indexed transactionId);
  event Revocation(address indexed sender, uint indexed transactionId);
  event Submission(uint indexed transactionId);
  event Execution(uint indexed transactionId);
  event ExecutionFailure(uint indexed transactionId);
  event Deposit(address indexed sender, uint amount);
  event RequirementChange(uint required);

  mapping (uint => Transaction) public transactions;
  mapping (uint => mapping (address => bool)) public confirmations;
  mapping (address => bool) public isDirector;
  mapping (address => bool) public isMember;
  mapping (address => uint) public balance;

  address[] public directors;
  address[] public members;
  uint public required;
  uint public transactionCount;
  string public coopName;
  string public coopDescription;
  uint256 public defaultJoinFee = 200000000000000000; // 25 USD

  struct Transaction {
    address destination;
    uint value;
    bytes data;
    bool executed;
  }

  modifier onlyWallet() {
    if (msg.sender != address(this))
        throw;
    _;
  }

  modifier directorExists(address director) {
    if (!isDirector[director])
      throw;
    _;
  }

  modifier memberExists(address member) {
    if (!isMember[member])
      throw;
    _;
  }

  modifier transactionExists(uint transactionId) {
    if (transactions[transactionId].destination == 0)
      throw;
    _;
  }

  modifier confirmed(uint transactionId, address director) {
    if (!confirmations[transactionId][director])
      throw;
    _;
  }

  modifier notConfirmed(uint transactionId, address director) {
    if (confirmations[transactionId][director])
      throw;
    _;
  }

  modifier notExecuted(uint transactionId) {
    if (transactions[transactionId].executed)
      throw;
    _;
  }

  modifier notNull(address _address) {
    if (_address == 0)
      throw;
    _;
  }

  constructor(bytes32 _coopname, bytes32 _coopdesc, uint _required)
    public
  {
    coopName = _coopname;
    description = _coopdesc;
    directors.push(msg.sender);
    isDirector[msg.sender] = true;
    DirectorRegistered(msg.sender)
  }

  function submitTransaction(address destination, uint value, bytes data)
    public
    returns (uint transactionId)
   {
     transactionId = addTransaction(destination, value, data);
     confirmTransaction(transactionId);
   }

  function confirmTransaction(uint transactionId)
    public
    directorExists(msg.sender)
    transactionExists(transactionId)
    notConfirmed(transactionId, msg.sender)
  {
    confirmations[transactionId][msg.sender] = true;
    Confirmation(msg.sender, transactionId);
    executeTransaction(transactionId);
  }

  function revokeConfirmation(uint transactionId)
    public
    directorExists(msg.sender)
    confirmed(transactionId, msg.sender)
    notExecuted(transactionId)
  {
    confirmations[transactionId][msg.sender] = false;
    Revocation(msg.sender, transactionId);
  }

  function executeTransaction(uint transactionId)
    public
    notExecuted(transactionId)
  {
    if (isConfirmed(transactionId)) {
      Transaction tx = transactions[transactionId];
      tx.executed = true;
      if (tx.destination.call.value(tx.value)(tx.data))
        Execution(transactionId);
      else {
        ExecutionFailure(transactionId);
        tx.executed = false;
      }
    }
  }

  function isConfirmed(uint transactionId)
    public
    constant
    returns (bool)
  {
    uint count = 0;
    for (uint i=0; i<directors.length; i++) {
      if (confirmations[transactionId][directors[i]])
        count += 1;
      if (count == required)
        return true;
    }
  }

  function addTransaction(address destination, uint value, bytes data)
    internal
    notNull(destination)
    returns (uint transactionId)
  {
    transactionId = transactionCount;
    transactions[transactionId] = Transaction({
      destination: destination,
      value: value,
      data: data,
      executed: false
    });
    transactionCount += 1;
    Submission(transactionId);
  }

  function setDirector(address account) public{
    directors.push(account)
    isDirector[msg.sender] = true;
    DirectorRegistered(msg.sender)
  }

  function join() payable public {
    require(msg.value == defaultJoinFee);
    members.push(msg.sender)
    isMember[msg.sender] = true;
    MemberRegistered(msg.sender)
  }

  function deposit(uint256 amount) payable
    public
    memberExists(msg.sender)
  {
    require(msg.value == amount);
    Deposit(address indexed sender, uint amount);
  }

  function withdraw(uint256 amount) public {
    msg.sender.transfer(amount);
  }

  function getCoopBalance() public view returns (uint256) {
    return address(this).balance;
  }

  function getConfirmationCount(uint transactionId)
    public
    constant
    returns (uint count)
  {
    for (uint i=0; i<directors.length; i++)
      if (confirmations[transactionId][directors[i]])
        count += 1;
  }

  function getTransactionCount(bool pending, bool executed)
    public
    constant
    returns (uint count)
  {
    for (uint i=0; i<transactionCount; i++)
      if (   pending && !transactions[i].executed
          || executed && transactions[i].executed)
          count += 1;
  }

  function getDirectors()
    public
    constant
    returns (address[])
  {
    return directors;
  }

  function getConfirmations(uint transactionId)
    public
    constant
    returns (address[] _confirmations)
  {
    address[] memory confirmationsTemp = new address[](directors.length);
    uint count = 0;
    uint i;
    for (i=0; i<directors.length; i++)
      if (confirmations[transactionId][directors[i]]) {
          confirmationsTemp[count] = directors[i];
          count += 1;
      }
      _confirmations = new address[](count);
      for (i=0; i<count; i++)
        _confirmations[i] = confirmationsTemp[i];
  }

  function getTransactionIds(uint from, uint to, bool pending, bool executed)
    public
    constant
    returns (uint[] _transactionIds)
  {
    uint[] memory transactionIdsTemp = new uint[](transactionCount);
    uint count = 0;
    uint i;
    for (i=0; i<transactionCount; i++)
        if (   pending && !transactions[i].executed
            || executed && transactions[i].executed)
        {
          transactionIdsTemp[count] = i;
          count += 1;
        }
        _transactionIds = new uint[](to - from);
        for (i=from; i<to; i++)
            _transactionIds[i - from] = transactionIdsTemp[i];
  }
}
