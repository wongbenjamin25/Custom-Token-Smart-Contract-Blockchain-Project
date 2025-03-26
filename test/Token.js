const { expect } = require("chai");

describe("Token contract", function () {
    
    // Test case 1: Ensure total supply is assigned to the owner upon deployment
    it("Deployment should assign the total supply of tokens to the owner", async function () {
        const [owner] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Get the owner's token balance
        const ownerBalance = await hardhatToken.balanceOf(owner.address);

        // Check that the owner's balance equals the total supply
        expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    });
        

    // Test case 2: Test token transfer functionality
    it("Should transfer tokens between accounts", async function () {
        const [owner, addr1, addr2] = await ethers.getSigners(); // Get wallet addresses

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Transfer 50 tokens from the owner to addr1
        await hardhatToken.transfer(addr1.address, 50);
        expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);

        // Transfer 50 tokens from addr1 to addr2
        await hardhatToken.connect(addr1).transfer(addr2.address, 50);
        expect(await hardhatToken.balanceOf(addr2.address)).to.equal(50);
    });

    // Test case 3: Test approval and allowance functionality
    it("Should correctly handle token approvals and allowances", async function () {
        const [owner, spender] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Approve spender to spend 100 tokens on behalf of the owner
        await hardhatToken.approve(spender.address, 100);
        const allowance = await hardhatToken.allowance(owner.address, spender.address);
        expect(allowance).to.equal(100);

        // Ensure spender cannot exceed allowance
        await expect(hardhatToken.connect(spender).transferFrom(owner.address, spender.address, 150))
            .to.be.revertedWith("Insufficient allowance");

        // Spend within allowance and check balances
        await hardhatToken.connect(spender).transferFrom(owner.address, spender.address, 100);
        expect(await hardhatToken.balanceOf(spender.address)).to.equal(100);
    });

    // Test case 4: Test for insufficient balance during transfers
    it("Should fail if sender does not have enough balance", async function () {
        const [owner, addr1] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Attempt to transfer more tokens than available
        const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);
        await expect(hardhatToken.connect(addr1).transfer(owner.address, 1))
            .to.be.revertedWith("Insufficient balance");

        // Owner balance should remain unchanged
        expect(await hardhatToken.balanceOf(owner.address)).to.equal(initialOwnerBalance);
    });

    // Test case 5: Verify events for Transfer and Approval
    it("Should emit Transfer and Approval events", async function () {
        const [owner, addr1] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Test Transfer event
        await expect(hardhatToken.transfer(addr1.address, 50))
            .to.emit(hardhatToken, "Transfer")
            .withArgs(owner.address, addr1.address, 50);

        // Test Approval event
        await expect(hardhatToken.approve(addr1.address, 100))
            .to.emit(hardhatToken, "Approval")
            .withArgs(owner.address, addr1.address, 100);
    });

    // Test case 6: Test transfer to zero address
    it("Should fail when transferring tokens to the zero address", async function () {
        const [owner] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Attempt to transfer tokens to zero address
        await expect(hardhatToken.transfer("0x0000000000000000000000000000000000000000", 50))
            .to.be.revertedWith("Transfer to the zero address");
    });

    // Test case 7: Test approve to zero address
    it("Should fail when approving tokens for the zero address", async function () {
        const [owner] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Attempt to approve zero address
        await expect(hardhatToken.approve("0x0000000000000000000000000000000000000000", 50))
            .to.be.revertedWith("Approve to the zero address");
    });

    // Test case 8: Check if total supply remains constant
    it("Should maintain the total supply after transfers", async function () {
        const [owner, addr1] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Record initial total supply
        const initialTotalSupply = await hardhatToken.totalSupply();

        // Perform transfers
        await hardhatToken.transfer(addr1.address, 50);
        await hardhatToken.transfer(owner.address, 50);

        // Ensure total supply remains unchanged
        expect(await hardhatToken.totalSupply()).to.equal(initialTotalSupply);
    });

    // Test case 9: Test re-approval and overwrite of allowance
    it("Should overwrite existing allowance when re-approving", async function () {
        const [owner, spender] = await ethers.getSigners();

        // Deploy the Token contract
        const hardhatToken = await ethers.deployContract("Token");

        // Approve spender for 100 tokens
        await hardhatToken.approve(spender.address, 100);
        expect(await hardhatToken.allowance(owner.address, spender.address)).to.equal(100);

        // Re-approve spender for 50 tokens
        await hardhatToken.approve(spender.address, 50);
        expect(await hardhatToken.allowance(owner.address, spender.address)).to.equal(50);
    });
        
});
