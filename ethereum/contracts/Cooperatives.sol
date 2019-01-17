pragma solidity ^0.4.24;

contract Cooperatives {
  /* EVENTS */
  event MemberRegistered(address indexed account);
  event MemberRemoval(address indexed account);
  event DirectorRegistered(address indexed account);
  event DirectorRemoval(address indexed account);
  event Deposit(address indexed sender, uint amount);
  event Withdraw(address indexed sender, uint amount);

  /* PUBLIC DATA */
  string public name;
  string public description;
  address[] public members;
  address[] public directors;
  uint public totalBalance;
  uint public transactionCount;
  uint256 public defaultJoinFee = 200000000000000000; // 25 USD

  mapping (uint => Transaction) public transactions;
  mapping (address => bool) public isDirector;
  mapping (address => bool) public isMember;
  mapping (address => uint) public balance;

  /* MODIFIERS */
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

  modifier notNull(address _address) {
    if (_address == 0)
      throw;
    _;
  }

  /* Sets the contract deployer as the director and a member temporarily */
  constructor(bytes32 _name, bytes32 _desc)
  public
  {
    name = _name;
    description = _desc;
    directors.push(msg.sender);
    isDirector[msg.sender] = true;
    DirectorRegistered(msg.sender)
    members.push(msg.sender);
    isMember[msg.sender] = true;
    MemberRegistered(msg.sender);
  }

  function joinCoop() payable
  public
  {
    require(msg.value == defaultJoinFee);
    members.push(msg.sender)
    isMember[msg.sender] = true;
    MemberRegistered(msg.sender)
  }

  function setDirector(address member)
  public
  directorExists(msg.sender)
  memberExists(member)
  {
    directors.push(member)
    isDirector[member] = true;
    DirectorRegistered(member)
  }

  function deposit(uint amount) payable
  public
  memberExists(msg.sender)
  {
    require(msg.value == amount);
    balance[msg.sender] += amount;
    totalBalance += amount
    Deposit(msg.sender, amount)
  }

  function withdraw(uint amount)
  public
  memberExists(msg.sender)
  {
    require(msg.value == amount);
    require(balance[msg.sender] >= amount);
    require(totalBalance >= amount);
    msg.sender.transfer(amount);
    balance[msg.sender] -= amount
    totalBalance -= amount
    Withdraw(msg.sender, amount)
  }

  /* View Functions */
  function getCoopName()
  public view returns (string)
  {
    return name;
  }

  function getCoopMembers()
  public view returns (address[])
  {
    return members;
  }

  function getCoopDescription()
  public view returns (string)
  {
    return description;
  }

  function getCoopBalance()
  public view returns (uint)
  {
    return totalBalance;
  }

}
