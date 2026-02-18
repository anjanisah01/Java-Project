class Student {

    private int rollNo;
    protected String name;
    public int[] marks;

    Student(int rollNo, String name, int[] marks) {
        this.rollNo = rollNo;
        this.name = name;
        this.marks = marks;
    }

    public int calculateTotal() {
        int total = 0;
        for (int i = 0; i < marks.length; i++) {
            total = total + marks[i];
        }
        return total;
    }

    public double calculatePercentage() {
        return calculateTotal() / 5.0;
    }

    public void displayDetails() {
        System.out.println("Roll No: " + rollNo);
        System.out.println("Name: " + name);
        System.out.println("Percentage: " + calculatePercentage());
    }
}

public class Main {

    public static void main(String[] args) {

        int[] marks = {78, 85, 69, 90, 88};

        Student student = new Student(101, "Anjani", marks);

        student.displayDetails();
    }
}
