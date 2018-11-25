import web3

ETH_DIR = './../../ethereum/contracts/'
contract_file = 'Transactions.sol'
contract_name = ':Transactions'

def hasActiveLoan(borrower):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    result = transactions.functions.hasActiveLoan(borrower).call()

    print(w3.eth.waitForTransactionReceipt(tx_hash))
    print(result)

def requestLoan(borrower,coopid, amounts, interest):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.requestLoan(borrower,coopid, amounts, interest).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

def repayLoan(borrower, repay):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.repayLoan(borrower, repay).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

def cancelLoadRequest(borrower):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.cancelLoadRequest(borrower).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

def approveLoan(borrower):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.approveLoan(borrower).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

def rejectLoan(borrower):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.rejectLoan(borrower).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

def grantInvestment(guarantor, grantee, issuedata, amt):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.grantInvestment(guarantor, grantee, issuedata, amt).transact()

    # result = transactions.functions.grantInvestment(guarantor, grantee, issuedata, amt).call()
    print(w3.eth.waitForTransactionReceipt(tx_hash))
    # print(result)

grantInvestment('0xeCDB33423EEb354aDE809a17c53D1325626c5219', '0xa8Bd814a4a325d0092416Ac7574fFb5868899B9e', '2015-08-19', 100)

def createBankAccount(coopid, coopaddress, user):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.createBankAccount(coopid, coopaddress, user).transact()

    # result = transactions.functions.createBankAccount(coopid, coopaddress, user).call()
    print(w3.eth.waitForTransactionReceipt(tx_hash))
    # print(result)

def credit(user, desc, date, credited):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.credit(user, desc, date, credited).transact()

    # result = transactions.functions.credit(user, desc, date, credited).call()
    print(w3.eth.waitForTransactionReceipt(tx_hash))
    # print(result)

def debit(user, desc, date, debited):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    transactions = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    transactions.functions.debit(user, desc, date, debited).transact()

    # result = transactions.functions.debit(user, desc, date, debited).call()
    print(w3.eth.waitForTransactionReceipt(tx_hash))
    # print(result)
