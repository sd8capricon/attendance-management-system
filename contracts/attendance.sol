// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Owned {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}

contract AttendanceSheet is Owned {
    struct Student {
        uint age;
        string fName;
        string lName;
        uint attendanceValue;
    }

    mapping(uint => Student) studentList;
    uint[] public studIdList;

    event StudentCreationEvent(string fName, string lName, uint age);

    function createStudent(
        uint _studId,
        uint _age,
        string memory _fName,
        string memory _lName
    ) public onlyOwner {
        Student storage student = studentList[_studId];
        student.age = _age;
        student.fName = _fName;
        student.lName = _lName;
        student.attendanceValue = 0;
        studIdList.push(_studId);
        emit StudentCreationEvent(_fName, _lName, _age);
    }

    function incrementAttendance(uint _studId) public onlyOwner {
        studentList[_studId].attendanceValue =
            studentList[_studId].attendanceValue +
            1;
    }

    function incrementAttendanceBulk(uint[] memory _studIds) public onlyOwner {
        for (uint256 index = 0; index < _studIds.length; index++) {
            uint _studId = _studIds[index];
            studentList[_studId].attendanceValue =
                studentList[_studId].attendanceValue +
                1;
        }
    }

    function getStudents() public view returns (uint[] memory) {
        return studIdList;
    }

    function getParticularStudent(
        uint _studId
    ) public view returns (string memory, string memory, uint, uint) {
        Student memory student = studentList[_studId];
        return (
            student.fName,
            student.lName,
            student.age,
            student.attendanceValue
        );
    }

    function countStudents() public view returns (uint) {
        return studIdList.length;
    }
}
