// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

contract ERC20Token {
    string private s_name;
    string private s_symbol;
    uint8 private s_decimals;
    uint256 private s_totalSupply;
    mapping(address => uint256) private s_balances;
    mapping(address => mapping(address => uint256)) private s_allowances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 initialSupply) {
        s_name = name_;
        s_symbol = symbol_;
        s_decimals = decimals_;
        s_totalSupply = initialSupply;
        s_balances[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }
    function name() public view returns (string memory) {
        return s_name;
    }
    function symbol() public view returns (string memory) {
        return s_symbol;
    }
    function decimals() public view returns (uint8) {
        return s_decimals;
    }
    function totalSupply() public view returns (uint256) {
        return s_totalSupply;
    }
    function balanceOf(address account) public view returns (uint256) {
        return s_balances[account];
    }
    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(s_balances[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");
        s_balances[msg.sender] -= amount;
        s_balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    function mint(address account, uint256 amount) public returns (bool) {
        require(account != address(0), "ERC20: mint to the zero address");

        s_totalSupply += amount;
        s_balances[account] += amount;

        emit Transfer(address(0), account, amount);
        return true;
    }
    function burn(uint256 amount) public returns (bool) {
        require(s_balances[msg.sender] >= amount, "ERC20: burn amount exceeds balance");

        s_totalSupply -= amount;
        s_balances[msg.sender] -= amount;

        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
