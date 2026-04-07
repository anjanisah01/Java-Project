# Student and Employee Management Classes

## Overview
This project includes two main classes: **Student** and **Employee**, designed to manage their respective records and operations.

## Class: Student
The **Student** class represents a student in the system. It includes properties and methods particularly relevant to a student's information and behavior.

### Properties:
- `studentId`: Unique identifier for each student.
- `name`: Name of the student.
- `age`: Age of the student.
- `course`: The course the student is enrolled in.

### Methods:
- `enroll(course)`: Allows a student to enroll in a new course.
- ` graduate()`: Marks the student as graduated.

## Class: Employee
The **Employee** class represents an employee in the organization. It includes properties and methods that pertain to employee management.

### Properties:
- `employeeId`: Unique identifier for each employee.
- `name`: Name of the employee.
- `position`: The position of the employee within the organization.
- `salary`: The salary of the employee.

### Methods:
- `promote(newPosition)`: Promotes the employee to a new position.
- `getDetails()`: Returns the details of the employee in a readable format.

## Usage
Both the **Student** and **Employee** classes can be instantiated and manipulated through their respective methods. These classes can also be expanded with additional methods and properties as required by the project scope.