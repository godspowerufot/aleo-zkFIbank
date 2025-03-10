# Basic Bank Aleo

## Overview
Basic Bank Aleo is a privacy-focused decentralized banking system built on the Aleo blockchain. It allows users to issue, deposit, withdraw, transfer, and burn tokens while maintaining privacy through Zero-Knowledge Proofs (ZKPs).

## Features
- **Token Issuance**: The bank can issue new tokens to users.
- **Deposits**: Users can securely deposit tokens into the bank.
- **Withdrawals**: Users can withdraw tokens, including interest calculations.
- **Transfers**: Users can transfer tokens between accounts.
- **Burning**: Tokens can be permanently removed from circulation.

## Deployment Information
- **Execute ID**: `
at1d7nlc3qpxmvmmvnssnyecj2n99d70dxw9jj4pmzzhzx4d4g45vzq3gc95r`

- **Deployment ID**: `
at1lsnwt5lhc5pluvl3xawg3fh7r4jmz8ddekp52a76dwg8d0qw4q9qea6uuc`
- **Deployment URL**: [View on Aleo Testnet](https://testnet.aleo.info/program/basic_bank.aleo)
- **Deployment Image**: ![Deployment Screenshot](https://i.ibb.co/k2S1jrcG/deployment.png)

## Smart Contract Breakdown

### 1. **BankToken Record**
A record structure to store token ownership details.
```leo
record BankToken {
    owner: address,
    amount: u64,
}
```

### 2. **Issue Tokens**
The bank can issue new tokens to a user.
```leo
transition issue_tokens(owner: address, amount: u64) -> BankToken
```

### 3. **Deposit Tokens**
Users deposit tokens into the bank, updating the on-chain balance.
```leo
async transition deposit(bank_token: BankToken, amount: u64) -> (BankToken, Future)
```

### 4. **Withdraw Tokens (With Interest Calculation)**
Users withdraw tokens, including accumulated interest over a given period.
```leo
async transition withdraw(recipient: address, amount: u64, rate: u64, periods: u64) -> (BankToken, Future)
```

### 5. **Calculate Interest**
Computes compound interest for withdrawals.
```leo
function calculate_interest(principal: u64, rate: u64, periods: u64) -> u64
```

### 6. **Transfer Tokens**
Users can transfer tokens between accounts securely.
```leo
transition transfer(sender_token: BankToken, recipient: address, amount: u64) -> (BankToken, BankToken)
```

### 7. **Burn Tokens**
Removes tokens permanently from circulation.
```leo
transition burn(bank_token: BankToken, amount: u64) -> BankToken
```

## Use Cases
1. **Private Banking**: Users can securely store and transfer funds.
2. **Interest-Bearing Accounts**: Users can earn interest on their deposits.
3. **Tokenized Financial Services**: Banks can issue private, digital assets.

## How This Is a ZeFi (Zero-Knowledge DeFi) Application
✅ **Privacy-Preserving Transactions**: Uses Zero-Knowledge Proofs to keep balances and transactions confidential.
✅ **Decentralized Finance**: Allows users to transact without intermediaries.
✅ **Secure & Transparent**: Ensures secure banking operations on the Aleo blockchain.

## Getting Started
To interact with the contract:
1. Deploy the contract on the Aleo Testnet.
2. Execute transactions using Aleo CLI.
3. Monitor balance changes via the Aleo explorer.

## Contributing
Contributions are welcome! Please submit a pull request or raise an issue for improvements.

## License
This project is licensed under the MIT License.

