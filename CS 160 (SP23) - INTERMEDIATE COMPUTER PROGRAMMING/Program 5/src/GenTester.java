import java.util.ArrayList;    
import java.util.Arrays;       // Helpful for sorting
import java.util.Collections;  // Helpful for sorting
import java.util.HashSet;      // Helpful for keeping only unique items in a collection
import java.util.Random;
import java.util.Vector;

public class GenTester {

	public static void main(String[] args) {
		GenMethods gen = new GenMethods();

      // Your test code here
		ArrayList<Integer> testInt = new ArrayList<Integer>();
		testInt.add(1);
		testInt.add(1);
		testInt.add(3);
		testInt.add(4);
		testInt.add(4);
		testInt.add(1);

		ArrayList<Integer> noDupArray = gen.removeDuplicates(testInt);
		for(int i = 0; i < noDupArray.size(); i++){
			System.out.println(noDupArray.get(i));
		}

	}
}