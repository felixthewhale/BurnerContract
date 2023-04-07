// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

import './HederaResponseCodes.sol';
import './IHederaTokenService.sol';
import './HederaTokenService.sol';
import './ExpiryHelper.sol';

contract BurnerContract is HederaTokenService, ExpiryHelper {
    bool private used;

    constructor() {
        used = false;
    }

    function contractAssociate(address token) external payable returns (int response) {
        require(!used, "Contract has already been used.");
        used = true;

        (response) = HederaTokenService.associateToken(address(this), token);

        require(response == HederaResponseCodes.SUCCESS, "Token association failed");
    }
}
