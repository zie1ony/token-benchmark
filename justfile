SECRET_KEY_1 := "keys/keys1/secret_key.pem"
SECRET_KEY_2 := "keys/keys2/secret_key.pem"
SECRET_KEY_3 := "keys/keys3/secret_key.pem"
NODE_ADDRESS := "http://3.143.158.19:7777"

ODRA_TOKEN_WASM_PATH := "wasm/odra_erc20.wasm"
ODRA_CONTRACT_HASH := "hash-bae802089273148e6e541e5ec5565b5932af949f80317b0a6179a6e308409517"

DAO_TOKEN_WASM_PATH := "wasm/dao_erc20.wasm"
DAO_CONTRACT_HASH := "hash-8f95cd871c6da35223f7f07cc7bb30b13f3c799afef0798e7bd3c546680a50e3"
DAO_ACCOUNT_HASH2 := "account-hash-90f164e6344770c7e67d143150848a7a4d48757e00ea2c73ce7d813a5e5eddf4"

FRIENDLYMARKET_TOKEN_WASM_PATH := "wasm/friendly_market_erc20.wasm"
FRIENDLYMARKET_CONTRACT_HASH := "hash-8f95cd871c6da35223f7f07cc7bb30b13f3c799afef0798e7bd3c546680a50e3"
FRIENDLYMARKET_ACCOUNT_HASH2 := "account-hash-90f164e6344770c7e67d143150848a7a4d48757e00ea2c73ce7d813a5e5eddf4"

CASPERLABS_TOKEN_WASM_PATH := "wasm/casperlabs_erc20.wasm"
CASPERLABS_CONTRACT_HASH := "hash-8f95cd871c6da35223f7f07cc7bb30b13f3c799afef0798e7bd3c546680a50e3"
CASPERLABS_ACCOUNT_HASH2 := "account-hash-90f164e6344770c7e67d143150848a7a4d48757e00ea2c73ce7d813a5e5eddf4"


default:
    just --list

transfer-cspr TARGET_ACCOUNT AMOUNT:
    casper-client transfer \
        --amount {{AMOUNT}}000000000 \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --target-account {{TARGET_ACCOUNT}} \
        --transfer-id 10 \
        --payment-amount 100000000 \
        --node-address {{NODE_ADDRESS}}

deploy_odra_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
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
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{ODRA_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"
    
deploy_dao_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 150000000000 \
        --session-path {{DAO_TOKEN_WASM_PATH}} \
        --session-arg "name:string='MyToken'" \
        --session-arg "symbol:string='MTV'" \
        --session-arg "decimals:u8='5'" \
        --session-arg "initial_supply:u256='21000000'" \

call_dao_token_transfer:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{DAO_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"

call_dao_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{DAO_CONTRACT_HASH}} \
        --session-entry-point "transfer_from" \
        --session-arg "owner:key='account-hash-f3a37c76cf542af5d5f3ecfbd428ad3c28717ccf0cd326d890cd749a6c50b645'" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"

call_dao_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{DAO_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "spender:key='{{DAO_ACCOUNT_HASH2}}'" \
        --session-arg "amount:u256='10'"

deploy_friendlymarket_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 150000000000 \
        --session-path {{FRIENDLYMARKET_TOKEN_WASM_PATH}} \
        --session-arg "token_name:String='MyToken'" \
        --session-arg "token_symbol:String='MTV'" \
        --session-arg "token_decimals:u8='5'" \
        --session-arg "token_total_supply:u256='21000000'" \

call_friendlymarket_token_transfer:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{FRIENDLYMARKET_CONTRACT_HASH}} \
        --session-entry-point "transfer_from" \
        --session-arg "recipient:Key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:U256='10'"

call_friendlymarket_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{FRIENDLYMARKET_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "owner:key='account-hash-f3a37c76cf542af5d5f3ecfbd428ad3c28717ccf0cd326d890cd749a6c50b645'" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"

call_friendlymarket_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{FRIENDLYMARKET_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "spender:Key='{{FRIENDLYMARKET_ACCOUNT_HASH2}}'" \
        --session-arg "amount:U256='10'"

deploy_casperlabs_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 15000000000 \
        --session-path {{CASPERLABS_TOKEN_WASM_PATH}} \
        --session-arg "name:String='MyToken'" \
        --session-arg "symbol:String='MTV'" \
        --session-arg "decimals:u8='6'" \
        --session-arg "total_supply:u256='22000000'" \

call_casperlabs_token_transfer:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{CASPERLABS_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "RECIPIENT_RUNTIME_ARG_NAME:Address='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "AMOUNT_RUNTIME_ARG_NAME:U256='10'"

call_casperlabs_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{CASPERLABS_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "owner:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "spender:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"

call_casperlabs_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{CASPERLABS_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "SPENDER_RUNTIME_ARG_NAME:Address='{{CASPERLABS_ACCOUNT_HASH2}}'" \
        --session-arg "AMOUNT_RUNTIME_ARG_NAME:U256='10'"