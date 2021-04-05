pragma solidity ^0.6.0;
contract HighFlyerToken{

    string public name = "HighFlyerToken";
    string public symbol = "Hi-Fly";
    uint256 public totalSupply_ = 1000000000000000000000;
    uint8  public decimals = 18;

    event transfer(
        address indexed_from,
        address indexed_to,
        uint256 _value
    );

    event Approval(
        address indexed_owner,
        address indexed_spender,
        uint256 _value
    );

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256))public allowed;
    
    constructor()public{
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }
    function balancesof(address _owner)public view returns (uint256){
        return balances[_owner];
    }
    function transferfrom(address _to, uint256 _value) public returns(bool success){
        require(balances[msg.sender] >= _value);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances [_to] + _value;
        emit transfer(msg.sender, _to, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender]=_value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function transferfrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_value <= balances [_from]); 
        require(_value <= allowed[_from][msg.sender]);
        balances[_from]-=_value;
        balances[_to]+=_value;
        allowed[_from][msg.sender] -= _value;
        emit transfer(_from, _to, _value);
        return true;
    }
    function allowance(address _owner,address _spender) public view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
}