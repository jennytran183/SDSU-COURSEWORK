//Project Name: Simple Round Robin Scheduler using Circular Doubly Linked List
//Author: My (Jenny) Tran
//Date of Completion: Feb 23, 2024
#include <iostream>
#include <string>
using namespace std;

// Data Class: This is what goes inside the Node
class Process {
public:
    string processName;
    int totalTime;

    // Constructor
    Process(string processName, int totalTime) {
        this->processName = processName;
        this->totalTime = totalTime;
    }

    // Updates the remaining time of the process after each quantum cycle
    void updateRunTime(int qTime) {
        this->totalTime = this->totalTime - qTime;
    }

    // Prints the details of the process
    void print() {
        cout << "Process " << processName << " " << totalTime << " seconds" << endl;
    }

    // Returns the remaining time of the process
    int getTime() {
        return totalTime;
    }
};

// Node Class: Node for the doubly linked list
template <typename T> class Node {
public:
    T *data;
    Node<T> *next;
    Node<T> *prev;

    // Constructor
    Node(T *data) {
        this->data = data;
        next = nullptr;
        prev = nullptr;
    }

    // Prints the data of the node
    void print() {
        data->print();
    }
};

// CircularDoublyLinkedList Class: Container for Nodes
template <typename T> class CircularDLL {
private:
    Node<T> *curr;
    Node<T> *head;
    Node<T> *tail;
    int length;

public:
    // Constructor: Initializes an empty list with a given initial data
    CircularDLL(T *data) {
        Node<T> *newNode = new Node<T>(data);
        head = newNode;
        tail = newNode;
        length = 1;
    }

    // Destructor: Deletes all nodes and their memory in the list
    ~CircularDLL() {
        Node<T> *temp = head;
        while (head) {
            head = head->next;
            delete temp;
            temp = head;
        }
    }

    // Returns the length of the list
    int getLength() {
        return length;
    }

    // Returns the node at the specified index
    Node<T> *get(int index) {
        if (index < 0 || index >= length)
            return nullptr;
        Node<T> *temp = head;
        for (int i = 0; i < index; ++i) {
            temp = temp->next;
        }
        return temp;
    }

    // Prints the processes in the list
    void printList() {
        int i = 1;
        Node<T> *temp = head;
        while (temp != tail) {
            cout << i << ". ";
            temp->print();
            temp = temp->next;
            i++;
        }
        cout << length << ". ";
        tail->print();
    }

    // Inserts a new process at the end of the list
    void insertProcess(T *data) {
        Node<T> *newNode = new Node<T>(data);
        if (length == 0) {
            head = newNode;
            tail = newNode;
        } else {
            tail->next = newNode;
            newNode->prev = tail;
            newNode->next = head;
            tail = newNode;
        }
        length++;
    }

    // Deletes a process at the specified index
    void deleteProcess(int index) {
        if (index < 0 || index >= length)
            return;
        if (index == 0) {
            if (length == 0)
                return;
            Node<T> *temp = head;
            if (length == 1) {
                head = nullptr;
                tail = nullptr;
            } else {
                head = head->next;
            }
            delete temp;
            length--;
            return;
        }
        if (index == length - 1) {
            if (length == 0)
                return;
            Node<T> *temp = head;
            if (length == 1) {
                head = nullptr;
                tail = nullptr;
            } else {
                Node<T> *pre = head;
                while (temp->next) {
                    pre = temp;
                    temp = temp->next;
                }
                tail = pre;
                tail->next = nullptr;
            }
            delete temp->data;
            delete temp;
            length--;
        }

        Node<T> *prev = get(index - 1);
        Node<T> *temp = prev->next;

        prev->next = temp->next;
        delete temp;
        length--;
    }
};

// Main Program
int main() {
    int qTime;
    int elapseTime = 0;
    char yesno;
    bool addNew;
    int cycle = 1;
    string nProcessName;
    int nProcessTime;
    int traverse = 0;
    int listLength;

    // User input for quantum time
    cout << "Enter Quantum Time: ";
    cin >> qTime;
    cout << "Prepopulating with processes" << endl;

    // Creating data objects
    Process *p1 = new Process("A", 10);
    Process *p2 = new Process("B", 12);
    Process *p3 = new Process("C", 8);
    Process *p4 = new Process("D", 5);
    Process *p5 = new Process("E", 10);

    // Creating Linked List
    CircularDLL<Process> *RRS = new CircularDLL<Process>(p1);
    RRS->insertProcess(p2);
    RRS->insertProcess(p3);
    RRS->insertProcess(p4);
    RRS->insertProcess(p5);

    // Printing the initial list
    RRS->printList();

    // User interaction for adding new processes during scheduling
    while (RRS->getLength() != 0) {
        cout << "Add new process? (Enter Y/N) ";
        cin >> yesno;
        while (yesno == 'Y') {
            cout << "Enter New Process Name: ";
            cin >> nProcessName;
            cout << "Enter New Process Time: ";
            cin >> nProcessTime;
            if (nProcessTime > qTime) {
                RRS->insertProcess(new Process(nProcessName, nProcessTime));
            }
            cout << "Process Added." << endl;
            cout << "Add new process? (Enter Y/N) ";
            cin >> yesno;
        }

        // Running the scheduling cycle
        cout << "Running Cycle " << cycle << endl;
        elapseTime += qTime;
        traverse = 0;

        listLength = RRS->getLength();
        for (int i = 0; i < listLength; i++) {
            RRS->get(traverse)->data->updateRunTime(qTime);
            if (RRS->get(traverse)->data->getTime() <= 0) {
                RRS->deleteProcess(traverse);
            } else {
                traverse++;
            }
        }

        // Printing the state of processes after the cycle
        cout << "After cycle " << cycle << " - " << elapseTime << " second elapses - state of processes is as follows:" << endl;
        if (RRS->getLength() > 0) {
            RRS->printList();
        }
        cycle++;
    }

    cout << "All processes are completed." << endl;

    return 0;
}
