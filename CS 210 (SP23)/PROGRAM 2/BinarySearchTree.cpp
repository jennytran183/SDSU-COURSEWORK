#include <iostream>
using namespace std;

// Data Class : Holds all the data that goes inside the Node
class Data {
private:
    int value;
public:
    Data(int val) {
        this->value = val;
    }

    void setValue(int val){this->value = val;}
    int getValue(){return this->value; }

    void print() {
        cout << value << " " << endl;
    }
};

// Node Class : Node for the Binary Search Tree
template <typename T> class Node {
private:
    T* data;
    Node<T>* leftChild;
    Node<T>* rightChild;
    Node<T>* parent;

public:
    Node(T *data) {
        this->data = data;
        leftChild = nullptr;
        rightChild = nullptr;
        parent = nullptr;
    }

    void print() { this->data->print(); }

    void setData(Data data){this->data = data;}
    T* getData(){return this->data; }

    void setVal(int value){this->data->setValue(value);}
    int getVal(){return this->data->getValue();}

    void setLeftChild(Node<T>* newChild){this->leftChild = newChild;}
    Node<T>* getLeftChild(){return this->leftChild; }

    void setRightChild(Node<T>* newChild){this->rightChild = newChild;}
    Node<T>* getRightChild(){return this->rightChild; }

    void setParent(Node<T>* newParent){this->parent = newParent;}
    Node<T>* getParent(){return this->parent; }
};

// Binary Search Tree Class: Container for Nodes
template <typename T> class BinarySearchTree {
private:
    Node<T> *root;
    int numberOfElements;
    int height;
    int countArr = 0;
    int inorderArr[99999999]; // Array to store inorder traversal

public:
    // Constructor: Initializes an empty list with a given initial data
    BinarySearchTree(T *data) {
        Node<T> *newNode = new Node<T>(data);
        root = newNode;
        numberOfElements = 1;
        height = 0;
    }

    // Destructor: Deletes all nodes and their memory in the list
    ~BinarySearchTree() {
        // Call a helper function to delete all nodes recursively
        deleteTree(root);
    }

// Helper function to recursively delete all nodes in the binary search tree
    void deleteTree(Node<T>* node) {
        if (node == nullptr) {
            return;
        }

        // Recursively delete left and right subtrees
        deleteTree(node->getLeftChild());
        deleteTree(node->getRightChild());

        // Delete the current node
        delete node;
    }


    void setRoot(Node<T> *newRoot) { this->root = newRoot; }

    Node<T> *getRoot() { return this->root; }

    void setNumberOfElements(int newNum) { this->numberOfElements = newNum; }

    int getnumberOfElements() { return this->numberOfElements; }

    void setHeight(int newHeight) { this->height = newHeight; }

    int getHeight() { return this->height; }

    // Preorder traversal for printing the tree
    void preorder(Node<T> *root){
        if (root != NULL){
            cout << root->getVal() << ", ";
            preorder(root->getLeftChild());
            preorder(root->getRightChild());
        }
    }

    // Print the binary search tree in preorder
    void print() {
        preorder(this->root);
        cout << endl;
    }

    // Helper function for sorting the tree in ascending order
    void sortAscend(Node<T>* node)
    {
        if (node == NULL) {
            return;
        }
        //Traverse left subtree
        sortAscend(node->getLeftChild());
        //Adding elements
        inorderArr[countArr] = node->getVal();
        countArr++;
        //Traverse right subtree
        sortAscend(node->getRightChild());
    }

    // Find the kth element in the binary search tree
    void findKthElement(int k) {
        if (k > this->getnumberOfElements()){
            cout << "Number does not exist" << endl;
            return;
        }
        sortAscend(root);
        int val = inorderArr[k - 1];
        Node<T>* kth = find(val);
        cout << kth->getVal() << endl;
    }

    // Find a node with a given value in the binary search tree
    Node<T>* find(int value){
        Node<T> *temp = root;
        if (temp == NULL){
            return NULL;
        }
        else {
            while (temp != NULL && temp->getVal() != value){
                if (value < temp->getVal()){
                    temp = temp->getLeftChild();
                }
                else{
                    temp = temp->getRightChild();
                }
            }
            return temp;
        }
    }

    // Insert a new element into the binary search tree
    void insertElement(T *data) {
        this->setNumberOfElements(this->getnumberOfElements() + 1);
        Node<T> *temp = root;
        Node<T> *newNode = new Node<T>(data);
        while (true) {
            if (temp == nullptr) {
                temp = newNode;
                return;
            } else if (newNode->getVal() < temp->getVal()) {
                if (temp->getLeftChild() == NULL) {
                    newNode->setParent(temp);
                    temp->setLeftChild((newNode));
                    return;
                } else {
                    temp = temp->getLeftChild();
                }
            } else if (newNode->getVal() > temp->getVal()) {
                if (temp->getRightChild() == NULL) {
                    newNode->setParent(temp);
                    temp->setRightChild((newNode));
                    return;
                } else {
                    temp = temp->getRightChild();
                }
            }
        }
    }

    // Helper function for deleting a node from the binary search tree
    Node<T>* deleteEleHelper(Node<T>* root, int val)
    {
        // Base case
        if (root == NULL)
            return root;

        //Recursive calls
        if (root->getVal() > val) {
            root->setLeftChild(deleteEleHelper(root->getLeftChild(), val));
            return root;
        }
        else if (root->getVal() < val) {
            root->setRightChild(deleteEleHelper(root->getRightChild(), val));
            return root;
        }

        //Case: 1 child
        if (root->getLeftChild() == NULL) {
            Node<T>* temp = root->getRightChild();
            delete root;
            return temp;
        }
        else if (root->getRightChild() == NULL) {
            Node<T>* temp = root->getLeftChild();
            delete root;
            return temp;
        }

            //CASE: 2 children
        else {

            Node<T>* replaceParent = root;

            // Find new replacement child
            Node<T>* replace = root->getLeftChild();
            while (replace->getRightChild() != NULL) {
                replaceParent = replace;
                replace = replace->getRightChild();
            }

            if (replaceParent != root)
                replaceParent->setRightChild(replace->getLeftChild());
            else
                replaceParent->setLeftChild(replace->getLeftChild());

            root->setVal(replace->getVal());
            delete replace;
            return root;
        }
    }

    // Delete a node with the given data from the binary search tree
    void deleteElement(T *data) {
        Node<T> *temp = find(data->getValue());
        if(temp != NULL){
            root = deleteEleHelper(root, data->getValue());
            this->setNumberOfElements(this->getnumberOfElements() - 1);
        }
        else{
            cout <<"Number does not exist" << endl;
        }
    }

    // Find the smallest element in the binary search tree
    void findSmallest() {
        Node<T> *temp = root;
        while (temp->getLeftChild() != nullptr){
            temp = temp->getLeftChild();
        }
        temp->print();
    }

    // Find the biggest element in the binary search tree
    void findBiggest() {
        Node<T> *temp = root;
        while (temp->getRightChild() != nullptr){
            temp = temp->getRightChild();
        }
        temp->print();
    }

    // Sort the binary search tree in ascending order
    void sortAscending() {
        sortAscend(root);
        int count = 0;
        while (count < this->getnumberOfElements() - 1 ){
            cout << inorderArr[count] << ", ";
            count++;
        }
        cout << inorderArr[count] << " ";
        cout << endl;
    }

    // Sort the binary search tree in descending order
    void sortDescending() {
        sortAscend(root);
        int count = getnumberOfElements() - 1;
        while (count > 0 ){
            cout << inorderArr[count] << ", ";
            count--;
        }
        cout << inorderArr[count] << " ";
        cout << endl;
    }
};

// Main function to test the binary search tree implementation
int main() {
    int a[] = {10,45,23,67,89,34,12,99};
    Data* newData = new Data(a[0]);
    BinarySearchTree<Data>* newBST = new BinarySearchTree<Data>(newData);
    for(int i=1;i< (sizeof(a)/sizeof(int));i++)
    {
        newData = new Data(a[i]);
        newBST->insertElement(newData);
    }
    newBST->print();
    newBST->findSmallest();
    newBST->findBiggest();
    newData = new Data(10);
    newBST->deleteElement(newData); // delete root
    newBST->print();
    newData = new Data(45);
    newBST->deleteElement(newData); //delete with two children
    newBST->print();
    newData = new Data(12);
    newBST->deleteElement(newData); //delete with one child
    newBST->print();
    newData = new Data(10);
    newBST->deleteElement(newData); // delete a number that doesn't exist. What will you print?
    newBST->print();
    newBST->findKthElement(1); //first element
    newBST->findKthElement(newBST->getnumberOfElements()); //last element
    newBST->findKthElement(3); // some element in between
    newBST->findKthElement(7); // Edge case where item does not exist. What will you print?
    newBST->findSmallest();
    newBST->findBiggest();
    newBST->sortAscending();
    newBST->sortDescending();
    return 0;
}