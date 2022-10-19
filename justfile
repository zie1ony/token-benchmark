SECRET_KEY := "keys/keys1/secret_key.pem"
NODE_ADDRESS := "http://3.143.158.19:7777"

ODRA_TOKEN_WASM_PATH := "wasm/odra_erc20.wasm"
ODRA_CONTRACT_HASH := "hash-bae802089273148e6e541e5ec5565b5932af949f80317b0a6179a6e308409517"

transfer-cspr TARGET_ACCOUNT AMOUNT:
    casper-client transfer \
        --amount {{AMOUNT}}000000000 \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY}} \
        --target-account {{TARGET_ACCOUNT}} \
        --transfer-id 10 \
        --payment-amount 100000000 \
        --node-address {{NODE_ADDRESS}}

deploy_odra_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 150000000000 \
        --session-path {{ODRA_TOKEN_WASM_PATH}} \
        --session-arg "constructor:string='init'" \
        --session-arg "name:string='MyToken'" \
        --session-arg "symbol:string='MTV'" \
        --session-arg "decimals:u8='5'" \
        --session-arg "initial_supply:u256='21000000'" \
        
call_odra_token_transfer:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{ODRA_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"
    