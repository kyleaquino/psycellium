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
    address createdby;
    bool isExisting;
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
  mapping(address => User) public users;

  /* Events */
  event CreateUser(address _id);

  function CreateUser(string _username) public {
    address _id = msg.sender
    require(VerifyUser(_id) != true);
    users[_id] = User(_username, true);
    emit CeateUser(id);
  }

  function VerifyUser(address _id) returns (bool){
    if(users[id].isExisting) throw;
    return true;
  }
}

contract CoopFactory{
  mapping(address => Cooperative) public coops;

  /* Events */
  event CreateCoop(address _id);

  /* Functions */
  function CreateCoop(address _coopid, string _coopname, string _coopdesc, string _issueddate) public {
    address _userid = msg.sender
    require(VerifyCoop(_id) != true);
    coops[_coopid] = Cooperative(_coopname, _coopdesc, _issueddate, _userid, true);
    emit SetUser(id);
  }

  function addMember(address _userid, address _coopid, string _issuedate, address _approvedBy){
  }

  function assignRole(){
    function VerifyUser(address _id) returns (bool){
      if(users[id].isExisting) throw;
      return true;
    }
  }

  function VerifyMember(){
    function VerifyUser(address _id) returns (bool){
      if(users[id].isExisting) throw;
      return true;
    }
  }

  function VerifyCoop(address _id) returns (bool){
    if(coops[id].isExisting) throw;
    return true;
  }

}
