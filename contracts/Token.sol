//SPDX-License-Identifier: UNLICENSED
/*
**Important!**

Token detection is currently not available on the Sepolia network. Therefore, we need your Token Contract Address to receive your token.
After successfully deploying your token, please provide the following details below to ensure you receive full credit for your assignment:

- **Token Contract Address**: 0xb875E55b438b0DaF97efCE1cA77E4fdBCC4b1dE7
- **Your Name**: Benjamin Wong
- **Your Student Number**: A0257989X

Thank you for your attention to this requirement.
*/

pragma solidity ^0.8.28;

contract Token {

    /* As discussed in the lecture, tokens typically include metadata such as name, symbol, 
     * decimals (precision of the token), and total supply. Define functions to retrieve
     * these properties and initialize them in the constructor.
     * Suggested functions: name(), symbol(), decimals(), totalSupply().
     * Feel free to add additional properties as needed.
     */
    /// Your code starts here ///
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    
    // Balances and allowances mapping
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    /// Your code ends here ///

    /* Define events for Transfer and Approval. These events are critical for tracking token movements
     * and approvals on the blockchain. Emit these events in the respective functions.
     */
    
    /// Define Transfer event: emitted when tokens are transferred.
    /// Define Approval event: emitted whenever approved is called.
    /// Your code starts here ///
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    /// Your code ends here ///
 
    /**
     * Constructor function is used to initialize the contract state, including setting the
     * initial supply of tokens, etc.
     */
    constructor() {
        /// Initialize token metadata and assign the initial token supply.
        /// Your code starts here ///
        _name = "4211_WongHaoXueBenjamin_E0968961";
        _symbol = "4211WHXBE0968961";
        _decimals = 18;
        _totalSupply = 1000000 * 10**uint256(_decimals); // 1 million tokens
        
        // Assign the total supply to the contract deployer
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
        /// Your code ends here ///
    }

    /**
     * Returns the name of the token.
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * Returns the symbol of the token.
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * Returns the number of decimal places used by the token.
     */
    function decimals() external view returns (uint8) {
        return _decimals;
    }

    /**
     * Returns the total supply of the token.
     * Ensure this function reflects the current total token supply.
     */
    function totalSupply() external view returns (uint256) {
        /// Implement logic to return the total supply.
        /// Your code starts here ///
        return _totalSupply;
        /// Your code ends here ///
    }

    /**
     * Returns the balance of a specific address.
     * @param account The address to query the balance of.
     */
    function balanceOf(address account) external view returns (uint256) {
        /// Implement logic to return the balance of the given address.
        /// Your code starts here ///
        return _balances[account];
        /// Your code ends here ///
    }

    /**
     * Transfers tokens to a specific address.
     * Returns a boolean indicating whether the operation was successful.
     * @param to The address to transfer tokens to.
     * @param amount The amount of tokens to transfer.
     */
    function transfer(address to, uint256 amount) external returns (bool) {
        /// Implement logic for transferring tokens, including updating balances
        /// Your code starts here ///
        require(to != address(0), "Transfer to the zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
        /// Your code ends here ///
    }

    /**
     * Transfers tokens on behalf of another address (requires prior approval).
     * Returns a boolean indicating whether the operation was successful.
     * @param from The address to transfer tokens from.
     * @param to The address to transfer tokens to.
     * @param amount The amount of tokens to transfer.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        /// Implement logic for transferring tokens on behalf of another address,
        /// Your code starts here ///
        require(from != address(0), "Transfer from the zero address");
        require(to != address(0), "Transfer to the zero address");
        require(_balances[from] >= amount, "Insufficient balance");
        require(_allowances[from][msg.sender] >= amount, "Insufficient allowance");

        _balances[from] -= amount;
        _balances[to] += amount;

        // Reduce allowance unless it is set to unlimited
        if (_allowances[from][msg.sender] != type(uint256).max) {
            _allowances[from][msg.sender] -= amount;
        }

        emit Transfer(from, to, amount);
        return true;
        /// Your code ends here ///
    }

    /**
     * Approves another address to spend tokens on the caller's behalf.
     * Returns a boolean indicating whether the operation was successful.
     * @param spender The address to be approved.
     * @param amount The amount of tokens to approve.
     */
    function approve(address spender, uint256 amount) external returns (bool) {
        /// Implement logic to set the allowance for the spender
        /// Your code starts here ///
        require(spender != address(0), "Approve to the zero address");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
        /// Your code ends here ///
    }

    /**
     * Returns the remaining number of tokens that a spender is allowed to spend on behalf of the owner.
     * @param _owner The owner of the tokens.
     * @param spender The address approved to spend the tokens.
     */
    function allowance(address _owner, address spender) external view returns (uint256) {
        /// Implement logic to return the current allowance for the spender.
        /// Your code starts here ///
        return _allowances[_owner][spender];
        /// Your code ends here ///
    }
}
