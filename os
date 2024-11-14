*****************************************************************************

1) Print Sum of Digits of a given number using command line argument
CODE:
#!/bin/bash
if [ $# -eq 0 ]; then
  echo "No arguments provided"
  exit 1
fi
number=$1
sum=0
while [ $number -gt 0 ]
do
  digit=`expr $number % 10`
  sum=`expr $sum + $digit`
  number=`expr $number / 10`
done
echo "Sum of digits: $sum"

OUPUT:
ruapli@ruapli-VirtualBox:~$ bash os_lab.sh 1234
Sum of digits: 10

1)2.Write a shell script using function for following:1) average of given numbers 2) Max digit from given number and 3) min digit from given number
CODE:
#!/bin/bash
average() {
  sum=0
  count=$#
  for num in "$@"
   do
    sum=`expr $sum + $num`
  done
  avg=`expr $sum / $count`
  echo "Average: $avg"
}
max_digit() {
  number=$1
  max=0
  while [ $number -gt 0 ]
do
    digit=`expr $number % 10`
    if [ $digit -gt $max ]
    then
      max=$digit
    fi
    number=`expr $number / 10`
  done
  echo "Max digit: $max"
}
min_digit() {
  number=$1
  min=9
  while [ $number -gt 0 ]
do
    digit=`expr $number % 10`
    if [ $digit -lt $min ]
then
      min=$digit
    fi
    number=`expr $number / 10`
  done
  echo "Min digit: $min"
}
use() {
  echo "Use:"
  echo "$0 average <num1> <num2> ..."
  echo "$0 max_digit <number>"
  echo "$0 min_digit <number>"
}
if [ $# -lt 2 ]
then
  use
  exit 1
fi
operation=$1
shift
case $operation in
  average)
    if [ $# -lt 1 ]
    then
      echo "Error: At least one number is required for average calculation."
      exit 1s
    fi
    average "$@"
    ;;
  max_digit)
    if [ $# -ne 1 ]
    then
      echo "Error: Exactly one number is required for max digit calculation."
      exit 1
    fi
    max_digit "$1"
    ;;
  min_digit)
    if [ $# -ne 1 ]
    then
      echo "Error: Exactly one number is required for min digit calculation."
      exit 1
    fi
    min_digit "$1"
    ;;
  *) 
    echo "Error: Unknown operation '$operation'."
    use
    exit 1
    ;;
esac

OUTPUT:
ruapli@ruapli-VirtualBox:~$ bash os.sh average 2 3 4 5 6
Average: 4
ruapli@ruapli-VirtualBox:~$ bash os.sh max_digit 1234
Max digit: 4
ruapli@ruapli-VirtualBox:~$ bash os.sh min_digit 1234
Min digit: 1

1)3.Perform sorting on given array elements
CODE:
bubble_sort() {
  array=("$@")
  n=${#array[@]}
  for ((i = 0; i < n; i++))
 do
    for ((j = 0; j < n - i - 1; j++))
do
      if [ "${array[j]}" -gt "${array[j+1]}" ]
then
        temp=${array[j]}
        array[j]=${array[j+1]}
        array[j+1]=$temp
      fi
    done
  done
  echo "${array[@]}"
}
if [ $# -eq 0 ]
then
  echo "No arguments provided"
  exit 1
fi

sorted_array=($(bubble_sort "$@"))
echo "Sorted array: ${sorted_array[@]}"
OUTPUT:
ruapli@ruapli-VirtualBox:~$ bash os_lab1.sh 2 5 4 5 2
Sorted array: 2 2 4 5 5

1)4. Program to find factorial of a given number with and without recursion
CODE:
#!/bin/bash
factorial_recursive() {
  if [ $1 -le 1 ]
  then
    echo 1
  else
    prev=$(factorial_recursive $(( $1 - 1 )))
    echo $(( $1 * prev ))
  fi
}
factorial_without_recursion() {
fact=$1
f=1
  while [ $fact -gt 0 ]
  do
    f=`expr $f \* $fact`
    fact=`expr $fact - 1`
  done
  return $f
}
if [ $# -eq 0 ]
then
  echo "No arguments provided"
  exit 1
fi
result=$(factorial_recursive $1)
echo "Factorial (recursive): $result"
factorial_without_recursion $1
echo "Factorial without_recursion: $?"

OUTPUT:
ruapli@ruapli-VirtualBox:~$ bash os_lab4.sh 5
Factorial (recursive): 120
Factorial without_recursion: 120

1)5.Program to check file type and permission for a given file
CODE:
#!/bin/bash
if [ $# -eq 0 ]; then
  echo "No arguments provided"
  exit 1
fi
file=$1
if [ -e "$file" ]           # -e != -d
then
  echo "File type:"
  ch=`ls -l $file | cut -c 1`
 # file "$file"
 # echo "Permissions:"
 # ls -l "$file" | awk '{print $1}'
 case "$ch" in
    -) echo "ordinary file" ;;
    b) echo "block special file" ;;
    c) echo "character special file" ;;
    d) echo "directory" ;;
    l) echo "symbolic link" ;;
    s) echo "socket file" ;;
    p) echo "FIFO (named pipe)" ;;
    *) echo "unknown type" ;;
  esac
 echo "Permissions:"
 ls -l "$file" | awk '{print $1}'
else
  echo "File does not exist"
fi

OUTPUT:
ruapli@ruapli-VirtualBox:~$ bash os_lab3.sh bi.txt
File type:
ordinary file
Permissions:
-rw-rw-r--

1)6. Check entered string is palindrome or not?
CODE:
#!/bin/bash
if [ $# -eq 0 ]; then
  echo "No arguments provided"
  exit 1
fi
str=$1
len=${#str}
is_palindrome=1
while [ $i -le $len ]
do
ch1=`echo $str | cut -c $i`
ch2=`echo $str | cut -c $len`
 if [ $ch1 != $ch2 ]
 then
    is_palindrome=0
    break
  fi
i=`expr $i + 1`
len=`expr $len - 1`
done
if [ $is_palindrome -eq 1 ]; then
  echo "The string '$str' is a palindrome"
else
  echo "The string '$str' is not a palindrome"
fi

*****************************************************************************
2)//2.Write a program demonstrating use of different system calls. 

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <sys/utsname.h>

// Process related system calls
void fork_example();
void exit_example();
void wait_example();
void kill_example();
void exec_example();

// File related system calls
void open_read_write_example();
void link_unlink_example();
void stat_example();

// Communication related system calls
void pipe_example();
void fifo_example();

// Information related system calls
void getpid_example();
void getppid_example();
void uname_example();

int main() {
    int choice;
    while(1) {
        printf("\nMenu Driven System Call Demonstration\n");
        printf("1. Process related system calls\n");
        printf("2. File related system calls\n");
        printf("3. Communication related system calls\n");
        printf("4. Information related system calls\n");
        printf("5. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);
        switch(choice) {
            case 1:
                printf("1. Fork\n2. Exit\n3. Wait\n4. Kill\n5. Exec\n");
                printf("Enter your choice: ");
                scanf("%d", &choice);
                if(choice == 1) fork_example();
                else if(choice == 2) exit_example();
                else if(choice == 3) wait_example();
                else if(choice == 4) kill_example();
                else if(choice == 5) exec_example();
                break;
            case 2:
                printf("1. Open, Read, Write, Close\n2. Link, Unlink\n3. Stat\n");
                printf("Enter your choice: ");
                scanf("%d", &choice);
                if(choice == 1) open_read_write_example();
                else if(choice == 2) link_unlink_example();
                else if(choice == 3) stat_example();
                break;
            case 3:
                printf("1. Pipe\n2. FIFO\n");
                printf("Enter your choice: ");
                scanf("%d", &choice);
                if(choice == 1) pipe_example();
                else if(choice == 2) fifo_example();
                break;
            case 4:
                printf("1. Get PID\n2. Get PPID\n3. Uname\n");
                printf("Enter your choice: ");
                scanf("%d", &choice);
                if(choice == 1) getpid_example();
                else if(choice == 2) getppid_example();
                else if(choice == 3) uname_example();
                break;
            case 5:
                exit(0);
            default:
                printf("Invalid choice! Please try again.\n");
        }
    }
    return 0;
}

// Process related system calls
void fork_example() {
    pid_t pid = fork();
    if (pid == 0) {
        printf("Child process: PID = %d\n", getpid());
    } else {
        printf("Parent process: PID = %d\n", getpid());
        wait(NULL); // Wait for child to finish
    }
}

void exit_example() {
    printf("This process will terminate using exit().\n");
    exit(0);
}

void wait_example() {
    pid_t pid = fork();
    if (pid == 0) {
        printf("Child process running. PID = %d\n", getpid());
        sleep(2); // Simulate some work in child
        exit(0);
    } else {
        printf("Parent waiting for child to terminate.\n");
        wait(NULL);
        printf("Child terminated.\n");
    }
}

void kill_example() {
    pid_t pid = fork();
    if (pid == 0) {
        printf("Child process running. PID = %d\n", getpid());
        while(1); // Infinite loop
    } else {
        sleep(1);
        printf("Killing child process.\n");
        kill(pid, SIGKILL); // Terminate the child process
        wait(NULL);
    }
}

void exec_example() {
    pid_t pid = fork();
    if (pid == 0) {
        execl("/bin/ls", "ls", NULL); // Replace child process with `ls` command
    } else {
        wait(NULL);
    }
}

// File related system calls
void open_read_write_example() {
    int fd;
    char buffer[100];
    fd = open("testfile.txt", O_CREAT | O_RDWR, 0644);
    if (fd == -1) {
        perror("Error opening file");
        return;
    }
    write(fd, "Hello, World!\n", 14);
    lseek(fd, 0, SEEK_SET); // Move to beginning of the file
    read(fd, buffer, sizeof(buffer));
    printf("File content: %s\n", buffer);
    close(fd);
}

void link_unlink_example() {
    link("testfile.txt", "testfile_link.txt");
    printf("Link created.\n");
    unlink("testfile_link.txt");
    printf("Link removed.\n");
}

void stat_example() {
    struct stat fileStat;
    if(stat("testfile.txt",&fileStat) < 0) {
        perror("Error getting file stats");
        return;
    }
    printf("Information for testfile.txt:\n");
    printf("File Size: \t\t%ld bytes\n", fileStat.st_size);
    printf("Number of Links: \t%ld\n", fileStat.st_nlink);
    printf("File inode: \t\t%ld\n", fileStat.st_ino);
    printf("File Permissions: \t");
    printf( (S_ISDIR(fileStat.st_mode)) ? "d" : "-");
    printf( (fileStat.st_mode & S_IRUSR) ? "r" : "-");
    printf( (fileStat.st_mode & S_IWUSR) ? "w" : "-");
    printf( (fileStat.st_mode & S_IXUSR) ? "x" : "-");
    printf("\n");
}

// Communication related system calls
void pipe_example() {
    int fd[2];
    pid_t pid;
    char buffer[100];
    if (pipe(fd) == -1) {
        perror("Pipe failed");
        return;
    }
    pid = fork();
    if (pid == 0) {
        // Child process
        close(fd[0]); // Close read end
        write(fd[1], "Hello from child!\n", 18);
        close(fd[1]);
    } else {
        // Parent process
        close(fd[1]); // Close write end
        read(fd[0], buffer, sizeof(buffer));
        printf("Parent received: %s\n", buffer);
        close(fd[0]);
        wait(NULL);
    }
}

void fifo_example() {
    char *fifo = "/tmp/myfifo";
    mkfifo(fifo, 0666);
    if(fork() == 0) {
        int fd = open(fifo, O_WRONLY);
        write(fd, "Hello via FIFO!\n", 16);
        close(fd);
    } else {
        char buffer[100];
        int fd = open(fifo, O_RDONLY);
        read(fd, buffer, sizeof(buffer));
        printf("Parent received: %s\n", buffer);
        close(fd);
        wait(NULL);
    }
    unlink(fifo);
}

// Information related system calls
void getpid_example() {
    printf("Process ID: %d\n", getpid());
}

void getppid_example() {
    printf("Parent Process ID: %d\n", getppid());
}

void uname_example() {
    struct utsname buffer;
    if (uname(&buffer) < 0) {
        perror("Uname failed");
        return;
    }
    printf("Group ID: %d\n", getgid());
    printf("System page size: %ld bytes\n", sysconf(_SC_PAGESIZE));
    printf("System name: %s\n", buffer.sysname);
    printf("Node name: %s\n", buffer.nodename);
    printf("Release: %s\n", buffer.release);
    printf("Version: %s\n", buffer.version);
    printf("Machine: %s\n", buffer.machine);
}

*****************************************************************************
3)//3.Implement multi threading for Matrix Operations using Pthreads.

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#define SIZE 3
int matrix1[SIZE][SIZE], matrix2[SIZE][SIZE], result[SIZE][SIZE];

void *add_matrices(void *arg);
void *subtract_matrices(void *arg);
void *multiply_matrices(void *arg);
void initialize_matrices();
void display_matrix(int matrix[SIZE][SIZE]);

void initialize_matrices() {
    printf("Initializing matrices...\n");
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            matrix1[i][j] = rand() % 10;
            matrix2[i][j] = rand() % 10;
        }
    }
    printf("Matrix 1:\n");
    display_matrix(matrix1);
    printf("Matrix 2:\n");
    display_matrix(matrix2);
}

void display_matrix(int matrix[SIZE][SIZE]) {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

void *add_matrices(void *arg) {
    printf("Thread for Addition started.\n");
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            result[i][j] = matrix1[i][j] + matrix2[i][j];
        }
    }
    printf("Result of Addition:\n");
    display_matrix(result);
    printf("Thread for Addition ended.\n");
    
    int *exit_status = malloc(sizeof(int));  
    *exit_status = 0;
    pthread_exit(exit_status); 
}

void *subtract_matrices(void *arg) {
    printf("Thread for Subtraction started.\n");
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            result[i][j] = matrix1[i][j] - matrix2[i][j];
        }
    }
    printf("Result of Subtraction:\n");
    display_matrix(result);
    printf("Thread for Subtraction ended.\n");
    
    int *exit_status = malloc(sizeof(int)); 
    *exit_status = 1;  
    pthread_exit(exit_status);  
}

void *multiply_matrices(void *arg) {
    printf("Thread for Multiplication started.\n");
    int *k = (int *)malloc(sizeof(int));  // Allocate memory for the pointer
    *k = 1;  // Assign a value to *k

    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            result[i][j] = 0;
            for (*k = 0; *k < SIZE; (*k)++) {  // Use *k as the loop variable
                result[i][j] += matrix1[i][*k] * matrix2[*k][j];
            }
        }
    }
    printf("Result of Multiplication:\n");
    display_matrix(result);
    printf("Thread for Multiplication ended.\n");
    
    free(k); 
    
    int *exit_status = malloc(sizeof(int)); 
    *exit_status = 2;
    pthread_exit(exit_status); 
}

int main() {
    pthread_t tid1, tid2, tid3;
    void *status;

    initialize_matrices();

    if (pthread_create(&tid1, NULL, add_matrices, NULL) != 0) {
        perror("Failed to create thread for addition");
        return 1;
    }
    if (pthread_create(&tid2, NULL, subtract_matrices, NULL) != 0) {
        perror("Failed to create thread for subtraction");
        return 1;
    }
    if (pthread_create(&tid3, NULL, multiply_matrices, NULL) != 0) {
        perror("Failed to create thread for multiplication");
        return 1;
    }

    if (pthread_join(tid1, &status) != 0) {
        perror("Failed to join thread for addition");
        return 1;
    }
    printf("Thread for Addition exited with status: %d\n", *((int *)status));
    free(status);  

    if (pthread_join(tid2, &status) != 0) {
        perror("Failed to join thread for subtraction");
        return 1;
    }
    printf("Thread for Subtraction exited with status: %d\n", *((int *)status));
    free(status);  

    if (pthread_join(tid3, &status) != 0) {
        perror("Failed to join thread for multiplication");
        return 1;
    }
    printf("Thread for Multiplication exited with status: %d\n", *((int *)status));
    free(status);  

    return 0;
}

*****************************************************************************
4)//4.Implementation of Classical problems (reader writer)  using Threads and Mutex
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
pthread_mutex_t mutex; // Mutex for mutual exclusion
pthread_mutex_t wri;   // change it to writer // Condition variable for signaling
int rc = 0;            // Reader count
int x = 0;             // Shared data
void *reader(void *arg)
{
    int id = *((int *)arg);
    // Lock the mutex before checking and modifying the reader count
    pthread_mutex_lock(&mutex);
    rc++;
    if (rc == 1)
    {
        // If this is the first reader, it will block writers
        pthread_mutex_lock(&wri);
    }
    pthread_mutex_unlock(&mutex); // Unlock after modifying the reader count
    // Reading section
    printf("Reader %d is reading \n", id);
    // Lock the mutex to modify the reader count after reading
    pthread_mutex_lock(&mutex);
    rc--;
    if (rc == 0)
    {
        // If this is the last reader, it will signal waiting writers
        pthread_mutex_unlock(&wri);
    }
    pthread_mutex_unlock(&mutex); // Unlock after modifying the reader count
    return NULL; // Return from the reader thread
}
void *writer(void *arg)
{
    // Lock the mutex to gain exclusive access to the shared resource
    pthread_mutex_lock(&mutex);
    // Writing section
    x++;
    printf("The data written: %d \n", x);
    pthread_mutex_unlock(&mutex); // Unlock after writing
    return NULL; // Return from the writer thread
}
int main()
{
    pthread_mutex_init(&mutex, NULL); // Initialize the mutex
    pthread_mutex_init(&wri, NULL);   // Initialize the condition variable
    int r_id[10], w_id[2];
    pthread_t reader_t[10], writer_t[2];
    // Create reader threads
    for (int i = 0; i < 10; i++)
    {
        r_id[i] = i;
        pthread_create(&reader_t[i], NULL, reader, &r_id[i]);
    }
    // Create writer threads
    for (int i = 0; i < 2; i++)
    {
        w_id[i] = i;
        pthread_create(&writer_t[i], NULL, writer, &w_id[i]);
    }
    // Wait for all reader threads to finish
    for (int i = 0; i < 10; i++)
    {
        pthread_join(reader_t[i], NULL);
    }
    // Wait for all writer threads to finish
    for (int i = 0; i < 2; i++)
    {
        pthread_join(writer_t[i], NULL);
    }
    // Clean up
    pthread_mutex_destroy(&mutex);
    pthread_mutex_destroy(&wri);
    return 0;
}
*****************************************************************************
5)//5.Implementation of Classical problems( producer consumer)  using Threads and Mutex

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#define BUFFER_SIZE 5
int buffer[BUFFER_SIZE]; // Shared buffer
int count = 0;           // Number of items in the buffer
pthread_mutex_t mutex;     // Mutex to protect buffer access
pthread_cond_t cond_full;  // Condition variable to signal if buffer is full
pthread_cond_t cond_empty; // Condition variable to signal if buffer is empty
void *producer(void *arg)
{
    int item;
    for (int i = 0; i < 10; i++)
    {
        item = rand() % 100; // Produce a random item
        pthread_mutex_lock(&mutex); // Enter critical section
        while (count == BUFFER_SIZE)
        { // If buffer is full, wait
            pthread_cond_wait(&cond_empty, &mutex);
        }
        // Add the item to the buffer
        buffer[count] = item;
        printf("Producer produced item %d\n", item);
        count++;
        pthread_cond_signal(&cond_full); // Signal consumer that the buffer is not empty
        pthread_mutex_unlock(&mutex);    // Exit critical section
      //  sleep(1); // Simulate time to produce
    }
    return NULL;
 }
 void *consumer(void *arg)
 {
    int item;
    for (int i = 0; i < 10; i++)
    {
        pthread_mutex_lock(&mutex); // Enter critical section
        while (count == 0)
        { // If buffer is empty, wait
            pthread_cond_wait(&cond_full, &mutex);
        }
        // Remove the item from the buffer
        count--;
        item = buffer[count];
        printf("Consumer consumed item %d\n", item);
        pthread_cond_signal(&cond_empty); // Signal producer that the buffer is not full
        pthread_mutex_unlock(&mutex);     // Exit critical section
      //  sleep(1); // Simulate time to consume

    }
    return NULL;
}
int main()
{
    pthread_t prod, cons;
     // Initialize mutex and condition variables
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&cond_full, NULL);
    pthread_cond_init(&cond_empty, NULL);
     // Create producer and consumer threads
    pthread_create(&prod, NULL, producer, NULL);
    pthread_create(&cons, NULL, consumer, NULL);
//     // Wait for the threads to finish
    pthread_join(prod, NULL);
    pthread_join(cons, NULL);
//     // Clean up
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond_full);
    pthread_cond_destroy(&cond_empty);
    return 0;
}
*****************************************************************************
6)//6.Implementation of Classical problems (reader writer) using Threads and Semaphore. 

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
sem_t wtr;
sem_t mutex;
int rc = 0;
int x = 0;
void *reader(void *arg)
{
    int id = *((int *)arg);
    sem_wait(&mutex);
    rc++;
    if (rc == 1)
    {
        sem_wait(&wtr); // we  block the writer semaphore
    }
    sem_post(&mutex);
    printf("reader %d is reading \n", id);
    sem_wait(&mutex);
    rc--;
    if (rc == 0)
    {
        sem_post(&wtr); // here we release semaphore write
    }
    sem_post(&mutex); // reader leave
    return NULL;
}
void *writer()
{
    sem_wait(&mutex);
    sem_wait(&wtr);
    x++;
    printf("the data write %d \n", x);
    sem_post(&mutex);
    sem_post(&wtr);
    return NULL;
}
int main()
{
    sem_init(&wtr, 0, 1);
  sem_init(&mutex, 0, 1);
    int r_id[10], w_id[2];
    pthread_t reader_t[10], writer_t[2];
    // Create producer and consumer threads
    for (int i = 0; i < 10; i++)
    {
        r_id[i] = i;
       pthread_create(&reader_t[i], NULL, reader, &r_id[i]);
    }
    for (int i = 0; i < 2; i++)
    {
        w_id[i] = i;
        pthread_create(&writer_t[i], NULL, writer, &w_id[i]);
    }
    for (int i = 0; i < 10; i++)
    {
        pthread_join(reader_t[i], NULL);
    }
    for (int i = 0; i < 2; i++)
    {
        pthread_join(writer_t[i], NULL);
    }
    sem_destroy(&wtr);
    sem_destroy(&mutex);
    return 0;
}
*****************************************************************************
//7)Implementation of Classical problems (producer consumer,) using Threads and Semaphore. 

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

#define BUFFER_SIZE 5
int buffer[BUFFER_SIZE]; // Shared buffer
int count = 0;           // Number of items in the buffer
sem_t empty;           // Semaphore to track empty slots
sem_t full;            // Semaphore to track full slots
pthread_mutex_t mutex; // Mutex to protect buffer access
void *producer(void *arg)
{
    int item;
    for (int i = 0; i < 10; i++)
    {
        item = rand() % 100; // Produce a random item
        sem_wait(&empty);           // Wait if buffer is full (empty slots 0)
        pthread_mutex_lock(&mutex); // Enter critical section
        // Add the item to the buffer
        buffer[count] = item;
        printf("Producer produced item %d\n", item);
        count++;
        pthread_mutex_unlock(&mutex); // Exit critical section
        sem_post(&full);              // Signal that there is a full slot
//         sleep(1); // Simulate time to produce
    }
    return NULL;
}
void *consumer(void *arg)
{
    int item;
    for (int i = 0; i < 10; i++)
    {
        sem_wait(&full);            // Wait if buffer is empty (full slots 0)
        pthread_mutex_lock(&mutex); // Enter critical section
        // Remove the item from the buffer
        count--;
        item = buffer[count];
        printf("Consumer consumed item %d\n", item);
        pthread_mutex_unlock(&mutex); // Exit critical section
        sem_post(&empty);             // Signal that there is an empty slot
//         sleep(1); // Simulate time to consume
    }
    return NULL;
}
int main()
{
    pthread_t prod, cons;
  // Initialize semaphores and mutex
    sem_init(&empty, 0, BUFFER_SIZE); // Initial value is the size of the buffer (all slots empty)
    sem_init(&full, 0, 0);            // Initial value is 0 (no full slots)
    pthread_mutex_init(&mutex, NULL);
//     // Create producer and consumer threads
    pthread_create(&prod, NULL, producer, NULL);
    pthread_create(&cons, NULL, consumer, NULL);
//     // Wait for the threads to finish
    pthread_join(prod, NULL);
    pthread_join(cons, NULL);
//     // Clean up
    sem_destroy(&empty);
    sem_destroy(&full);
    pthread_mutex_destroy(&mutex);
    return 0;
}

*****************************************************************************
//8)Implementation of Classical problems (dining philosopher) using Threads and Semaphore. 

#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define NUM_PHILOSOPHERS 5
#define THINKING_TIME 2
#define EATING_TIME 2

sem_t forks[NUM_PHILOSOPHERS]; // One semaphore for each fork

void* philosopher(void* arg) {
    int id = *((int*)arg);
    int left_fork = id;
    int right_fork = (id + 1) % NUM_PHILOSOPHERS;

    while (1) {
        printf("Philosopher %d is thinking.\n", id);
        sleep(THINKING_TIME);

        // Pick up left fork
        sem_wait(&forks[left_fork]);
        printf("Philosopher %d picked up left fork %d.\n", id, left_fork);

        // Pick up right fork
        sem_wait(&forks[right_fork]);
        printf("Philosopher %d picked up right fork %d.\n", id, right_fork);

        // Eating
        printf("Philosopher %d is eating.\n", id);
        sleep(EATING_TIME);

        // Put down right fork
        sem_post(&forks[right_fork]);
        printf("Philosopher %d put down right fork %d.\n", id, right_fork);

        // Put down left fork
        sem_post(&forks[left_fork]);
        printf("Philosopher %d put down left fork %d.\n", id, left_fork);
    }

    return NULL;
}

int main() {
    pthread_t philosophers[NUM_PHILOSOPHERS];
    int philosopher_ids[NUM_PHILOSOPHERS];

    // Initialize semaphores (one for each fork)
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        sem_init(&forks[i], 0, 1);
    }

    // Create philosopher threads
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        philosopher_ids[i] = i;
        pthread_create(&philosophers[i], NULL, philosopher, &philosopher_ids[i]);
    }

    // Wait for philosopher threads to finish (they run indefinitely)
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        pthread_join(philosophers[i], NULL);
    }

    // Destroy semaphores
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        sem_destroy(&forks[i]);
    }

    return 0;
}
*****************************************************************************
//9)Write a program to compute the finish time, turnaround time and waiting time for the First come First serve

//10)Write a program to compute the finish time, turnaround time and waiting time for the
 Shortest Job First (Preemptive and Non Preemptive) 


//11)Write a program to compute the finish time, turnaround time and waiting time for the
Priority (Preemptive and Non Preemptive)

#include <stdio.h>
#include <stdbool.h>

typedef struct
{
    int pid; // Process ID
    int burst_time;
    int arrival_time;
    int priority;       // For priority scheduling
    int remaining_time; // For Preemptive scheduling
    int finish_time;
    int turnaround_time;
    int waiting_time;
} Process;

void calculate_times(Process p[], int n)
{
    for (int i = 0; i < n; i++)
    {
        p[i].turnaround_time = p[i].finish_time - p[i].arrival_time;
        p[i].waiting_time = p[i].turnaround_time - p[i].burst_time;
    }
}

void fcfs(Process p[], int n)
{
    printf("\nFirst Come First Serve (FCFS):\n");
    printf("Scheduling Sequence: ");
    p[0].finish_time = p[0].arrival_time + p[0].burst_time;
    printf("P%d", p[0].pid);
    for (int i = 1; i < n; i++)
    {
        if (p[i].arrival_time > p[i - 1].finish_time)
        {
            p[i].finish_time = p[i].arrival_time + p[i].burst_time;
        }
        else
        {
            p[i].finish_time = p[i - 1].finish_time + p[i].burst_time;
        }
        printf(" -> P%d", p[i].pid);
    }
    printf("\n");
    calculate_times(p, n);
}

void sjf_non_preemptive(Process p[], int n)
{
    printf("\nShortest Job First (Non-Preemptive):\n");
    printf("Scheduling Sequence: ");
    int completed = 0, time = 0, min_index;
    bool finished[n];
    for (int i = 0; i < n; i++)
        finished[i] = false;

    while (completed != n)
    {
        min_index = -1;
        for (int i = 0; i < n; i++)
        {
            if (!finished[i] && p[i].arrival_time <= time)
            {
                if (min_index == -1 || p[i].burst_time < p[min_index].burst_time)
                {
                    min_index = i;
                }
            }
        }
        if (min_index != -1)
        {
            time += p[min_index].burst_time;
            p[min_index].finish_time = time;
            finished[min_index] = true;
            printf("P%d ", p[min_index].pid);
            if (completed != n - 1)
                printf("-> ");
            completed++;
        }
        else
        {
            time++;
        }
    }
    printf("\n");
    calculate_times(p, n);
}

void sjf_preemptive(Process p[], int n)
{
    printf("\nShortest Job First (Preemptive):\n");
    printf("Scheduling Sequence: ");
    int completed = 0, time = 0, min_index;
    bool finished[n];
    for (int i = 0; i < n; i++)
    {
        p[i].remaining_time = p[i].burst_time;
        finished[i] = false;
    }

    while (completed != n)
    {
        min_index = -1;
        for (int i = 0; i < n; i++)
        {
            if (!finished[i] && p[i].arrival_time <= time && p[i].remaining_time > 0)
            {
                if (min_index == -1 || p[i].remaining_time < p[min_index].remaining_time)
                {
                    min_index = i;
                }
            }
        }
        if (min_index != -1)
        {
            printf("P%d ", p[min_index].pid);
            p[min_index].remaining_time--;
            time++;
            if (p[min_index].remaining_time == 0)
            {
                p[min_index].finish_time = time;
                finished[min_index] = true;
                completed++;
            }
        }
        else
        {
            time++;
        }
    }
    printf("\n");
    calculate_times(p, n);
}

void priority_non_preemptive(Process p[], int n)
{
    printf("\nPriority Scheduling (Non-Preemptive):\n");
    printf("Scheduling Sequence: ");
    int completed = 0, time = 0, min_index;
    bool finished[n];
    for (int i = 0; i < n; i++)
        finished[i] = false;

    while (completed != n)
    {
        min_index = -1;
        for (int i = 0; i < n; i++)
        {
            if (!finished[i] && p[i].arrival_time <= time)
            {
                if (min_index == -1 || p[i].priority < p[min_index].priority)
                {
                    min_index = i;
                }
            }
        }
        if (min_index != -1)
        {
            time += p[min_index].burst_time;
            p[min_index].finish_time = time;
            finished[min_index] = true;
            printf("P%d ", p[min_index].pid);
            if (completed != n - 1)
                printf("-> ");
            completed++;
        }
        else
        {
            time++;
        }
    }
    printf("\n");
    calculate_times(p, n);
}

void round_robin(Process p[], int n, int quantum)
{
    printf("\nRound Robin:\n");
    printf("Scheduling Sequence: ");
    int time = 0, completed = 0;
    int remaining_time[n];
    for (int i = 0; i < n; i++)
        remaining_time[i] = p[i].burst_time;

    while (completed != n)
    {
        for (int i = 0; i < n; i++)
        {
            if (remaining_time[i] > 0 && p[i].arrival_time <= time)
            {
                printf("P%d ", p[i].pid);
                if (remaining_time[i] > quantum)
                {
                    time += quantum;
                    remaining_time[i] -= quantum;
                }
                else
                {
                    time += remaining_time[i];
                    remaining_time[i] = 0;
                    p[i].finish_time = time;
                    completed++;
                }
                if (completed != n)
                    printf("-> ");
            }
        }
    }
    printf("\n");
    calculate_times(p, n);
}
void priority_preemptive(Process p[], int n)
{
    printf("\nPriority Scheduling (Preemptive):\n");
    printf("Scheduling Sequence: ");
    int completed = 0, time = 0, min_index;
    bool finished[n];
    for (int i = 0; i < n; i++)
    {
        p[i].remaining_time = p[i].burst_time;
        finished[i] = false;
    }

    while (completed != n)
    {
        min_index = -1;
        // Find the process with the highest priority that can run at this time
        for (int i = 0; i < n; i++)
        {
            if (!finished[i] && p[i].arrival_time <= time && p[i].remaining_time > 0)
            {
                if (min_index == -1 || p[i].priority < p[min_index].priority)
                {
                    min_index = i;
                }
            }
        }

        if (min_index != -1)
        {
            // Process execution
            printf("P%d ", p[min_index].pid);
            p[min_index].remaining_time--;
            time++;

            // If the process is finished
            if (p[min_index].remaining_time == 0)
            {
                p[min_index].finish_time = time;
                finished[min_index] = true;
                completed++;
            }
        }
        else
        {
            time++; // If no process is available, increase time
        }
    }
    printf("\n");
    calculate_times(p, n);
}

void print_times(Process p[], int n)
{
    printf("PID\tArrival\tBurst\tFinish\tTurnaround\tWaiting\n");
    for (int i = 0; i < n; i++)
    {
        printf("%d\t%d\t%d\t%d\t%d\t\t%d\n", p[i].pid, p[i].arrival_time, p[i].burst_time, p[i].finish_time, p[i].turnaround_time, p[i].waiting_time);
    }
}

int main()
{
    int n = 4;
    Process p[] = {
        {1, 6, 0, 1, 0, 0, 0, 0},
        {2, 8, 1, 3, 0, 0, 0, 0},
        {3, 7, 2, 2, 0, 0, 0, 0},
        {4, 3, 3, 4, 0, 0, 0, 0},
    };

    fcfs(p, n);
    print_times(p, n);

    sjf_non_preemptive(p, n);
    print_times(p, n);

    sjf_preemptive(p, n);
    print_times(p, n);

    priority_non_preemptive(p, n);
    print_times(p, n);

    priority_preemptive(p, n);
    print_times(p, n);

    round_robin(p, n, 2); // Quantum of 2
    print_times(p, n);

    return 0;
}


*****************************************************************************
//12)Write a program to compute the finish time, turnaround time and waiting time for the
 Round robin
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

typedef struct
{
      int pid; // Process ID
     int burst_time;
     int arrival_time;
     int priority;       // For priority scheduling
     int remaining_time; // For Preemptive scheduling
     int finish_time;
     int turnaround_time;
     int waiting_time;
 } Process;

 typedef struct QueueNode
 {
     int process_index;
     struct QueueNode *next;
 } QueueNode;

 typedef struct
 {
     QueueNode *front, *rear;
 } Queue;

 // Queue operations
 void enqueue(Queue *q, int index)
 {
     QueueNode *newNode = (QueueNode *)malloc(sizeof(QueueNode));
     newNode->process_index = index;
     newNode->next = NULL;
     if (q->rear == NULL)
     {
         q->front = q->rear = newNode;
         return;
     }
     q->rear->next = newNode;
     q->rear = newNode;
 }

 int dequeue(Queue *q)
 {
     if (q->front == NULL)
         return -1;
     int index = q->front->process_index;
     QueueNode *temp = q->front;
     q->front = q->front->next;
     if (q->front == NULL)
         q->rear = NULL;
     free(temp);
     return index;
 }
 bool is_empty(Queue *q)
 {
     return q->front == NULL;
 }

 void calculate_times(Process p[], int n)
 {
     for (int i = 0; i < n; i++)
     {
         p[i].turnaround_time = p[i].finish_time - p[i].arrival_time;
         p[i].waiting_time = p[i].turnaround_time - p[i].burst_time;
     }
 }
 void round_robin(Process p[], int n, int quantum)
 {
     printf("\nRound Robin (using Queue):\n");
     printf("Scheduling Sequence: ");
     Queue q = {NULL, NULL};
     int time = 0, completed = 0;

     // Initialize the remaining times and enqueue processes that have arrived
     for (int i = 0; i < n; i++)
         p[i].remaining_time = p[i].burst_time;
     int process_in_queue[n];
     for (int i = 0; i < n; i++)
         process_in_queue[i] = 0; // Keeps track if the process is already in the queue
     // Enqueue processes that have arrived at the start (time = 0)
     for (int i = 0; i < n; i++)
     {
         if (p[i].arrival_time <= time && !process_in_queue[i])
         {
             enqueue(&q, i);
             process_in_queue[i] = 1;
         }
     }
     while (completed != n)
     {
         int idx = dequeue(&q);
         // If queue is empty, move time to the arrival of the next process
         if (idx == -1)
         {
             time++;
             for (int i = 0; i < n; i++)
             {
                 if (p[i].arrival_time <= time && !process_in_queue[i])
                {
                     enqueue(&q, i);
                     process_in_queue[i] = 1;
                 }
             }
             continue;
         }

         // Execute the process in the queue
         printf("P%d ", p[idx].pid);
         if (p[idx].remaining_time > quantum)
         {
             time += quantum;
             p[idx].remaining_time -= quantum;
         }
         else
         {
             time += p[idx].remaining_time;
             p[idx].remaining_time = 0;
             p[idx].finish_time = time;
             completed++;
         }
         // Check for new arrivals and enqueue them
         for (int i = 0; i < n; i++)
         {
             if (p[i].arrival_time <= time && !process_in_queue[i])
             {
                 enqueue(&q, i);
                 process_in_queue[i] = 1;
             }
         }
         //Re-enqueue the current process if it's not yet finished
         if (p[idx].remaining_time > 0)
         {
             enqueue(&q, idx);
         }
     }
     printf("\n");
     calculate_times(p, n);
 }

 void print_times(Process p[], int n)
 {
     printf("PID\tArrival\tBurst\tFinish\tTurnaround\tWaiting\n");
     for (int i = 0; i < n; i++)
     {
         printf("%d\t%d\t%d\t%d\t%d\t\t%d\n", p[i].pid, p[i].arrival_time, p[i].burst_time, p[i].finish_time, p[i].turnaround_time, p[i].waiting_time);
     }
 }
 int main()
 {
     int n = 4;
     Process p[] = {
         {1, 6, 0, 1, 0, 0, 0, 0},
         {2, 8, 1, 3, 0, 0, 0, 0},
         {3, 7, 2, 2, 0, 0, 0, 0},
         {4, 3, 3, 4, 0, 0, 0, 0},
     };
     round_robin(p, n, 2); // Quantum of 2
     print_times(p, n);
     return 0;
 }
 
*****************************************************************************
//13)Write a program to check whether given system is in safe state or not using Banker’s  Deadlock Avoidance algorithm.
14)Write a program for Deadlock detection algorithm

//  Banker's Algorithm
#include <stdio.h>
int main()
{
    // P0, P1, P2, P3, P4 are the Process names here
    int n, m, i, j, k;
    n = 5;                         // Number of processes
    m = 3;                         // Number of resources
    int alloc[5][3] = {{0, 1, 0},  // P0 // Allocation Matrix
                       {2, 0, 0},  // P1
                       {3, 0, 2},  // P2
                       {2, 1, 1},  // P3
                       {0, 0, 2}}; // P4
    printf("Allocated matrix:(It has) \nAllocated instance of resources A,B,C to 5(p1 to p5) processors:\n");
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < m; j++)
            printf("%d ", alloc[i][j]);
        printf("\n");
    }
    printf("Max matrix:(it required) \nMaximum required instance of resources to processor to complete execution\n");
    int max[5][3] = {{7, 5, 3},  // P0 // MAX Matrix
                     {3, 2, 2},  // P1
                     {9, 0, 2},  // P2
                     {2, 2, 2},  // P3
                     {4, 3, 3}}; // P4

    for (i = 0; i < n; i++)
    {
        for (j = 0; j < m; j++)
            printf("%d ", max[i][j]);
        printf("\n");
    }
    // total instance 10 5 7 subtract allocated resources 7 2 5 remaining are 3 3 2
    int avail[3] = {3, 3, 2}; // Available Resources
    int f[n], ans[n], ind = 0;
    for (k = 0; k < n; k++)
    {
        f[k] = 0;
    }
    int need[n][m];
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < m; j++)
            need[i][j] = max[i][j] - alloc[i][j];
    }

printf("Need Matrix:(it want to reach max requirement) \nAllocated matrix - Max matrix\nInstance of resources it want to complete requirement to execute \n");
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < m; j++)
            printf("%d ", need[i][j]);
        printf("\n");
    }

    printf("\nAvaiable resources:");
    for (int i = 0; i < 3; i++)
    {
        printf(" %d", avail[i]);
    }
    printf("\n");
    int y = 0;
    for (k = 0; k < 5; k++)
    {
        for (i = 0; i < n; i++)
        {
            if (f[i] == 0)
            {

                int flag = 0;
                for (j = 0; j < m; j++)
                {
                    if (need[i][j] > avail[j])
                    {
                        printf("\nresources are not avaible for P%d", i);
                        flag = 1;
                        break;
                    }
                }

                if (flag == 0)
                {
                    printf("\nresources are avaible for P%d", i);
                    ans[ind++] = i;
                    printf("\nprocess P%d is finish", i);
                    printf("\nAvailable resource after P%d complete:", i);
                    for (y = 0; y < m; y++)

                    {
                        avail[y] += alloc[i][y];
                        printf(" %d ", avail[y]);
                    }
                    f[i] = 1;
                    printf("\n");
                    // printf("\nprocess P%d is finish\n", i);
                }
            }
        }
    }

    int flag = 1;

    for (int i = 0; i < n; i++)
    {
        if (f[i] == 0)
        {
            flag = 0;
            printf("The following system is not safe");
            break;
        }
    }

    if (flag == 1)
    {
        printf("\nFollowing is the SAFE Sequence\n");
        for (i = 0; i < n - 1; i++)
            printf(" P%d ->", ans[i]);
        printf(" P%d", ans[n - 1]);
    }

    return (0);
}
*****************************************************************************
//15).Write a program to calculate the number of page faults for a reference string for the FIFO page replacement algorithms:

//16).Write a program to calculate the number of page faults for a reference string for the LRU page replacement algorithms: 

//17).Write a program to calculate the number of page faults for a reference string for the Optimal page replacement algorithms: 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#define MAX_PAGES 100
#define MAX_FRAMES 10
int FIFO(int pages[], int n, int frames)
{
    int pageFaults = 0;
    int frame[MAX_FRAMES];
    int index = 0;
    memset(frame, -1, sizeof(frame));
    for (int i = 0; i < n; i++)
    {
        bool found = false;
        for (int j = 0; j < frames; j++)
        {
            if (frame[j] == pages[i])
            {
                found = true;
                break;
            }
        }

        if (!found)
        {
            frame[index] = pages[i];
            index = (index + 1) % frames; // Circular increment
            pageFaults++;
        }
    }
    return pageFaults;
}
int LRU(int pages[], int n, int frames)
{
    int pageFaults = 0;
    int frame[MAX_FRAMES];
    int lastUsed[MAX_FRAMES];
    memset(frame, -1, sizeof(frame));
    memset(lastUsed, -1, sizeof(lastUsed));
    for (int i = 0; i < n; i++)
    {
        bool found = false;
        for (int j = 0; j < frames; j++)
        {
            if (frame[j] == pages[i])
            {
                found = true;
                lastUsed[j] = i; // Update last used time
                break;
            }
        }
        if (!found)
        {
            int lruIndex = 0;
            for (int j = 1; j < frames; j++)
            {
                if (lastUsed[j] < lastUsed[lruIndex])
                {
                    lruIndex = j; // Find the least recently used
                }
            }
            frame[lruIndex] = pages[i];
            lastUsed[lruIndex] = i; // Update last used time
            pageFaults++;
        }
    }
    return pageFaults;
}
int Optimal(int pages[], int n, int frames)
{
    int pageFaults = 0;
    int frame[MAX_FRAMES];
    memset(frame, -1, sizeof(frame));

    for (int i = 0; i < n; i++)
    {
        bool found = false;

        for (int j = 0; j < frames; j++)
        {
            if (frame[j] == pages[i])
            {
                found = true;
                break;
            }
        }

        if (!found)
        {
            int optimalIndex = -1;
            int farthest = -1;

            for (int j = 0; j < frames; j++)
            {
                int k;
                for (k = i + 1; k < n; k++)
                {
                    if (frame[j] == pages[k])
                    {
                        if (k > farthest)
                        {
                            farthest = k;
                            optimalIndex = j; // Replace this page
                        }
                        break;
                    }
                }
                if (k == n)
                {
                    optimalIndex = j; // If page is not found in future
                    break;
                }
            }
            frame[optimalIndex] = pages[i];
            pageFaults++;
        }
    }
    return pageFaults;
}
int main()
{
    char referenceString[MAX_PAGES];
    int frames = 3; // Number of page frames
    int pages[MAX_PAGES];
    int n = 0;
    printf("Enter the page reference string (space-separated, end with -1): ");
    while (true)
    {
        char temp[10];
        scanf("%s", temp);
        if (strcmp(temp, "-1") == 0)
        {
            break;
        }
        pages[n++] = temp[0] - 'A'; // Convert character to integer (A=0, B=1, ...)
    }

    int fifoPageFaults = FIFO(pages, n, frames);
    int lruPageFaults = LRU(pages, n, frames);
    int optimalPageFaults = Optimal(pages, n, frames);

    printf("Page faults for FIFO: %d\n", fifoPageFaults);
    printf("Page faults for LRU: %d\n", lruPageFaults);
    printf("Page faults for Optimal: %d\n", optimalPageFaults);

    return 0;
}
*******************************
//18)Write a program to simulate FCFS disk scheduling. Calculate total seek time.Print accepted input and output in tabular format
//fcfs
#include <stdio.h>
#include <stdlib.h>

void fcfs(int requests[], int n, int head)
{
    int seek_time = 0;
    printf("FCFS Disk Scheduling:\n");
    printf("Request Order | Head Position | Seek Distance\n");

    for (int i = 0; i < n; i++)
    {
        int distance = abs(head - requests[i]);
        seek_time += distance;
        printf("%12d | %13d | %13d\n", requests[i], head, distance);
        head = requests[i];
    }

    printf("\nTotal Seek Time: %d cylinders\n", seek_time);
    printf("Average Seek Time: %.2f cylinders\n\n", (float)seek_time / n);
}

int main()
{
    int requests[] = {82, 170, 43, 140, 24, 16, 190};
    int head = 50;
    int n = sizeof(requests) / sizeof(requests[0]);
    fcfs(requests, n, head);
    return 0;
}
*****************************************************************************
//19)Write a program to simulate SSTF disk scheduling. Calculate total seek time.Print accepted input and output in tabular format
//sstf
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>

int find_nearest(int requests[], bool served[], int n, int head)
{
    int min_distance = 1e9, nearest = -1;
    for (int i = 0; i < n; i++)
    {
        if (!served[i])
        {
            int distance = abs(head - requests[i]);
            if (distance < min_distance)
            {
                min_distance = distance;
                nearest = i;
            }
        }
    }
    return nearest;
}

void sstf(int requests[], int n, int head)
{
    bool served[n];
    int seek_time = 0;
    for (int i = 0; i < n; i++)
        served[i] = false;

    printf("SSTF Disk Scheduling:\n");
    printf("Request Order | Head Position | Seek Distance\n");

    for (int i = 0; i < n; i++)
    {
        int nearest = find_nearest(requests, served, n, head);
        served[nearest] = true;
        int distance = abs(head - requests[nearest]);
        seek_time += distance;
        printf("%12d | %13d | %13d\n", requests[nearest], head, distance);
        head = requests[nearest];
    }

    printf("\nTotal Seek Time: %d cylinders\n", seek_time);
    printf("Average Seek Time: %.2f cylinders\n\n", (float)seek_time / n);
}

int main()
{
    int requests[] = {82, 170, 43, 140, 24, 16, 190};
    int head = 50;
    int n = sizeof(requests) / sizeof(requests[0]);
    sstf(requests, n, head);
    return 0;
}
*****************************************************************************
//20)Write a program to simulate SCAN disk scheduling. Calculate total seek time.Print accepted input and output in tabular format

//scan
 #include <stdio.h>
 #include <stdlib.h>
int cmp(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}
void scan(int requests[], int n, int head, int direction, int max_track)
{
    int seek_time = 0;
    printf("SCAN Disk Scheduling:\n");
    printf("Request Order | Head Position | Seek Distance\n");

    // Sort requests
    int left[n], right[n], l_count = 0, r_count = 0;
    for (int i = 0; i < n; i++)
    {
        if (requests[i] < head)
            left[l_count++] = requests[i];
        else
            right[r_count++] = requests[i];
    }

    qsort(left, l_count, sizeof(int), cmp);
    qsort(right, r_count, sizeof(int), cmp);

    if (direction == 1)
    { // Move towards the end
        for (int i = 0; i < r_count; i++)
        {
            seek_time += abs(head - right[i]);
            printf("%12d | %13d | %13d\n", right[i], head, abs(head - right[i]));
            head = right[i];
        }
        seek_time += abs(head - max_track); // Move to end of the disk
        head = max_track;

        for (int i = l_count - 1; i >= 0; i--)
        {
            seek_time += abs(head - left[i]);
            printf("%12d | %13d | %13d\n", left[i], head, abs(head - left[i]));
            head = left[i];
        }
    }
    else
    {
        for (int i = l_count - 1; i >= 0; i--)
        {
            seek_time += abs(head - left[i]);
            printf("%12d | %13d | %13d\n", left[i], head, abs(head - left[i]));
            head = left[i];
        }
        seek_time += head; // Move to the start of the disk
        head = 0;

        for (int i = 0; i < r_count; i++)
        {
            seek_time += abs(head - right[i]);
            printf("%12d | %13d | %13d\n", right[i], head, abs(head - right[i]));
            head = right[i];
        }
    }

    printf("\nTotal Seek Time: %d cylinders\n", seek_time);
    printf("Average Seek Time: %.2f cylinders\n\n", (float)seek_time / n);
}



int main()
{
    int requests[] = {82, 170, 43, 140, 24, 16, 190};
    int head = 50;
    int direction = 1; // 1 for end, -1 for start
    int max_track = 199;
    int n = sizeof(requests) / sizeof(requests[0]);
    scan(requests, n, head, direction, max_track);
    return 0;
}
*****************************************************************************
//21)Write a program to simulate C-SCAN disk scheduling. Calculate total seek time.Print accepted input and output in tabular format

//cscan
#include <stdio.h>
#include <stdlib.h>
int cmp(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}
void c_scan(int requests[], int n, int head, int max_track)
{
    int seek_time = 0;
    printf("C-SCAN Disk Scheduling:\n");
    printf("Request Order | Head Position | Seek Distance\n");

    // Sort requests
    int left[n], right[n], l_count = 0, r_count = 0;
    for (int i = 0; i < n; i++)
    {
        if (requests[i] < head)
            left[l_count++] = requests[i];
        else
            right[r_count++] = requests[i];
    }

    qsort(left, l_count, sizeof(int), cmp);
    qsort(right, r_count, sizeof(int), cmp);

    for (int i = 0; i < r_count; i++)
    {
        seek_time += abs(head - right[i]);
        printf("%12d | %13d | %13d\n", right[i], head, abs(head - right[i]));
        head = right[i];
    }
    seek_time += abs(head - max_track); // Move to end of the disk
    head = 0;
    seek_time += max_track;

    for (int i = 0; i < l_count; i++)
    {
        seek_time += abs(head - left[i]);
        printf("%12d | %13d | %13d\n", left[i], head, abs(head - left[i]));
        head = left[i];
    }

    printf("\nTotal Seek Time: %d cylinders\n", seek_time);
    printf("Average Seek Time: %.2f cylinders\n\n", (float)seek_time / n);
}

int main()
{
    int requests[] = {82, 170, 43, 140, 24, 16, 190};
    int head = 50;
    int max_track = 199;
    int n = sizeof(requests) / sizeof(requests[0]);
    c_scan(requests, n, head, max_track);
    return 0;
}
*****************************************************************************
//22)Write a program  for following 1)zombie process 2)orphan processes 3)sum of even numbers of an array in parent and odd numbers of an array in child process
//zombie/orphan/sumoddeven
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void zombie_process_demo() {
    pid_t pid = fork();

    if (pid > 0) {
        // Parent process
        printf("Parent process (PID: %d) created a zombie child (PID: %d)\n", getpid(), pid);
        sleep(10); // Wait for a while to make the child a zombie
        printf("Zombie child process created\n");
    } else if (pid == 0) {
        // Child process
        printf("Child process (PID: %d) exiting\n", getpid());
        exit(0); // Child exits, becomes zombie
    }
}

void orphan_process_demo() {
    pid_t pid = fork();

    if (pid > 0) {
        // Parent process
        printf("Parent process (PID: %d) created a child (PID: %d) that will become orphan\n", getpid(), pid);
        sleep(2); // Give time for the child to start running
        printf("Parent process (PID: %d) exiting\n", getpid());
    } else if (pid == 0) {
        // Child process
        sleep(5); // Delay to ensure parent exits before the child
        printf("Orphan child process (PID: %d) now adopted by init process\n", getpid());
    }
}

void sum_even_odd_numbers(int arr[], int size) {
    pid_t pid = fork();

    if (pid > 0) {
        // Parent process: Sum of even numbers
        int even_sum = 0;
        for (int i = 0; i < size; i++) {
            if (arr[i] % 2 == 0) {
                even_sum += arr[i];
            }
        }
        wait(NULL); // Wait for the child to finish
        printf("Parent process (PID: %d): Sum of even numbers = %d\n", getpid(), even_sum);
    } else if (pid == 0) {
        // Child process: Sum of odd numbers
        int odd_sum = 0;
        for (int i = 0; i < size; i++) {
            if (arr[i] % 2 != 0) {
                odd_sum += arr[i];
            }
        }
        printf("Child process (PID: %d): Sum of odd numbers = %d\n", getpid(), odd_sum);
        exit(0); // Child exits
    }
}

int main() {
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; // Example array
    int size = sizeof(arr) / sizeof(arr[0]);

    printf("Demonstrating Zombie Process:\n");
    zombie_process_demo();
    sleep(10); // Wait to observe the zombie process in `ps` command

    printf("\nDemonstrating Orphan Process:\n");
    orphan_process_demo();
    sleep(10); // Wait to observe the orphan process in `ps` command

    printf("\nCalculating Sum of Even and Odd Numbers:\n");
    sum_even_odd_numbers(arr, size);

    return 0;
}
*****************************************************************************
//23)Write a shell script to perform following operations on   student database.
a) Insert b) Delete c)Update d)Search

#!/bin/bash

DB_FILE="student_db.txt"

# Function to insert a new student record
insert_student() {
    echo "Enter Student ID:"
    read student_id
    echo "Enter Student Name:"
    read name
    echo "Enter Age:"
    read age
    echo "Enter Grade:"
    read grade

    # Append the new student record to the file
    echo "$student_id,$name,$age,$grade" >> $DB_FILE
    echo "Student record inserted successfully."
}

# Function to delete a student record by ID
delete_student() {
    echo "Enter Student ID to delete:"
    read student_id

    # Check if the student ID exists
    grep -q "^$student_id," $DB_FILE
    if [ $? -eq 0 ]; then
        # Delete the record and update the file
        grep -v "^$student_id," $DB_FILE > temp.txt && mv temp.txt $DB_FILE
        echo "Student record deleted successfully."
    else
        echo "Student ID not found."
    fi
}

# Function to update a student record by ID
update_student() {
    echo "Enter Student ID to update:"
    read student_id

    # Check if the student ID exists
    grep -q "^$student_id," $DB_FILE
    if [ $? -eq 0 ]; then
        echo "Enter new Student Name:"
        read name
        echo "Enter new Age:"
        read age
        echo "Enter new Grade:"
        read grade

        # Update the record
        grep -v "^$student_id," $DB_FILE > temp.txt
        echo "$student_id,$name,$age,$grade" >> temp.txt
        mv temp.txt $DB_FILE
        echo "Student record updated successfully."
    else
        echo "Student ID not found."
    fi
}

# Function to search for a student record by ID
search_student() {
    echo "Enter Student ID to search:"
    read student_id

    # Search for the student ID in the file
    result=$(grep "^$student_id," $DB_FILE)
    if [ -n "$result" ]; then
        echo "Student record found: $result"
    else
        echo "Student ID not found."
    fi
}

# Main script loop
while true; do
    echo "Choose an operation:"
    echo "1. Insert"
    echo "2. Delete"
    echo "3. Update"
    echo "4. Search"
    echo "5. Exit"
    read choice

    case $choice in
        1) insert_student ;;
        2) delete_student ;;
        3) update_student ;;
        4) search_student ;;
        5) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
*****************************************************************************
//24)Write a program to read and copy the contents of file character by character, line by line.

import java.io.*;
public class FileCopyExample {
    public static void main(String[] args) {
        String sourceFile = "source.txt";
        String charDestinationFile = "charDestination.txt";
        String lineDestinationFile = "lineDestination.txt";
        
        // Copy file character by character
        copyCharacterByCharacter(sourceFile, charDestinationFile);

        // Copy file line by line
        copyLineByLine(sourceFile, lineDestinationFile);
    }

    public static void copyCharacterByCharacter(String source, String destination) {
        try (FileReader fr = new FileReader(source);
             FileWriter fw = new FileWriter(destination)) {
             
            int ch;
            while ((ch = fr.read()) != -1) {
                fw.write(ch);
            }
            System.out.println("File copied character by character to " + destination);
        } catch (IOException e) {
            System.out.println("An error occurred during character-by-character copy: " + e.getMessage());
        }
    }

    public static void copyLineByLine(String source, String destination) {
        try (BufferedReader br = new BufferedReader(new FileReader(source));
             BufferedWriter bw = new BufferedWriter(new FileWriter(destination))) {
             
            String line;
            while ((line = br.readLine()) != null) {
                bw.write(line);
                bw.newLine();  // Add newline to maintain original line structure
            }
            System.out.println("File copied line by line to " + destination);
        } catch (IOException e) {
            System.out.println("An error occurred during line-by-line copy: " + e.getMessage());
        }
    }
}
*****************************************************************************
//25)Write a program to load ALP program from input file to main memory.

import java.io.*;
import java.util.Arrays;

public class phase1 {
    private char[][] M = new char[100][4]; // Physical Memory
    private char[] IR = new char[4]; // Instruction Register (4 bytes)
    private char[] R = new char[4]; // General Purpose Register (4 bytes)
    private int IC; // Instruction Counter Register (2 bytes)
    private int SI; // Interrupt
    boolean C = false; // Toggle (1 byte)
    private char[] buffer = new char[40];
    private final BufferedReader read = new BufferedReader(new FileReader("input.txt"));
    private final BufferedWriter output = new BufferedWriter(new FileWriter("output.txt"));

    phase1() throws IOException {
    }

    public void init() { // we initialize the memory.
        for (int i = 0; i < 100; i++) {
            for (int j = 0; j < 4; j++) {
                M[i][j] = 0;
            }
        }

        IR[0] = 0;
        R[0] = 0;
        IC = 0; // Ensure IC is initialized
        C = false; // Ensure C is initialized
    }

    public void LOAD() throws Exception { // load the data in buffer of size 40 bytes
        String line;
        int x = 0; // Memory index to store data

        do {
            line = read.readLine();
            if (line == null) {
                break;
            }
            Arrays.fill(buffer, '\0'); // Clear the buffer
            for (int i = 0; i < 40 && i < line.length(); i++) {
                buffer[i] = line.charAt(i);
            }

            if (buffer[0] == '$' && buffer[1] == 'A' && buffer[2] == 'M' && buffer[3] == 'J') {
                System.out.println("Initializing memory...");
                init(); // Call init to reset the memory and registers
                continue;

            } else if (buffer[0] == '$' && buffer[1] == 'D' && buffer[2] == 'T' && buffer[3] == 'A') {
                IC = 0; // Reset the Instruction Counter
                System.out.println("Starting execution...");
                MOS_STARTEXECUTION();
                continue;

            } else if (buffer[0] == '$' && buffer[1] == 'E' && buffer[2] == 'N' && buffer[3] == 'D') {
                x = 0; // Reset memory index for next job
                MEMORYCONTENT();
                LOAD(); // Load next job if present
            } else {
                int k = 0; // Buffer index to read instructions

                while (x < 100 && k < 40) {
                    for (int j = 0; j < 4; j++) {
                        if (k < buffer.length && buffer[k] != '\0') {
                            M[x][j] = buffer[k];
                            k++;
                        } else {
                            break; // Exit inner loop if end of buffer or null character
                        }
                    }
                    x++; // Move to next memory row
                    if (k >= buffer.length) {
                        break; // Exit loop if end of buffer
                    }
                }
            }
        } while (true);

        // if (output != null) {
        // output.close();
        // }
        closeResources();
    }

    public void MEMORYCONTENT() {
        System.out.println("Memory Contents:");
        for (int i = 0; i < 100; i++) {
            System.out.print(i + ": "); // Print newline
            for (int j = 0; j < 4; j++) {
                System.out.print(M[i][j]);
            }
            System.out.println(); // Print newline after each memory row
        }
    }

    public void MOS_STARTEXECUTION() {
        int IC = 0;
        EXECUTEUSERPROGRAM();
    }

    public void EXECUTEUSERPROGRAM() {
        // int i = 0;
        while (true) {
            for (int i = 0; i < 4; i++) { // load the command in the ir ex gd10 pd10 but one at time after that ic get
                                          // incremented
                IR[i] = M[IC][i];
            }
            IC++;
            if (IR[0] == 'L' && IR[1] == 'R') {
                int j = IR[2] - 48;// converting the character into the int
                j = j * 10 + (IR[3] - 48);// here we define the blocks
                for (int k = 0; k <= 3; k++) {// load in the register r first four bit of the block
                    R[k] = M[j][k];
                }
                System.out.println();
            } else if (IR[0] == 'S' && IR[1] == 'R') {

                int j = IR[2] - 48;// converting the character into the int
                j = j * 10 + (IR[3] - 48);// here we define the blocks
                for (int k = 0; k <= 3; k++) {// load in the register r first four bit of the block
                    M[j][k] = R[k];
                }
                System.out.println();
            } else if (IR[0] == 'C' && IR[1] == 'R') {
                int j = IR[2] - 48;// converting the character into the int
                j = j * 10 + (IR[3] - 48);// here we define the blocks

                int count = 0;
                for (int k = 0; k < 4; k++) {
                    if (M[j][k] == R[k]) {
                        count++;
                    }
                }
                if (count == 4) {
                    C = true;
                } else {
                    C = false;
                }
            } else if (IR[0] == 'B' && IR[1] == 'T') {
                if (C == true) {
                    int j = IR[2] - 48;// converting the character into the int
                    j = j * 10 + (IR[3] - 48);
                    IC = j;// here it jump on that block for next excution
                }
            } else if (IR[0] == 'G' && IR[1] == 'D') {
                SI = 1;
                MOS();// here every time interupt comes machine switch to master mode for excution of
                      // commands
            } else if (IR[0] == 'P' && IR[1] == 'D') {
                SI = 2;
                MOS();
            } else if (IR[0] == 'H') {
                SI = 3;
                MOS();
                break;
            }
        }
    }

    public static void main(String[] args) throws Exception {
        phase1 t = new phase1();
        t.LOAD();
    }

    public void MOS() {
        switch (SI) {
            case 1:
                Read();
                break;
            case 2:
                Write();
                break;
            case 3:
                Terminate();
                break;
            default:
                break;
        }
    }

    public void Read() {
        int i = IR[2] - 48;// converting the charecter into the int
        i = i * 10;
        int k = 0;
        String line = null;
        Arrays.fill(buffer, '\0');
        try {
            line = read.readLine();
        } catch (IOException e) {
            System.out.println(e);
        }

        Arrays.fill(buffer, '\0');// we clear the buffere
        for (int a = 0; a < 40 && a < line.length(); a++) {
            buffer[a] = line.charAt(a);
        }
        for (int l = 0; l < 10; ++l) {
            for (int j = 0; j < 4; ++j) {
                M[i][j] = buffer[k];
                k++;
            }
            if (k == 40) {
                break;
            }
            i++;
        }

    }

    public void Write() {
        Arrays.fill(buffer, '\0');// clear the buffer

        int i = IR[2] - 48;// converting the charecter into the int
        i = i * 10;

        System.out.println(i);
        int k = 0;
        for (int l = 0; l < 10; ++l) {
            for (int j = 0; j < 4; ++j) {
                buffer[k] = M[i][j];
                if (buffer[k] != '\0') {
                    try {
                        output.write(buffer[k]);
                    } catch (IOException e) {
                        System.out.println(e);
                    }
                }
                k++;
            }
            if (k == 40) {
                break;
            }
            i++;
        }

        try {
            output.write("\n");
        } catch (IOException e) {
            System.out.println(e);
        }
    }

    public void Terminate() {
        try {
            output.write("\n");
            output.write("\n");
        } catch (IOException e) {
            System.out.println(e);
        }
    }

    public void closeResources() {
        try {
            if (read != null) {
                read.close();
            }
            if (output != null) {
                output.close();
            }
        } catch (IOException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }

}

*****************************************************************************
26)27)Phase2 Write a program to check Operand error in a given job and raise an interrupt.
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

class PCB {
    String jOBID;
    int TTL;
    int TLL;
    int TTC;
    int LLC;

    public PCB(String jOBID, int TTL, int TLL, int TTC, int LLC) {
        this.jOBID = jOBID;
        this.TTL = TTL;
        this.TLL = TLL;
        this.TTC = TTC;
        this.LLC = LLC;
    }
}

public class OS_CP {

    char[][] memory;
    char[] IR;
    int IC;
    char[] R;
    int C;
    int PTR;
    int SI;
    int PI;
    int TI;
    char[] buffer;
    BufferedReader reader;
    FileWriter writer;
    Set<Integer> checkRandomNumber;
    List<PCB> pcbList;
    PCB pcb;
    boolean pageFault;
    int curr;

    boolean flag;
    boolean reachedH;
    boolean reachedEnd;

    public OS_CP() {
        this.memory = new char[300][4];
        this.IR = new char[4];
        this.R = new char[4];
        this.buffer = new char[40];
        this.checkRandomNumber = new HashSet<>();
        this.pcbList = new ArrayList<>();
        this.curr = -1;
        this.flag = false;
        this.reachedH = false;
        this.reachedEnd = false;
    }

    public void init() {
        this.C = 0;
        this.SI = 0;
        this.PI = 0;
        this.TI = 0;
        this.curr = -1;
        this.flag = false;
        this.reachedH = false;
        this.reachedEnd = false;

        for (int i = 0; i < 300; i++) {
            for (int j = 0; j < 4; j++) {
                memory[i][j] = ' ';
            }
        }

        for (int i = 0; i < 4; i++) {
            IR[i] = '\u0000';
            R[i] = '\u0000';
        }

        this.buffer = new char[40];
        this.pcb = new PCB(null, -1, -1, -1, -1);

        this.checkRandomNumber.clear();
        this.pcbList.clear();

    }

    public void initializePT(int ptr) {
        for (int i = ptr; i < ptr + 10; i++) {
            for (int j = 0; j < 4; j++) {
                if (j == 0) {
                    memory[i][j] = '0';
                } else if (j == 1) {
                    memory[i][j] = '_';
                } else {

                    memory[i][j] = '*';
                }
            }
        }
    }

    public void LOAD(String fileName1, String fileName2) throws IOException {
        try {
            reader = new BufferedReader(new FileReader(fileName1));
            writer = new FileWriter(fileName2);
            String line = null;
            String subString = null;

            while ((line = reader.readLine()) != null) {
                if (line.length() >= 4) {
                    subString = line.substring(0, 4);
                } else {
                    subString = line;
                }
                if (subString.equals("$AMJ")) {
                    init();
                    int TTL;
                    int TLL;
                    String jOBID;
                    PTR = ALLOCATE() * 10;
                    curr = PTR;
                    jOBID = line.substring(4, 8);
                    TTL = Integer.parseInt(line.substring(8, 12));
                    TLL = Integer.parseInt(line.substring(12, 16));

                    System.out.println("jOBID: " + jOBID);
                    System.out.println("TTL: " + TTL);
                    System.out.println("TLL: " + TLL);
                    System.out.println("PTR: " + PTR);
                    System.out.print("\n\n");
                    initializePT(PTR);

                    pcb = new PCB(jOBID, TTL, TLL, 0, 0);
                    continue;
                }
                if (subString.equals("$DTA")) {
                    STARTEXECUTION();
                    printMemory();
                    printPageTable(PTR);
                    continue;
                }
                if (subString.equals("$END")) {
                    continue;
                } else {
                    if (flag) {
                        continue;

                    }
                    int m = ALLOCATE();
                    String frameNo = String.valueOf(m);
                    if ((m / 10.0) < 1) {
                        frameNo = "0" + frameNo;
                    }
                    memory[curr][0] = '1';
                    memory[curr][2] = frameNo.charAt(0);
                    memory[curr][3] = frameNo.charAt(1);
                    curr = curr + 1;

                    buffer = line.toCharArray();
                    int ra = m * 10;
                    for (int i = 0; i < line.length();) {
                        memory[ra][i % 4] = buffer[i];
                        i++;
                        if (i % 4 == 0) {
                            ra++;
                        }

                    }
                }

            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public int ALLOCATE() {
        Random random = new Random();
        int randomNumber = random.nextInt(30);
        if (checkRandomNumber.size() == 0) {
            checkRandomNumber.add(randomNumber);
            return randomNumber;
        }
        while (checkRandomNumber.contains(randomNumber)) {
            randomNumber = random.nextInt(30);
        }
        checkRandomNumber.add(randomNumber);
        return randomNumber;

    }

    public void printMemory() {
        for (int i = 0; i < 300; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < 4; j++) {
                System.out.print(memory[i][j] + " ");
            }
            System.out.println();
        }
    }

    public void printPageTable(int ra) {
        System.out.println("Page Table");
        System.out.println();
        for (int i = ra; i < ra + 10; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < 4; j++) {
                System.out.print(memory[i][j] + " | ");
            }
            System.out.println();
            System.out.println();
        }
        System.out.println();
        System.out.println();

    }

    int ADDRESSMAP(int VA) {
        if (0 <= VA && VA < 100) {
            int pt = PTR + VA / 10;
            if (memory[pt][0] == '0') {
                PI = 3;
                return -1;
            }
            pt = Integer.parseInt(String.valueOf(memory[pt][2]) + String.valueOf(memory[pt][3])) * 10 + VA % 10;
            return pt;
        }
        PI = 2;
        return -1;
    }

    void STARTEXECUTION() {
        this.IC = 0;
        EXECUTEUSERPROGRAM();
    }

    void WRITE(int RA) {
        if (pcb.LLC + 1 > pcb.TLL) {
            TI = 2;
            TERMINATE(2);
            flag = true;
            return;

        } else {
            String total = "";
            String s = "";

            for (int i = 0; i < 10; i++) {
                s = new String(memory[RA + i]);
                String t = "";
                for (int j = 0; j < 4; j++) {

                    t += s.charAt(j);

                }
                total = total.concat(t);
            }
            System.out.println("In writing mode");
            try {
                writer.write(total);
                writer.write("\n");
                writer.flush();
                pcb.LLC++;
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        SI = 0;

    }

    void TERMINATE(int EM) {
        try {

            writer.write("Job ID: " + pcb.jOBID + "\n");
            if (EM == 0) {
                writer.write("ERROR: No error \n");
            } else if (EM == 1) {
                writer.write("ERROR: out of data error \n");
            } else if (EM == 2) {
                writer.write("ERROR: line limit exceeded error \n");
            } else if (EM == 3) {
                writer.write("ERROR: time limit exceeded error \n");
            } else if (EM == 4) {
                writer.write("ERROR: operation code error \n");
            } else if (EM == 5) {
                writer.write("ERROR: operand code error \n");
            } else if (EM == 6) {
                writer.write("ERROR: invalid page fault error \n");
            } else if (EM == 7) {
                writer.write("ERROR: time limit exceeded and operation code error \n");
            } else if (EM == 8) {
                writer.write("ERROR: time limit exceeded and operand code error \n");
            }

            writer.write("IC:  " + IC + "\n");
            writer.write("IR:  " + String.valueOf(IR) + "\n");
            writer.write("TTL: " + pcb.TTL + "\n");
            writer.write("TTC:  " + pcb.TTC + "\n");
            writer.write("TLL:  " + pcb.TLL + "\n");
            writer.write("LLC:  " + pcb.LLC + "\n");
            writer.write("\n");
            writer.write("\n");
            SI = 0;
            TI = 0;
            PI = 0;
            writer.flush();
        } catch (IOException e) {
            // TODO Auto-generated catch block
        }

    }

    void READ(int RA) {
        try {
            String line = reader.readLine();
            if (line.contains("$END")) {
                reachedEnd = true;
                TERMINATE(1);
                return;
            } else {
                buffer = line.toCharArray();
                for (int i = 0; i < line.length();) {
                    memory[RA][i % 4] = buffer[i];
                    i++;
                    if (i % 4 == 0) {
                        RA++;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        SI = 0;

    }

    void mos(int RA) {

        if (TI == 0 && SI == 1) {
            System.out.println("in most read");
            READ(RA);
        } else if (TI == 0 && SI == 2) {
            WRITE(RA);
        } else if (TI == 0 && SI == 3) {
            TERMINATE(0);
            try {
                System.out.println();

            } catch (Exception e) {

            }
        } else if (TI == 0 && PI == 1) {
            TERMINATE(4);
        } else if (TI == 0 && PI == 2) {
            TERMINATE(5);
        } else if (TI == 0 && PI == 3) {
            if ((IR[0] == 'G' && IR[1] == 'D') || (IR[0] == 'S' && IR[1] == 'R')) {
                System.out.println("Valid Page fault occurred");
                pageFault = true;
                int m = ALLOCATE();
                String t = String.valueOf(m);
                if (m / 10.0 < 1) {
                    t = "0" + t;

                }
                memory[curr][0] = '1';
                memory[curr][2] = t.charAt(0);
                memory[curr][3] = t.charAt(1);

                curr++;

                PI = 0;
            } else if ((IR[0] == 'P' && IR[1] == 'D') || (IR[0] == 'L' && IR[1] == 'R')
                    || (IR[0] == 'C' && IR[1] == 'R') || (IR[0] == 'B' && IR[1] == 'T')) {

                TERMINATE(6);
                flag = true;

            }
            return;
        } else if (TI == 2 && SI == 1) {
            TERMINATE(3);
        } else if (TI == 2 && SI == 2) {
            WRITE(RA);
            TERMINATE(3);
        } else if (TI == 2 && SI == 3) {
            TERMINATE(0);
        } else if (TI == 2 && PI == 1) {
            TERMINATE(7);
        } else if (TI == 2 && PI == 2) {
            TERMINATE(8);
        } else if (TI == 2 && PI == 3) {
            TERMINATE(3);
        } else {
            TERMINATE(3);
        }

    }

    void SIMULATION() {
        pcb.TTC++;
        if (pcb.TTC > pcb.TTL) {
            TI = 2;
        }

    }

    void EXECUTEUSERPROGRAM() {
        while (true) {
            if (flag) {
                break;
            }
            if (reachedEnd) {
                break;
            }
            int pt = ADDRESSMAP(IC);
            IR[0] = memory[pt][0];
            IR[1] = memory[pt][1];
            IR[2] = memory[pt][2];
            IR[3] = memory[pt][3];
            IC++;
            if (IR[0] != 'H') {
                for (int i = 0; i < 2; i++) {
                    if (!(IR[i + 2] > 47 && IR[i + 2] < 58)) {
                        PI = 2;
                        break;
                    }
                }
            }

            if (pcb.TTC + 1 > pcb.TTL && PI == 2) {
                TI = 2;
                mos(0);
                return;
            }

            int ra = -1;
            if (IR[0] != 'H' && PI == 0) {
                ra = ADDRESSMAP(Integer.parseInt(String.valueOf(IR[2]) + String.valueOf(IR[3])));

            }
            if (PI != 0) {
                mos(0);
                if (pageFault) {
                    IC--;
                    pageFault = false;
                    PI = 0;
                    continue;
                }
                break;
            }

            if (IR[0] == 'G' && IR[1] == 'D') {
                SI = 1;
                mos(ra);
                SIMULATION();
            } else if (IR[0] == 'P' && IR[1] == 'D') {
                SI = 2;
                mos(ra);
                SIMULATION();
            } else if (IR[0] == 'H') {
                SI = 3;
                mos(ra);
                SIMULATION();
                reachedH = true;
                break;
            } else if (IR[0] == 'L' && IR[1] == 'R') {
                for (int i = 0; i < 4; i++) {
                    R[i] = memory[ra][i];
                }
                SIMULATION();
            } else if (IR[0] == 'S' && IR[1] == 'R') {
                for (int i = 0; i < 4; i++) {
                    memory[ra][i] = R[i];
                }
                SIMULATION();
            } else if (IR[0] == 'C' && IR[1] == 'R') {
                if (memory[ra][0] == R[0] && memory[ra][1] == R[1] && memory[ra][2] == R[2] && memory[ra][3] == R[3]) {
                    C = 1;
                } else {
                    C = 0;
                }
                SIMULATION();
            } else if (IR[0] == 'B' && IR[1] == 'T') {
                if (C == 1) {
                    IC = Integer.parseInt(String.valueOf(IR[2]) + String.valueOf(IR[3]));
                    C = 0;
                }
                SIMULATION();
            } else {
                PI = 1;

                SIMULATION();
                mos(0);
                return;
            }

            if (reachedH) {
                reachedH = true;
                return;
            }

            if (TI == 2) {
                mos(0);
                return;
            }

            for (int i = 0; i < 4; i++) {
                IR[i] = '\u0000';
            }

        }

    }

    public static void main(String[] args) {
        OS_CP ubuntu = new OS_CP();
        try {
            ubuntu.LOAD("inputfile1.txt", "Output1.txt");
            ubuntu.printMemory();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
***********************************************************************
