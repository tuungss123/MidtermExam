// SPDX-License-Identifier:MIT
pragma solidity ^0.8.2;

contract Midterm{
    address public owner;
    uint256 public prelimgrade;
    uint256 public midtermgrade;
    uint256 public finalgrade;
    uint256 public averagegrade;
    string public name;
    enum gradeStatus{ FAIL,PASS }
    gradeStatus public status;
    event GradeComputed(string indexed eventname);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only the owner can set the grades.");
        _;
    }
    modifier validGrade{
        require(prelimgrade >= 0 && prelimgrade <=100 , "Input a number from 0 - 100");
        require(midtermgrade >= 0 && midtermgrade <=100 , "Input a number from 0 - 100");
        require(finalgrade >= 0 && finalgrade <=100 , "Input a number from 0 - 100");
        _;

    }
    function setName(string calldata _name) external{
        name = _name;

    }

    function setPrelimGrade(uint256 _prelimgrade)external onlyOwner validGrade {
        prelimgrade = _prelimgrade;
    }
    function setMidtermGrade(uint256 _midtermgrade)external onlyOwner validGrade{
        midtermgrade = _midtermgrade;
    }
    function setFinalGrade(uint256 _finalgrade)external onlyOwner validGrade {
        finalgrade = _finalgrade;
    }
    function CalculateGrade() external  onlyOwner{
        emit GradeComputed(name);
        averagegrade = (prelimgrade + midtermgrade + finalgrade) / 3;
        if (averagegrade >= 75) {
            status = gradeStatus.PASS;
        }
        else {
            status = gradeStatus.FAIL;
        }
    }
    

}
