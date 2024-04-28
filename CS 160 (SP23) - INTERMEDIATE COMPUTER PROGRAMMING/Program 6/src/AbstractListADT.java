/**
 *  Program 6
 *  This program create a class of Dynamic Array which provides a more flexible type of array that teh user can add or remove elements.
 *  This program contains an interface ListADT, the abstract class AbstractListADT implementing ListADT and the DynamicArray class which extends from AbstractListADT and implementing ListADT
 *  CS160-3
 *  April 16, 2023
 *  @author  Jenny(My) Tran
 */
public abstract class AbstractListADT<E> implements ListADT<E> {

	protected int size;
	
	public AbstractListADT() {
	}

	@Override
	public boolean isEmpty() {
		return this.size == 0;
	}

	@Override
	public int size() {
		return this.size;
	}

}