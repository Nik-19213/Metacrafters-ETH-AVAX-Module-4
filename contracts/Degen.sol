// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable, Pausable {
    mapping(address => bool) private _banned;

    event MintToken(address indexed to, uint256 value);
    event BurnToken(address indexed from, uint256 value);
    event Account_Banned(address indexed account);
    event Account_Unbanned(address indexed account);
    event RedeemGameReward(address indexed player, string itemName);

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) external onlyOwner whenNotPaused {
        require(!isBanned(to), "This Game account has been Banned due to unethical Behaviour");
        _mint(to, amount);
        emit MintToken(to, amount);
    }

    function burntokens(uint256 amount) external {
        require(balanceOf(msg.sender)>= amount, "You do not have enough Tokens in your account");
        _burn(msg.sender, amount);
        emit BurnToken(msg.sender, amount);
    }

    function RewardsStore() public pure returns(string memory) {
            return "1. Premium Warrior outfit (value = 500 Degen)\n2. Fire swrord (value = 300 Degen)\n3. Invisible Cloke (value = 100 Degen)";
        }

    function redeem(uint256 choice) external whenNotPaused {
        require(choice <= 3, "Invalid selection");

        if (choice == 1) {
            require(balanceOf(msg.sender) >= 500, "Insufficient balance");
            approve(msg.sender, 500);
            transferFrom(msg.sender, owner(), 500);
            emit RedeemGameReward(msg.sender, "Premium Warrior outfit");
        } else if (choice == 2) {
            require(balanceOf(msg.sender) >= 300, "Insufficient balance");
            approve(msg.sender, 300);
            transferFrom(msg.sender, owner(), 300);
            emit RedeemGameReward(msg.sender, "Fire swrord");
        } else if (choice == 3) {
            require(balanceOf(msg.sender) >= 100, "Insufficient balance");
            approve(msg.sender, 100);
            transferFrom(msg.sender, owner(), 100);
            emit RedeemGameReward(msg.sender, "Invisible Cloke");
        }
    }

    function checkBalance() external view returns(uint){
           return balanceOf(msg.sender);
    }

    function Ban_Account(address account) external onlyOwner {
        _banned[account] = true;
        emit Account_Banned(account);
    }

    function Unban_Account(address account) external onlyOwner {
        _banned[account] = false;
        emit Account_Unbanned(account);
    }

    function isBanned(address account) public view returns (bool) {
        return _banned[account];
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function transfer(address reciever, uint256 amount) public override whenNotPaused returns (bool) {
        require(!isBanned(msg.sender), "Sender's game account is Banned");
        require(!isBanned(reciever), "Reciever's game account is Banned");
        return super.transfer(reciever, amount);
    }

    function transferFrom(address sender, address reciever, uint256 amount) public override whenNotPaused returns (bool) {
        require(!isBanned(sender), "Sender's game account is Banned");
        require(!isBanned(reciever), "Reciever's game account is Banned");
        approve(msg.sender, amount);
        return super.transferFrom(sender, reciever, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
        require(!isBanned(from), "Sender's game account is Banned");
        require(!isBanned(to), "Reciever's game account is Banned");
    }

}
