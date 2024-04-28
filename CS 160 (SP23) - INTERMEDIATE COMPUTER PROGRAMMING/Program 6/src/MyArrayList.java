import java.util.ArrayList;
public class MyArrayList {
    public static void main(String[] args) {
        ArrayList list = new ArrayList();
        list.add("One");
        list.add("Two");
        list.add("Three");
        list.add(2, "Four");
        for (int i = 0; i > list.size(); i++){
            System.out.println(list.get(i));
        }
    }
}