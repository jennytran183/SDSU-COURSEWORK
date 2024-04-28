/**
 *  Program 6
 *  This program create a class of Dynamic Array which provides a more flexible type of array that teh user can add or remove elements.
 *  This program contains an interface ListADT, the abstract class AbstractListADT implementing ListADT and the DynamicArray class which extends from AbstractListADT and implementing ListADT
 *  CS160-3
 *  April 16, 2023
 *  @author  Jenny(My) Tran
 */
public interface ListADT<E> {
        /** THE STUDENT MUST WRITE THE METHOD HEADERS. THE FIRST ONE IS DONE FOR YOU **/

	/**
	 * Appends the specified element to the end of this list
	 * @param data
	 * @return boolean
	 */
      public boolean add(E data);

	/**
	 * Inserts the specified element at the specified position in this list.
	 * Shifts the element currently at that position (if any) and any subsequent
	 * elements by adding one to their indices.
	 * @param index - index at which the specified element is to be inserted
	 * @param data - element to be inserted
	 * @return boolean
	 * @throws IndexOutOfBoundsException - if the index is out of range (index < 0 || index > size())
	 */
	public boolean add(int index, E data) throws IndexOutOfBoundsException;
	
	/**
	 * Removes all of the elements from this list
	 */
	public void clear();

	/**
	 * Returns true if this list contains the specified element
	 * @param data
	 * @return boolean
	 */
	public boolean contains (E data);

	/**
	 * Returns the element at the specified position in this list
	 * @param index
	 * @return E
	 */
	public E get (int index);

	/**
	 * Returns the index of the first occurrence of the specified element in this list
	 * Return, or -1 if this list does not
	 * contain the element
	 * @param data
	 * @return int
	 */
	public int indexOf(E data);

	/**
	 * Returns the index of the last matching of the element in this list
	 * Return -1 if no match
	 * @param data
	 * @return int
	 */
	public int lastIndexOf(E data);

	/**
	 * Returns true if this list contains no elements
	 * @return boolean
	 */
	public boolean isEmpty();

	/**
	 * Removes the  element at the specified position in this list.
	 * Shifts any subsequent elements by subtracting one from their indices.
	 * @param index - index of the element to be removed
	 * @return E - the element that was removed from the list
	 * IndexOutOfBoundsException - if the index is out of range (index < 0 || index >= size())
	 */
	public E remove(int index);

	/**
	 * Trims the capacity of this ArrayList instance to be the list's current size. An application can use this
	 * operation to minimize the storage of an ArrayList instance.
	 */
	public void trimToSize();
	 
	/**
	 * Returns the number of elements in this list
	 * @return int
	 */
	public int size();

	public String toString();

}
