contract User{
  struct data{
    string username;
    bool isExisting;
  }
}

contract Cooperative{
  enum CoopRoles { Member, Staff, Director, President, Manager, Secretary, Auditor, Treasurer }

  struct data{
    string coopName;
    string coopDescription;
    string issuedDate;
    address[] createdby;
  }

  struct Membership {
    address coopID;
    string issuedDate;
    address approvedBy;
  }

  struct Roles{
    bytes32 memberID;
    bytes32 coopID;
    CoopRoles roles;
    string issuedDate;
    string expirationDate;
  }
}

contract UserFactory{
  mapping(uint256 => User) public users;

  /* Events */
  event CreateUser(address _id);

  function CreateUser(string _username) public {
    address _id = msg.sender
    require(VerifyUser(_id)); //
    users[_id] = users.User(_username, true);
    emit CeateUser(id);
  }

  function VerifyUser(address _id) returns (bool){
    if(users[id].isExisting) throw;
    return true;
  }
}

contract CoopFactory{
  mapping(uint256 => Cooperative) public coops;

  /* Events */
  event CreateCoop(address _id);

  /* Functions */
  function CreateCoop(string _username) public {
    address _id = msg.sender
    require(users[_id] != userList[_id]); //
    userList[_id] = User(_username, true);
    emit SetUser(id);
  }

  function addMember(address _userid, address _coopid, string _issuedate, address _approvedBy){
    bytes32 userID;
    bytes32 coopID;
    string issuedDate;
  }

  function assignRole(){

  }

  function VerifyMember(){

  }

  function VerifyCoop(address _id) returns (bool){
    if(users[id].isExisting) throw;
    return true;
  }

}
