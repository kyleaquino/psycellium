import os
from web3 import Web3
from solc import compile_files, compile_source

def init():
    return Web3(Web3.HTTPProvider("http://127.0.0.1:8545", request_kwargs={'timeout': 60}))

def compile(dir,contract,contract_name):
    directory = dir+contract
    compiled_sol = compile_files([directory])
    return compiled_sol[directory+contract_name]

def contract(web3, ci_abi, ci_bytecode):
    return web3.eth.contract(abi=ci_abi, bytecode=ci_bytecode)

def tx_generate(contract, web3):
    tx_hash = contract.constructor().transact()
    tx_receipt = web3.eth.waitForTransactionReceipt(tx_hash)

    return tx_hash, tx_receipt

def contract_object(web3, tx_address, ci_abi):
    return web3.eth.contract(address=tx_address, abi=ci_abi)
