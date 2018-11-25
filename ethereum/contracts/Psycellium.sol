pragma solidity ^0.4.24;

contract Psycellium{
  enum roles { Member, Staff, Director, President, Manager, Secretary, Auditor, Treasurer }

  uint private coopID;
  uint private landID;
  uint private bankID;

  struct Cooperative{
    string coopAddress;
    address[] director;
    string coopName;
    string coopDescription;
    string issuedDate;
    bool isExisting;
    // Capital
  }

  struct Member{
    string name;
    bool isActive;
    roles role;
  }

  mapping (address => Member) private members; // Get all members | Key: Address | Value: Member Struct [name, isActive, role]
  mapping (uint => Cooperative) private coops; // Get all Coops | Key: Uint | Value: Cooperative Struct []

  mapping (uint => address[]) private coop_members; // Key: CoopID | Value: MemberAddresses
  mapping (address => uint) private member_coop;    // Key: MemberAddress | Value: CoopID

  function setMemberName(string name) // Set Name, Make issued date 'NA', true
  public {
    members[msg.sender] = Member(name, true, roles.Member);
  }

  function setMember(address[] _members, uint _coopid)
  public {
    coop_members[_coopid] = _members;
  }

  function createCoop(string coopaddress, address[] director ,string coopname, string coopdesc, string issueddate)
  public {
    coopID++;
    uint id = coopID;
    coops[id] = Cooperative(coopaddress, director, coopname, coopdesc, issueddate, true);
  }

  function setBoardOfDirectors(address[] directors, uint coopid )
  public {
    coops[coopid].director = directors;
  }

  function getCoopAddress(uint coopid)
  public view returns (string){
    return coops[coopid].coopAddress;
  }

  function getMembers(uint coopid)
  public view returns(address[]){ // TODO Require Function
    return coop_members[coopid];
  }

  function isCoopMember(address userid)
  public view returns(bool){
    if(member_coop[userid] == 0){
      return false;
    }
    return true;
  }

  function getBoardOfDirectors(uint coopid)
  public view returns (address[]){
    return coops[coopid].director;
  }
}
