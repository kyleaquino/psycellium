import oracle as web3

ETH_DIR = './../../ethereum/contracts/'
contract_file = 'Psycellium.sol'
contract_name = ':Psycellium'

def setMember(members,coopid):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    psycellium.functions.setMember(members,coopid).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

# setMember(['0xeCDB33423EEb354aDE809a17c53D1325626c5219','0xa8Bd814a4a325d0092416Ac7574fFb5868899B9e'],1)

def setMemberName(name):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    psycellium.functions.setMemberName(name).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

# setMemberName('John')

def createCoop(coopaddress, director, coopdesc, issuedate):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    psycellium.functions.createCoop((coopaddress, director, coopdesc, issuedate).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

# createCoop('0xeCDB33423EEb354aDE809a17c53D1325626c5219', '0xa8Bd814a4a325d0092416Ac7574fFb5868899B9e', 'DESC', '2018-10-10')

def getCoopAddress(coopid):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    result = psycellium.functions.getCoopAddress(coopid).call()

    print(w3.eth.waitForTransactionReceipt(tx_hash))
    print(result)

# getCoopAddress(1)

def getMembers(coopid):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    result = psycellium.functions.getMembers(coopid).call()

    print(w3.eth.waitForTransactionReceipt(tx_hash))
    print(result)

# getMembers(1)
def isCoopMember(userid):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    result = psycellium.functions.isCoopMember(userid).call()

    print(w3.eth.waitForTransactionReceipt(tx_hash))
    print(result)

def setBoardOfDirectors(directors, coopid):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    psycellium.functions.setBoardOfDirectors(directors,coopid).transact()

    print(w3.eth.waitForTransactionReceipt(tx_hash))

def getBoardOfDirectors(coopid):
    w3 = web3.init()
    w3.eth.defaultAccount = w3.eth.accounts[0]
    interface = web3.compile(ETH_DIR,contract_file,contract_name)
    contract = web3.contract(w3, interface['abi'], interface['bin'])
    tx_hash, tx_receipt = web3.tx_generate(contract, w3)
    psycellium = web3.contract_object(w3, tx_receipt.contractAddress,interface['abi'])

    result = psycellium.functions.getBoardOfDirectors(coopid).call()

    print(w3.eth.waitForTransactionReceipt(tx_hash))
    print(result)
