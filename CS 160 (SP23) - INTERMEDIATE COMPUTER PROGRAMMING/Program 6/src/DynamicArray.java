/**
 *  Program 6
 *  This program create a class of Dynamic Array which provides a more flexible type of array that teh user can add or remove elements.
 *  This program contains an interface ListADT, the abstract class AbstractListADT implementing ListADT and the DynamicArray class which extends from AbstractListADT and implementing ListADT
 *  CS160-3
 *  April 16, 2023
 *  @author  Jenny(My) Tran
 */
import java.util.ArrayList;
import java.util.Arrays;

public class DynamicArray<E> extends AbstractListADT<E> implements ListADT <E> {
    private E[] myList;
    private int capacity;
    public int size;

    //Constructor with no parameter
    @SuppressWarnings("unchecked")
    public DynamicArray(){
        myList = (E[]) new Object[10];
    }

    //Constructor with @param int capacity
    public DynamicArray(int capacity){
        if(capacity < 0 ){
            throw new IllegalArgumentException();
        }
        this.capacity = capacity;
        myList = (E[]) new Object[capacity];
    }

    /**
     * Appends the specified element to the end of this list
     * @param data
     * @return boolean
     */

    public boolean add(E data) {
        if (size == myList.length) {
            capacity++;
            E[] newList = Arrays.copyOf(myList, capacity);
            myList = newList;
        }
        myList[size++] = data;
        return true;
    }
    /**
     * Inserts the specified element at the specified position in this list.
     * Shifts the element currently at that position (if any) and any subsequent
     * elements by adding one to their indices.
     * @param index - index at which the specified element is to be inserted
     * @param data - element to be inserted
     * @return boolean
     * @throws IndexOutOfBoundsException - if the index is out of range (index < 0 || index > size())
     */

    public boolean add(int index, E data) throws IndexOutOfBoundsException {
        if (index < 0 || index > this.size()) {
            throw new IndexOutOfBoundsException();
        }
        if (size == myList.length) {
            capacity++;
            E[] newList = Arrays.copyOf(myList, capacity);
            myList = newList;
        }
        for (int i = myList.length - 1; i > index; i--) {
            myList[i] = myList[i - 1];
        }
        myList[index] = data;
        size++;
        return true;
    }

    /**
     * Removes all of the elements from this list
     */
    public void clear() {
        E[] emptyList = (E[]) new Object[myList.length];
        myList = emptyList;
        size = 0;
    }

    /**
     * Returns true if this list contains the specified element
     * @param data
     * @return boolean
     */
    @Override
    public boolean contains (E data) {
        for (int i = 0; i < size; i++) {
            if (myList[i].equals(data)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Returns the element at the specified position in this list
     * @param index
     * @return E
     */
    @Override
    public E get (int index){
        if (index < 0 || index > myList.length) {
            throw new IndexOutOfBoundsException();
        }
        E data = myList[index];
        return data;
    }

    /**
     * Returns the index of the first occurrence of the specified element in this list
     * Return, or -1 if this list does not
     * contain the element
     * @param data
     * @return int
     */
    @Override
    public int indexOf(E data) {
        for (int i = 0; i < myList.length; i++) {
            if (myList[i].equals(data)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Returns the index of the last matching of the element in this list
     * Return -1 if no match
     * @param data
     * @return int
     */
    @Override
    public int lastIndexOf(E data) {
        for (int i = myList.length - 1; i < 0; i--) {
            if (myList[i].equals(data)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Returns true if this list contains no elements
     * @return boolean
     */
    @Override
    public boolean isEmpty() {
        return this.size() == 0;
    }


    /**
     * Removes the  element at the specified position in this list.
     * Shifts any subsequent elements by subtracting one from their indices.
     * @param index - index of the element to be removed
     * @return E - the element that was removed from the list
     * IndexOutOfBoundsException - if the index is out of range (index < 0 || index >= size())
     */
    public E remove(int index) {
        if (index < 0 || index > this.size()) {
            throw new IndexOutOfBoundsException();
        }
        E data = myList[index];
        for (int i = index; i < size - 1; i++) {
            myList[i] = myList[i+1];
        }
        myList[size - 1] = null;
        size--;
        return data;
    }

    /**
     * Trims the capacity of this ArrayList instance to be the list's current size. An application can use this
     * operation to minimize the storage of an ArrayList instance.
     */
    @Override
    public void trimToSize() {
            E[] temp = Arrays.copyOf(myList, size);
            myList = temp;
    }
    /**
     * Returns the number of elements in this list
     * @return int
     */
    @Override
    public int size(){
        return size;
    }

    /**
     * Returns the Program name and author
     * @return String
     */
    public String getIdentificationString(){
        return "Program 6, Jenny(My) Tran";
    }

    /**
     * Returns the list's capacity
     * @return int
     */
    public int getCapacity(){
        return capacity;
    }

    /**
     * Returns the list in readable form
     * @return String
     */
    public String toString(){
        String printA = "";
        for (int i = 0; i < size - 1; i++){
            printA += myList[i] + ", ";
        }
        return "[" + printA + myList[size - 1] + "]";
    }


    public static void main(String[] args) {
        DynamicArray<String> list = new DynamicArray(9);
        list.add("One");
        list.add("Two");
        list.add("Three");
        list.add(2, "Four");
        System.out.println(list.toString());

    }
}

