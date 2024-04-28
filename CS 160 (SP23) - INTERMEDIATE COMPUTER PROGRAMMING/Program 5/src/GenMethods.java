/**
 *  Program 5
 *  This program contains generic class and generic methods, used to do a variety of task that can apply to any input data type.
 *  CS160-3
 *  March 19, 22
 *  @author  Jenny(My) Tran
 */

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;       // Helpful for sorting
import java.util.Collections;  // Helpful for sorting
import java.util.HashSet;      // Helpful for keeping only unique items in a collection
import java.util.Random;
import java.util.Vector;

public class GenMethods<E> {

    /**
     * Remove repeating elements
     *
     * @param list
     * @return ArrayList<E>
     */
    public static <E> ArrayList<E> removeDuplicates(ArrayList<E> list){
     ArrayList<E> newArray = new ArrayList<E>();
     E temp;

         int j = 0;

         for (int i = 0; i < list.size(); i++) {
             if (!(newArray.contains(list.get(i)))) {
                 newArray.add(list.get(i));
             }
         }

         return newArray;
     }

    /**
     * Mix elements up
     *
     * @param list, seed
     * @return String
     */
     public static <E> String randomize(Vector<E> list, long seed) {
            Random rand = new Random(seed);
            for (int i = 0; i < 30; i++) {
                int num1 = rand.nextInt(list.size());
                int num2 = rand.nextInt(list.size());

                E temp = list.get(num1);

                list.set(num1, list.get(num2));
                list.set(num2, temp);
            }
            return list.toString();
        }

    /**
     * Find second to the smallest value
     *
     * @param list
     * @return E
     */
        public static <E extends Comparable<E>> E secondMin(ArrayList<E> list) {
            ArrayList<E> noDupList = removeDuplicates(list);
            E min = noDupList.get(0);
            E nextMin = noDupList.get(1);
            E temp;
            if (min.compareTo(nextMin) > 0) {
                temp = min;
                min = nextMin;
                nextMin = temp;
            }
            for (int i = 2; i < noDupList.size(); i++) {
                temp = noDupList.get(i);
                if (temp.compareTo(min) < 0) {
                    nextMin = min;
                    min = temp;
                } else if (temp.compareTo(nextMin) < 0) {
                    nextMin = temp;
                }
            }
            return nextMin;
        }

    /**
     * Perform a binary search
     *
     * @param list, key
     * @return int
     */
        public static <E extends Comparable<E>> int binarySearch(E[] list, E key) {
            int low = 0;
            int high = list.length - 1;
            while (low <= high) {
                int mid = (low + high) / 2;
                if (list[mid].compareTo(key) == 0) {
                    return mid;
                } else if (list[mid].compareTo(key) < 0) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            return -1;
        }

        /**
         * Find second to the smallest value
         *
         * @param list
         * @return E
         */
        public static <E extends Comparable<E>> E secondMin(E[] list) {
            E min = list[0];
            E nextMin = list[1];
            E temp;
            if (min.compareTo(nextMin) > 0) {
                temp = min;
                min = nextMin;
                nextMin = temp;
            }
            for (int i = 2; i < list.length; i++) {
                temp = list[i];
                if (temp.compareTo(min) < 0) {
                    nextMin = min;
                    min = temp;
                } else if (temp.compareTo(nextMin) < 0) {
                    nextMin = temp;
                }
            }
            return nextMin;
        }



        public static <E extends Comparable<E>> E min(E[][] list) {
            E min = list[0][0];
            for (int i = 0; i < list.length; i++) {
                for (int j = 0; j < list[i].length; j++) {
                    if (list[i][j].compareTo(min) < 0) {
                        min = list[i][j];
                    }
                }
            }
            return min;
        }

    }
