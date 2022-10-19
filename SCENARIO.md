# ERC20 Benchmark Scenario:

- As Account1:
  - Deploy contract
  - Transfer to the Account2 (account without tokens).
  - Transfer to the Account2 (account with tokens).
  - Transfer to the Account2 (account with tokens).
  - Approve Account2 to spend tokens.
  - Approve Account2 again to spend tokens.
  - Approve Account2 again to spend tokens.

- As Account2:
  - TransferFrom from Account1 to Account3
  - TransferFrom from Account1 to Account3
  - TransferFrom from Account1 to Account3
    