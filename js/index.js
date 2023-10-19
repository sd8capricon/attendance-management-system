const rowComponent = (student, index) => {
    const rowTemplate = `<tr>
<td>${student.id}</td>
<td>${student["0"]}</td>
<td>${student["1"]}</td>
<td><input type="checkbox" name="${student.id}-${index}" onChange="handleMarking(event)"/></td>
</tr>`;
    return rowTemplate;
}

const buildTable = () => {
    AttendanceManagement.getStudents(function (error, result) {
        if (!error) {
            if (result.length == 0) {
                studentTable.append("<tr><td colspan='4'>No Students Found</td></tr>");
                return;
            }
            $.each(result, function (index, value) {
                AttendanceManagement.getParticularStudent(value, function (error, result) {
                    if (!error) {
                        result.id = String(value);
                        result.status = false;
                        students.push(result);
                        let index = students.indexOf(result)
                        studentTable.append(rowComponent(result, index));
                        console.log(result);
                    }
                    else
                        console.error(error);
                });
            });
            console.log(result[0]);
        }
        else
            console.error(error);
    });
}

const handleMarking = (e) => {
    const name = e.target.name.split("-")
    students[name[1]].status = e.target.checked
    console.log(students);
}

const handleAttendance = () => {
    if (students.length == 0) {
        alert("Cannot Mark Attendance for Empty List");
        return;
    }
    for (let student of students) {
        if (student.status) {
            AttendanceManagement.incrementAttendance(student.id);
        }
    }
    alert("Attendance Marked");
    window.location.reload();
}