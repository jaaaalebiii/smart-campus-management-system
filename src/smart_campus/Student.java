package smart_campus;

public class Student {
    long prn;
    String name;
    String branch;

    public Student(long prn, String name, String branch) {
        this.prn = prn;
        this.name = name;
        this.branch = branch;
    }

    public void display() {
        System.out.println(prn + " " + name + " " + branch);
    }
}