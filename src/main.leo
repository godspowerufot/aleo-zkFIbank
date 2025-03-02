program basic_bank.aleo {
    // A token issued by a bank.
    record BankToken {
        owner: address,
        amount: u64,
    }

    // On-chain balance mapping with privacy protection.
    mapping balances: field => u64;

    // Issues new tokens to an account (only the bank can issue tokens).
    transition issue_tokens(owner: address, amount: u64) -> BankToken {
        assert_eq(self.caller, aleo19wu36f724n6etu6tdux9qch63qh69tunyk2jtmx8ugtq996lw5qql33v9k);
        return BankToken { owner, amount };
    }

    // Deposits tokens into the bank.
    async transition deposit(bank_token: BankToken, amount: u64) -> (BankToken, Future) {
        let remaining_amount: u64 = bank_token.amount - amount;
        let remaining: BankToken = BankToken { owner: bank_token.owner, amount: remaining_amount };
        let owner_hash: field = BHP256::hash_to_field(bank_token.owner);
        return (remaining, finalize_deposit(owner_hash, amount));
    }

    // Updates on-chain state for deposits.
    async function finalize_deposit(owner_hash: field, amount: u64) {
        let current_balance: u64 = Mapping::get_or_use(balances, owner_hash, 0u64);
        Mapping::set(balances, owner_hash, current_balance + amount);
    }

    // Withdraw tokens with interest calculation.
    async transition withdraw(recipient: address, amount: u64, rate: u64, periods: u64) -> (BankToken, Future) {
        assert_eq(self.caller, aleo19wu36f724n6etu6tdux9qch63qh69tunyk2jtmx8ugtq996lw5qql33v9k);
        let recipient_hash: field = BHP256::hash_to_field(recipient);
        let total_amount: u64 = calculate_interest(amount, rate, periods);
        let token: BankToken = BankToken { owner: recipient, amount: total_amount };
        return (token, finalize_withdraw(recipient_hash, amount));
    }

    // Updates on-chain state for withdrawals.
    async function finalize_withdraw(owner_hash: field, amount: u64) {
        let current_balance: u64 = Mapping::get_or_use(balances, owner_hash, 0u64);
        Mapping::set(balances, owner_hash, current_balance - amount);
    }

    // Computes compound interest.
       function calculate_interest(principal: u64, rate: u64, periods: u64) -> u64 {
        let amount: u64 = principal;

        for i:u64 in 0u64..100u64 {
            if i < periods {
                amount += (amount * rate) / 10000u64;
            }
        }

        return amount;
    }

    // Transfers tokens from one account to another.
    transition transfer(sender_token: BankToken, recipient: address, amount: u64) -> (BankToken, BankToken) {
        assert_eq(sender_token.amount >= amount, true);
        let sender_remaining: BankToken = BankToken { owner: sender_token.owner, amount: sender_token.amount - amount };
        let recipient_token: BankToken = BankToken { owner: recipient, amount };
        return (sender_remaining, recipient_token);
    }

    // Burns tokens, removing them permanently from circulation.
     transition burn(bank_token: BankToken, amount: u64) -> BankToken {
        assert_eq(bank_token.amount >= amount, true);
        let remaining: BankToken = BankToken { owner: bank_token.owner, amount: bank_token.amount - amount };
        return remaining;
    }
}

 
