class Shapes {

    double area;

    // constructor overloading
    Shapes(double radius) {
        area = 3.14 * radius * radius;
        System.out.println("Area of Circle: " + area);
    }

    Shapes(double length, double breadth) {
        area = length * breadth;
        System.out.println("Area of Rectangle: " + area);
    }

    Shapes(double base, double height, boolean isTriangle) {
        area = 0.5 * base * height;
        System.out.println("Area of Triangle: " + area);
    }

    // method overloading
    void area(int side) {
        System.out.println("Area of Square: " + (side * side));
    }

    void area(int length, int breadth) {
        System.out.println("Area of Rectangle: " + (length * breadth));
    }
}

// parent class
class Hillstations {

    void famousfood() {
        System.out.println("General Hill Food");
    }

    void famousfor() {
        System.out.println("Scenic Beauty");
    }
}

// subclasses
class Manali extends Hillstations {

    void famousfood() {
        System.out.println("Siddu");
    }

    void famousfor() {
        System.out.println("Snow and Adventure");
    }
}

class Mussoorie extends Hillstations {

    void famousfood() {
        System.out.println("Maggi");
    }

    void famousfor() {
        System.out.println("Hill Views");
    }
}

class Gulmarg extends Hillstations {

    void famousfood() {
        System.out.println("Kashmiri Cuisine");
    }

    void famousfor() {
        System.out.println("Skiing");
    }
}

public class overloading_and_overriding {

    public static void main(String[] args) {

        // Part 1: Method Overloading
        System.out.println("---- Shapes ----");
        Shapes s1 = new Shapes(5.0);
        Shapes s2 = new Shapes(4.0, 6.0);
        Shapes s3 = new Shapes(3.0, 4.0, true);

        Shapes s = new Shapes(1.0);
        s.area(5);
        s.area(4, 6);

        System.out.println();

        // Part 2: Method Overriding
        System.out.println("---- Hillstations ----");

        Hillstations h;

        h = new Manali();
        h.famousfood();
        h.famousfor();

        h = new Mussoorie();
        h.famousfood();
        h.famousfor();

        h = new Gulmarg();
        h.famousfood();
        h.famousfor();
    }
}