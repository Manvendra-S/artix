#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    char* line;
    struct Node* next;
} Node;

Node* createNode(const char* line) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (newNode) {
        newNode->line = strdup(line); // strdup duplicates the input string
        newNode->next = NULL;
    }
    return newNode;
}

void addLine(Node** head, const char* line, int n) {
    Node* newNode = createNode(line);

    if (!newNode)
        return;

    Node** current = head;
    int count = 0;
    while (*current) {
        current = &(*current)->next;
        count++;
    }

    if (count >= n) {
        Node* temp = *head;
        *head = (*head)->next;
        free(temp->line);
        free(temp);
    }

    *current = newNode;
}

void printLines(Node* head) {
    Node* current = head;
    while (current) {
        printf("%s", current->line);
        current = current->next;
    }
}

void freeList(Node* head) {
    while (head) {
        Node* temp = head;
        head = head->next;
        free(temp->line);
        free(temp);
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <n>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    if (n <= 0) {
        fprintf(stderr, "Invalid value of n. Please provide a positive integer.\n");
        return 1;
    }

    char* line = NULL;
    size_t bufferSize = 0;
    Node* head = NULL;

    while (getline(&line, &bufferSize, stdin) != -1) {
        addLine(&head, line, n);
    }

    printLines(head);

    freeList(head);
    free(line);

    return 0;
}
