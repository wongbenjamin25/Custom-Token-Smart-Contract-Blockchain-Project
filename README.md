# Custom Token Smart Contract & Blockchain Project

This project was developed as part of the QF4211 / DSE4211 Digital Currencies module at NUS. It combines a hands-on implementation of a blockchain and a custom ERC-20-style token smart contract.

## What I Built

### 1. Custom Blockchain (Python)
- Created a basic blockchain from scratch using Python.
- Implemented key features:
  - Block and transaction structure
  - Proof-of-Work (PoW) consensus mechanism
  - Hashing, nonces, and block validation
  - Mining and peer-to-peer communication simulation
- Built a simple Flask web interface to interact with the blockchain (mine blocks, view chain, send transactions).

### 2. Custom Token Smart Contract (Solidity + Hardhat)
- Developed an ERC-20-like token smart contract using Solidity.
- Deployed and tested the token using the Hardhat development framework.
- Key features:
  - Token minting and initial supply
  - Transfer of tokens between addresses
  - Balance tracking and event emission

### 3. Blockchain Explorer UI (Flask)
- Designed a lightweight frontend using Flask templates.
- Enabled user interaction with blockchain: mining, submitting transactions, and viewing token balances and block info.

## Technologies Used
- Python, Flask
- Solidity, Hardhat
- Web3.js (optional frontend interactions)
- JavaScript, HTML/CSS (for UI)

## Learning Outcomes
- Deepened understanding of blockchain mechanics and smart contract development.
- Gained practical experience in:
  - Building decentralized systems
  - Handling cryptographic hashing and nonce mining
  - Writing, deploying, and testing smart contracts
- Bridged blockchain backend logic with frontend interactions for a full-stack decentralized app.

## Project Structure

Custom-Token-Smart-Contract-Blockchain-Project/
│
├── blockchain/                  # Python-based blockchain implementation
│   ├── blockchain.py            # Core blockchain logic (blocks, mining, PoW)
│   ├── transaction.py           # Transaction class/structure
│   ├── node.py                  # API server using Flask
│   ├── utils.py                 # Helper functions (hashing, validation, etc.)
│   └── requirements.txt         # Python dependencies
│
├── flask-ui/                    # Simple frontend for blockchain interaction
│   ├── templates/
│   │   └── index.html           # Main UI page
│   ├── static/
│   │   └── style.css            # Optional styling
│   └── app.py                   # Flask app to render the UI
│
├── smart-contract/              # Hardhat-based Solidity smart contract
│   ├── contracts/
│   │   └── CustomToken.sol      # ERC-20-style token contract
│   ├── scripts/
│   │   └── deploy.js            # Deployment script
│   ├── test/
│   │   └── token.test.js        # Test cases for the token
│   ├── hardhat.config.js        # Hardhat configuration
│   └── package.json             # Node.js project manifest
│
├── .gitignore                   # Ignore compiled files, venvs, etc.
└── README.md                    # Project documentation

## How to Run

You can set up and run each component locally:

### Blockchain (Python)
```bash
cd blockchain
pip install -r requirements.txt
python node.py

Smart Contract (Solidity + Hardhat)

cd smart-contract
npm install
npx hardhat compile
npx hardhat test
npx hardhat run scripts/deploy.js

Flask UI

cd flask-ui
python app.py

Author

Benjamin Wong (@wongbenjamin25)
National University of Singapore – Data Science & Quantitative Finance

---

Let me know if you want to:
- Add live demo links
- Add badges (e.g., license, technologies)
- Link it to your resume or portfolio

Happy to help!
