
contract Transactions {

  enum State {APPROVED, PENDING, REJECTED}

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
    mapping (address => Grantee) grantees;
  }

  struct Grantee{
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
    address coopAddress;
    uint txnCounter;
    mapping(uint => Ledger) transactions;
  }

  mapping(address => Loan) private loans;
  mapping(address => Investment) private investments;
  mapping(address => Bank) private accounts;

  function hasActiveLoan(address borrower)
  public view returns(bool)
  {
    return loans[borrower].isActive;
  }

  function getAmount(address borrower)
  public view returns(uint)
  {
    return loans[borrower].amount;
  }

  function requestLoan(address borrower, uint coopid, uint amount, uint interest)
  public {
    loans[borrower] = Loan(coopid, State.PENDING, amount, 0, interest, "-", "-", true);
  }

  function repayLoan(address borrower, uint repay)
  public {
    loans[borrower].amount = loans[borrower].amount - repay;
  }

  function cancelLoanRequest(address borrower)
  public {
    loans[borrower].isActive = false;
  }

  function approveLoan(address borrower)
  public {
    // Treasurer is the approver
    /* require(members[msg.sender].role == roles.Treasurer);
    require(!loans[borrower].isApproved, "Already Approved"); */
    loans[borrower].state = State.APPROVED;
  }

  function rejectLoan(address borrower)
  public {
    /* require(members[msg.sender].role == roles.Treasurer);
    require(loans[borrower].isApproved, "Already Rejected"); */
    loans[borrower].state = State.REJECTED;
    loans[borrower].isActive = false;
  }

  function grantInvestment(address guarrantor ,address grantee, string issuedate, uint amt)
  public view returns (uint){
    investments[guarrantor].grantees[grantee].issueDate = issuedate;
    investments[guarrantor].grantees[grantee].amount = amt;

    return investments[guarrantor].grantees[grantee].amount;
  }

  function createBankAccount(uint coopid, address coopaddress, address user)
  public view returns (uint){
    /* require(!bankAccount[msg.sender], "Already have an account"); */
    accounts[user].coopID = coopid;
    accounts[user].coopAddress = coopaddress;

    return accounts[user].coopID;
  }

  function credit(address user, string desc, string date, uint credited )
  public view returns (uint){
    accounts[user].txnCounter++;
    uint txn = accounts[user].txnCounter;
    accounts[user].transactions[txn].description = desc;
    accounts[user].transactions[txn].date = date;
    accounts[user].transactions[txn].balance += credited;

    return accounts[user].transactions[txn].balance;
  }

  function debit(address user, string desc, string date, uint debited )
  public view returns (uint) {
    accounts[user].txnCounter++;
    uint txn = accounts[user].txnCounter;
    accounts[user].transactions[txn].description = desc;
    accounts[user].transactions[txn].date = date;
    accounts[user].transactions[txn].balance += debited;

    return accounts[user].transactions[txn].balance;
  }
}
