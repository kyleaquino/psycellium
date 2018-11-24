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
    members[msg.sender] = Member(name,roles.Member);
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

contract Transactions is Psycellium{

  enum State {APPROVED, PENDING, REJECTED};

  uint investID = 0;

  struct Loan{
    uint coopID;
    State state;
    uint amount;
    uint repaid;
    uint interest;
    string issueDate;
    string dueDate;
    bool isActive;
  }

  struct Investment{
    string issueDate;
    uint amount;
  }

  struct Ledger{
    string description;
    string date;
    uint balance;
  }

  struct Bank{
    uint coopID;
    mapping(uint => Ledger) public transactions;
  }

  struct HealthRecords{
    string lastUpdated;
    string record;
  }

  struct LandTitle{
    string landAddress;
    string landLocation;
    string landDescription;
    bool isOwned;
  }

  mapping(address => Loan) private loans; // One Loan is to One Account
  mapping(uint => Investment) private investments; // One Investment is to One Account

  mapping(uint => LandTitle) private Lands; // Get All Lands | Key: Uint | Value: Land Struct
  mapping (address => uint) private owner_land;    // Key: MemberAddress | Value: LandID
  mapping(uint => address) private land_owner; // Key: LandID | Value: MemberAddress

  function hasActiveLoan(address borrower) returns(bool){
    return loans[borrower].isActive;
  }

  function requestLoan(uint coopid, uint amount, uint interest){
    loans[borrower] = Loan(coopid, State.PENDING, amount, 0, interest, '-', '-', true);
  }

  function repayLoan(address borrower, uint repay){
    loans[borrower].amount = loans[borrower].amount - repay;
  }

  function cancelLoanRequest(address borrower)
  public{
    loans[borrower].isActive = False;
  }

  function approveLoan(address borrower)
  public {
    // Treasurer is the approver
    /* require(members[msg.sender].role == roles.Treasurer);
    require(!loans[borrower].isApproved, "Already Approved"); */
    loans[borrower].state = State.APPROVED;
  }

  function rejectLoan()
  public {
    /* require(members[msg.sender].role == roles.Treasurer);
    require(loans[borrower].isApproved, "Already Rejected"); */
    loans[borrower].state = State.REJECTED;
    loans[borrower].isActive = false;
  }

  function grantInvestment(uint id, address grantee)
  public{

  }

  function createLand(string landAddress, string landAddress, string landLocation, string landDescription, bool isOwned)
  private {
    landID++;
    uint id = landID;
    Lands[id] = LandTitle(landAddress, landAddress, landLocation, landDescription, issueddate, false);
  }

  function getLands(uint landid)
  public view returns(LandTitle){
    // TODO Require Function
    return lands[landid];
  }

  function setOwnership(address _member, uint _landid)
  private {
    /* require(!Lands[_landid].isOwned, "Already Owned"); */
    land_owner[_landid] = _member;
    Lands[_landid].isOwned = True;
  }

  function getOwner(uint _landid)
  public view returns(address){
    /* require(Lands[_landid], "Not Owned"); */
    return land_owner[_landid];
  }

  function getLandOwned(address _member)
  public view returns(LandTitle){
    /* require(owner_land[_member] != 0, "Doesn't Own a Land"); */
    return lands[owner_land[_member]];
  }

  // Bank Ledger Logics
  mapping(uint => BankLedger) private bankLedgers; // Get All BankLedger | Key: Uint | Value: BankLedger Struct

  mapping(address => uint) private bankAccount; // Key: MemberAddress | Value: BankID
  mapping(uint => address) private bankOwner; // Key: BankID | Value: MemberAddress

  mapping(address => Investment) private debit; // Key: MemberAddress | Value: Investment struct
  mapping(address => Loan) private credit; // Key: MemberAddress | Value: Loan struct

  function setBankAccount(string _desc, string _date, uint _bal)
  private {
    bankID++;
    uint id = bankID;
    /* require(!bankAccount[msg.sender], "Already have an account"); */
    bankLedgers[bankID] = BankLedger(msg.sender, _desc, _date, _bal);
  }

  function addBalance(address _member, string _desc, string _date)
  private {
    /* require(!debit[_member].isApproved, "Not Approved"); */
    uint bankid = bankAccount[_member];
    uint bal = bankLedgers[bankid].balance;
    uint balDebit = debit[_member].amount;
    uint newBal = bal + balDebit;

    bankLedgers[bankid] = BankLedger(_member, _desc, _date, newBal);
  }

  function deductBalance(address _member, string _desc, string _date)
  private {
    /* require(!credit[_member].isApproved, "Not Approved"); */
    uint bankid = bankAccount[_member];
    uint bal = bankLedgers[bankid].balance;
    uint balCredit = credit[_member].amount;
    uint newBal = bal - balCredit;

    bankLedgers[bankid] = BankLedger(_member, _desc, _date, newBal);
  }

  function getBankAccount()
  public returns(BankLedger){
    return bankLedgers[bankAccount[msg.sender]];
  }

}
