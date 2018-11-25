const Psycellium = artifacts.require('../contracts/Psycellium.sol')
const Transactions = artifacts.require('../contracts/Transactions.sol')
// const Contract = artifacts.require('../contracts/Psycellium')

contract('Psycellium', ([owner]) => {
    let psycellium
    let res 

    beforeEach('Create Contract for each test', async function () {
        psycellium = await Psycellium.new(owner)
    })

    it('Set Member Name', async () => {
        await psycellium.setMemberName('Test')
    })

    it('Create Coop', async () => {
        await psycellium.createCoop(
            'Custom Coop Address', 
            ['0x35B7089F214E002991B87799c203562Da9443047'],
            'Custom Coop Name',
            'Custom Coop Desc',
            '2018-11-24'
        )

        await psycellium.setMember(['0x35B7089F214E002991B87799c203562Da9443047'], 1)

        // const isCoopMember = await psycellium.isCoopMember(['0x75b84042f41e044278667011292CA04C59267aB7'])

        // assert.isTrue(isCoopMember)
    })

    it('Set Member to Coop', async () => {
        await psycellium.setMember(['0x35B7089F214E002991B87799c203562Da9443047'], 1)
    })

    it('Check Member if Coop Member', async () => {
        await psycellium.setMemberName('Test')
        await psycellium.createCoop(
            'Custom Coop Address', 
            ['0x35B7089F214E002991B87799c203562Da9443047'],
            'Custom Coop Name',
            'Custom Coop Desc',
            '2018-11-24'
        )

        await psycellium.setMember(['0x35B7089F214E002991B87799c203562Da9443047'], 1)

        res = await psycellium.isCoopMember(['0x35B7089F214E002991B87799c203562Da9443047'])
        // console.log('Check:', res)
    })

    it('Get Board of Directors', async () => {
        await psycellium.createCoop(
            'Custom Coop Address', 
            ['0x35B7089F214E002991B87799c203562Da9443047'],
            'Custom Coop Name',
            'Custom Coop Desc',
            '2018-11-24'
        )

        await psycellium.setBoardOfDirectors(['0x35B7089F214E002991B87799c203562Da9443047'], 1)
        
        res = await psycellium.getBoardOfDirectors(1)

        // console.log('BOD:', res)
    })

    it('Get Members', async () => {
        await psycellium.createCoop(
            'Custom Coop Address', 
            ['0x35B7089F214E002991B87799c203562Da9443047'],
            'Custom Coop Name',
            'Custom Coop Desc',
            '2018-11-24'
        )

        await psycellium.setMember(['0x35B7089F214E002991B87799c203562Da9443047'], 1)

        res = await psycellium.getMembers(1)

        // console.log('Members:', res)
    })

    it('Get Coop Address', async () => {
        await psycellium.createCoop(
            'Custom Coop Address', 
            ['0x35B7089F214E002991B87799c203562Da9443047'],
            'Custom Coop Name',
            'Custom Coop Desc',
            '2018-11-24'
        )

        res = await psycellium.getCoopAddress(1)

        // console.log('Coop Address:', res)
    })
})

contract('Transactions', ([owner]) => {
    let psycellium
    let transactions
    let res 

    let add = '0x35B7089F214E002991B87799c203562Da9443047'
    let coopadd = '0x07F9efA10C6003d11D7D8a2adcF46907ECdB8039'
    let coopid = 1
    let amount = 100
    let interest = 0

    beforeEach('Create Contract for each test', async function () {
        transactions = await Transactions.new(owner)
    })

    it('Request and Approve Loan', async () => {
        await transactions.requestLoan(add, coopid, amount, interest)
        await transactions.approveLoan(add)
        const hasLoan = await transactions.hasActiveLoan(add)

        assert.isTrue(hasLoan)
    })

    it('Request and Reject Loan', async () => {
        await transactions.requestLoan(add, coopid, amount, interest)
        await transactions.rejectLoan(add)
        const hasLoan = await transactions.hasActiveLoan(add)

        assert.isTrue(!hasLoan)
    })

    it('Repay Loan', async () => {
        await transactions.requestLoan(add, coopid, amount, interest)
        await transactions.approveLoan(add)
        await transactions.repayLoan(add, 50)
        const amount2 = await transactions.getAmount(add)
        const hasLoan = await transactions.hasActiveLoan(add)

        // console.log(amount2['c'])
        assert.isTrue(hasLoan)
    })

    it('Cancel Loan', async () => {
        await transactions.requestLoan(add, coopid, amount, interest)
        await transactions.cancelLoanRequest(add)
        const hasLoan = await transactions.hasActiveLoan(add)

        assert.isTrue(!hasLoan)
    })

    it('Grant Investment', async () => {
        const credit = await transactions.credit(coopadd, add, '2018-11-25', 1000)

        assert.equal(credit, 1000)
    })

    it('Create Bank Account', async () => {
        const credit = await transactions.createBankAccount(1, coopadd, add)

        assert.equal(credit, 1)
    })

    it('Credit', async () => {
        const credit = await transactions.credit(add, 'This is a description', '2018-11-25', 1000)

        assert.equal(credit, 1000)
    })

    it('Debit', async () => {
        const credit = await transactions.debit(add, 'This is a description', '2018-11-25', 1000)

        assert.equal(credit, 1000)
    })
})