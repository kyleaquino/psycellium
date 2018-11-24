pragma solidity ^0.4.23;

contract Member {

  /* Identities for Blockchain Cooperatives */
  enum CoopRoles { Member, Staff, Director, President, Manager, Secretary, Auditor, Treasurer }

  struct User {
    /* Unique Identifier for Users */
    uint id;
    string name;
  }

  struct Membership {
    /* Unique Identifier for Coop Members */
    uint id;
    bytes32 userID;
    bytes32 coopID;
    string issuedDate;
    string expirationDate;
    string approvedBy;
    bool isApproved;
  }

  struct Cooperative {
    /* Unique Identifier for Cooperative */
    uint id;
    string coopName;
    string coopDescription;
    string issuedDate;
    bytes32[] createdby;
  }

  struct CoopMemberRoles{
    uint id;
    bytes32 memberID;
    bytes32 coopID;
    CoopRoles roles;
    string issuedDate;
    string expirationDate;
  }

  /* Entity ID Initializers */
  uint userID = 0;
  uint coopID = 0;
  uint memberID = 0;
  uint roleID = 0;

  /* Entity Lists */
  mapping(uint256 => address) public userList;
  // mapping uint256 address
  mapping(address => Cooperative) public coopList;
  mapping(address => Membership) public memberList;
  mapping(address => CoopMemberRoles) public roleList;

  /* Events */
  event SetUser(uint _id);
  event SetCoop(uint _id);

  /* Contract Functions */
  function setUser(string _id) public {
    require(userList[_id] != msg.sender); //
    userList[msg.sender] = User(id, _name);
    emit SetUser(id);
  }

  function setCoop(address _coopAddress, string _coopname, string _coopdesc, string _issuedDate, bytes32[] _createdby) public {
    uint id = coopID++;
    coopList[_coopAddress] = Cooperative(id, _coopname, _coopdesc, _issuedDate, _createdby);
    emit SetCoop(id);
  }

  function verifyUser() public {
    /* Verify (return boolean if user is existing) or get User Name via user address */
  }

  function verifyCoop() public {
    /* Verify (return boolean if user is existing) or get User Name via user address */
  }

  function addMember() public {
    /* Only Add to coop if user have contributed X Ether */
  }

  function totalUsers() public returns(uint256){

  }
}


contract MemberFactory{

}
