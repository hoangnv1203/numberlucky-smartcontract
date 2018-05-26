pragma solidity ^0.4.20;

contract NumberLucky {
    address owner;
    uint256 _seed;
    uint256 public constant ROOM1_VALUE = 0.01 ether;
    uint256 public constant ROOM2_VALUE = 0.02 ether;
    uint256 public constant ROOM3_VALUE = 0.03 ether;
    uint256 public constant ROOM4_VALUE = 0.05 ether;
    uint256 public constant ROOM5_VALUE = 0.1 ether;
    address[] public players;
    bool public paused = false;
    struct Player {
        uint256 amount;
        uint256 amountBet;
        bool isLock;
        uint256 numberSelected;
    }
    mapping(address => Player) public playerInfo;
    uint256 public luckyNumber;
    uint256 public count;

    function NumberLucky() public {
        owner = msg.sender;
    }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param _newOwner The address to transfer ownership to.
    */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != owner);
        owner = _newOwner;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     */
    modifier whenPaused() {
        require(paused);
        _;
    }

    /**
     * @dev called by the owner to pause, triggers stopped state
     */
    function pause() onlyOwner whenNotPaused public {
        paused = true;
    }

    /**
     * @dev called by the owner to unpause, returns to normal state
     */
    function unpause() onlyOwner whenPaused public {
        paused = false;
    }

    // deposit for player call
    function deposit() public payable {
        require(msg.value >= ROOM1_VALUE);
        playerInfo[msg.sender].amount += msg.value;
        playerInfo[msg.sender].isLock = false;
    }

    // withdraw for player
    function withdraw() public payable {
        uint256 balances = playerInfo[msg.sender].amount;
        require(balances >= ROOM4_VALUE);
        require(playerInfo[msg.sender].isLock == false);
        playerInfo[msg.sender].amount -= balances;
        msg.sender.transfer(balances);
    }

    function getBalances() public view returns(uint256) {
        return playerInfo[msg.sender].amount;
    }

    function getInfoTotal() public view returns(uint256, uint256) {
        uint256 amountOfBet;
        for (uint256 i = 0; i < players.length; i++) {
            address playerAddress = players[i];
            amountOfBet += playerInfo[playerAddress].amountBet;
        }
        return(players.length + 1, amountOfBet);
    }

    function getInfoRoom(uint256 _value) public view returns(uint256 amount, uint256 total) {
        uint256 amountRoom;
        uint256 playersRoom = 0;
        for (uint256 i = 0; i < players.length; i++) {
            address playerAddress = players[i];
            if (playerInfo[playerAddress].amountBet == _value) {
                amountRoom += _value;
                playersRoom++;
            }
        }
        return (amountRoom, playersRoom);
    }

    function getInfoSelectedNumber(uint256 _roomValue, uint256 _number) public view returns(uint256 a) {
        uint256 countPlayer = 0;
        for (uint256 i = 0; i < players.length; i++) {
            address playerAddress = players[i];
            if (playerInfo[playerAddress].numberSelected == _number && playerInfo[playerAddress].amountBet == _roomValue) {
                countPlayer++;
            }
        }
        return countPlayer;
    }

    function getInfoRoom1() public view returns(uint256 amount, uint256 total) {return (getInfoRoom(ROOM1_VALUE));}
    function getInfoRoom2() public view returns(uint256 amount, uint256 total) {return (getInfoRoom(ROOM2_VALUE));}
    function getInfoRoom3() public view returns(uint256 amount, uint256 total) {return (getInfoRoom(ROOM3_VALUE));}
    function getInfoRoom4() public view returns(uint256 amount, uint256 total) {return (getInfoRoom(ROOM4_VALUE));}
    function getInfoRoom5() public view returns(uint256 aamount, uint256 total) {return (getInfoRoom(ROOM5_VALUE));}

    function getInfoRoom11() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM1_VALUE, 1));}
    function getInfoRoom12() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM1_VALUE, 2));}
    function getInfoRoom13() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM1_VALUE, 3));}
    function getInfoRoom14() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM1_VALUE, 4));}
    function getInfoRoom15() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM1_VALUE, 5));}
    function getInfoRoom16() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM1_VALUE, 6));}

    function getInfoRoom21() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM2_VALUE, 1));}
    function getInfoRoom22() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM2_VALUE, 2));}
    function getInfoRoom23() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM2_VALUE, 3));}
    function getInfoRoom24() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM2_VALUE, 4));}
    function getInfoRoom25() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM2_VALUE, 5));}
    function getInfoRoom26() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM2_VALUE, 6));}

    function getInfoRoom31() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM3_VALUE, 1));}
    function getInfoRoom32() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM3_VALUE, 2));}
    function getInfoRoom33() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM3_VALUE, 3));}
    function getInfoRoom34() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM3_VALUE, 4));}
    function getInfoRoom35() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM3_VALUE, 5));}
    function getInfoRoom36() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM3_VALUE, 6));}

    function getInfoRoom41() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM4_VALUE, 1));}
    function getInfoRoom42() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM4_VALUE, 2));}
    function getInfoRoom43() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM4_VALUE, 3));}
    function getInfoRoom44() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM4_VALUE, 4));}
    function getInfoRoom45() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM4_VALUE, 5));}
    function getInfoRoom46() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM4_VALUE, 6));}

    function getInfoRoom51() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM5_VALUE, 1));}
    function getInfoRoom52() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM5_VALUE, 2));}
    function getInfoRoom53() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM5_VALUE, 3));}
    function getInfoRoom54() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM5_VALUE, 4));}
    function getInfoRoom55() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM5_VALUE, 5));}
    function getInfoRoom56() public view returns(uint256 total) {return (getInfoSelectedNumber(ROOM5_VALUE, 6));}

    function betRoom1(uint256 _number) whenNotPaused public {
        bet(msg.sender, ROOM1_VALUE, _number);
    }

    function betRoom2(uint256 _number) whenNotPaused public {
        bet(msg.sender, ROOM2_VALUE, _number);
    }

    function betRoom3(uint256 _number) whenNotPaused public {
        bet(msg.sender, ROOM3_VALUE, _number);
    }

    function betRoom4(uint256 _number) whenNotPaused public {
        bet(msg.sender, ROOM4_VALUE, _number);
    }

    function betRoom5(uint256 _number) whenNotPaused public {
        bet(msg.sender, ROOM5_VALUE, _number);
    }

    function bet(address _player, uint256 _value, uint256 _number) whenNotPaused private {
        require(playerInfo[_player].amount >= _value);
        require(_number >= 1 && _number <= 6);
        require(!playerInfo[_player].isLock);
        playerInfo[_player].amountBet = _value;
        playerInfo[_player].amount -= _value;
        playerInfo[_player].numberSelected = _number;
        playerInfo[_player].isLock = true;
        players.push(_player);
    }

    function maxRandom() public returns (uint256 randomNumber) {
        uint256 totalPlayer;
        uint256 totalAmount;
        (totalPlayer, totalAmount) = getInfoTotal();

        _seed = uint256(keccak256(
            _seed,
            block.blockhash(block.number - 1),
            block.coinbase,
            block.difficulty,
            totalPlayer,
            totalAmount
        ));

        return _seed;
    }

    function generateLuckyNumber() onlyOwner public {
        luckyNumber = (maxRandom() % 6) + 1;
    }
}
