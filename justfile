SECRET_KEY_1 := "keys/keys1/secret_key.pem"
SECRET_KEY_2 := "keys/keys2/secret_key.pem"
SECRET_KEY_3 := "keys/keys3/secret_key.pem"
SECRET_KEY_4 := "keys/keys4/secret_key.pem"
NODE_ADDRESS := "http://3.143.158.19:7777"

ACCOUNT_HASH1 := "account-hash-f3a37c76cf542af5d5f3ecfbd428ad3c28717ccf0cd326d890cd749a6c50b645"
ACCOUNT_HASH2 := "account-hash-d5a3144dd6862408f76b6df43eaf06168e2851a6e049f78a3b70ee1d258ce070"
ACCOUNT_HASH3 := "account-hash-9bf25af13630d96cd751d106cd041ef3d2230750ce8921de1595dd3a78ca6234"
ACCOUNT_HASH4 := "account-hash-50e28cfd4fb987ecd113c8c57a4fec251a57e81d520f581c86d2d4f3c154fca6"

DAO_TOKEN_WASM_PATH := "wasm/dao_erc20.wasm"
DAO_CONTRACT_HASH := "hash-8f95cd871c6da35223f7f07cc7bb30b13f3c799afef0798e7bd3c546680a50e3"
DAO_ACCOUNT_HASH2 := "account-hash-f3a37c76cf542af5d5f3ecfbd428ad3c28717ccf0cd326d890cd749a6c50b645"

FRIENDLYMARKET_TOKEN_WASM_PATH := "wasm/friendly_market_erc20.wasm"
FRIENDLYMARKET_CONTRACT_HASH := "hash-478796f198e8390abbbd72f326b215544af3c5d7f03ee4db8fbea734febf6501"
FRIENDLYMARKET_ACCOUNT_HASH2 := "account-hash-d5a3144dd6862408f76b6df43eaf06168e2851a6e049f78a3b70ee1d258ce070"

CASPERLABS_TOKEN_WASM_PATH := "wasm/casperlabs_erc20.wasm"
CASPERLABS_CONTRACT_HASH := "hash-b88ce109f18be5bccd20cf291479714fe724a0a5b32f7b0c3007de72a1534317"
CASPERLABS_ACCOUNT_HASH2 := "account-hash-9bf25af13630d96cd751d106cd041ef3d2230750ce8921de1595dd3a78ca6234"

ODRA_TOKEN_WASM_PATH := "wasm/odra_erc20.wasm"
ODRA_CONTRACT_HASH := "hash-f7d3410596226c0aed54a45c3a930daa995746ccfda29d8d2b0e6dc19fcc3f32"
ODRA_ACCOUNT_HASH2 := "account-hash-50e28cfd4fb987ecd113c8c57a4fec251a57e81d520f581c86d2d4f3c154fca6"

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

call_dao_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{DAO_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "spender:key='{{ACCOUNT_HASH2}}'" \
        --session-arg "amount:u256='10'"

call_dao_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_2}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{DAO_CONTRACT_HASH}} \
        --session-entry-point "transfer_from" \
        --session-arg "owner:key='{{ACCOUNT_HASH1}}'" \
        --session-arg "recipient:key='{{ACCOUNT_HASH3}}'" \
        --session-arg "amount:u256='10'"

deploy_friendlymarket_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_2}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 150000000000 \
        --session-path {{FRIENDLYMARKET_TOKEN_WASM_PATH}} \
        --session-arg "token_name:String='MyToken'" \
        --session-arg "token_symbol:String='MTV'" \
        --session-arg "token_decimals:u8='5'" \
        --session-arg "token_total_supply:u256='21000000'" 

call_friendlymarket_token_transfer:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_2}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{FRIENDLYMARKET_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-9bf25af13630d96cd751d106cd041ef3d2230750ce8921de1595dd3a78ca6234'" \
        --session-arg "amount:U256='10'"

call_friendlymarket_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_3}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{FRIENDLYMARKET_CONTRACT_HASH}} \
        --session-entry-point "transfer_from" \
        --session-arg "owner:key='{{ACCOUNT_HASH2}}'" \
        --session-arg "recipient:key='{{ACCOUNT_HASH1}}'" \
        --session-arg "amount:u256='10'"

call_friendlymarket_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_2}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{FRIENDLYMARKET_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "spender:Key='{{ACCOUNT_HASH3}}'" \
        --session-arg "amount:U256='10'"

deploy_casperlabs_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_3}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 150000000000 \
        --session-path {{CASPERLABS_TOKEN_WASM_PATH}} \
        --session-arg "name:String='MyToken'" \
        --session-arg "symbol:String='MTV'" \
        --session-arg "decimals:u8='6'" \
        --session-arg "total_supply:u256='22000000'" \

call_casperlabs_token_transfer:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_3}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{CASPERLABS_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-f7df161d25607328043edbf0d083c1d87ac3790af4b020b3123e53b3ac4c36a0'" \
        --session-arg "amount:u256='10'"

call_casperlabs_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{CASPERLABS_CONTRACT_HASH}} \
        --session-entry-point "transfer_from" \
        --session-arg "owner:key='{{ACCOUNT_HASH3}}'" \
        --session-arg "recipient:key='{{ACCOUNT_HASH2}}'" \
        --session-arg "amount:u256='10'"

call_casperlabs_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_3}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{CASPERLABS_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "spender:key='{{ACCOUNT_HASH1}}'" \
        --session-arg "amount:u256='10'"

deploy_odra_token_contract:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_4}} \
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
        --secret-key {{SECRET_KEY_4}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 100000000 \
        --session-hash {{ODRA_CONTRACT_HASH}} \
        --session-entry-point "transfer" \
        --session-arg "recipient:key='account-hash-d5a3144dd6862408f76b6df43eaf06168e2851a6e049f78a3b70ee1d258ce070'" \
        --session-arg "amount:u256='10'"

call_odra_token_transferfrom:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_1}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{ODRA_CONTRACT_HASH}} \
        --session-entry-point "transfer_from" \
        --session-arg "owner:key='{{ACCOUNT_HASH4}}'" \
        --session-arg "recipient:key='{{ACCOUNT_HASH3}}'" \
        --session-arg "amount:u256='10'"

call_odra_token_approve:
    casper-client put-deploy \
        --chain-name integration-test \
        --secret-key {{SECRET_KEY_4}} \
        --node-address {{NODE_ADDRESS}} \
        --payment-amount 1000000000 \
        --session-hash {{ODRA_CONTRACT_HASH}} \
        --session-entry-point "approve" \
        --session-arg "spender:key='{{ACCOUNT_HASH1}}'" \
        --session-arg "amount:u256='10'"
