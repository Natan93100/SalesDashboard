#include <stdio.h>
#include <stdlib.h>

int MaxSequence(int x, int y) {
    if (x > y)return x;
    else return y;
}

int MaxLengthOfEachSequence(int
arrOfSequence[], int arr[], int len) {
    int MaxArray = 0;
    int i = 0;
    int arg = 0;
    while (i != len - 1) {
        if (arr[i] % 2 == 0) {
            if (arr[i + 1] - arr[i] == 2) {
                arrOfSequence[arg]++;
                i++;
            } else {
                arrOfSequence[arg]++;
                arg++;
                i++;
            }
        } else { i++; }
    }
    if (i == len - 1) {
        if (arr[i] % 2 == 0) { arrOfSequence[arg]++; }
        else {}
    }
    for (int i = 0; i < 5; i++) {
        int Maxtemp =
                MaxSequence(arrOfSequence[i], arrOfSequence[i + 1]);
        if (Maxtemp >
            MaxArray && Maxtemp <= 10) { MaxArray = Maxtemp; }
    }
    return MaxArray;

}


void longestContinuousEvenSequence(int arr[], int len) {
    int arrOfSequence[5] = {0};
    int MaxLengthOfSequence =
            MaxLengthOfEachSequence(arrOfSequence, arr, len);
    int finalpos = 0;
    int counter = 0;
    int a = MaxLengthOfSequence;
    if (MaxLengthOfSequence > 1) {
        printf("The longest sequence with "
               "continuous even numbers is: ");
        for (int i = 0; i <= len - 1; i++) {
            if (i != len - 1) {
                if (arr[i] % 2 == 0) {
                    if (arr[i + 1] - arr[i] == 2) {
                        counter++;
                    } else {
                        counter++;
                        if (counter == a) {
                            finalpos = i;
                            break;
                        } else { counter = 0; }
                    }
                } else { continue; }
            } else {
                if (arr[i] % 2 == 0) {
                    finalpos = i;
                    break;
                }
            }
        }

        int arr3[12];
        counter = MaxLengthOfSequence - 1;
        for (int i = finalpos; i > finalpos -
                                   MaxLengthOfSequence; i--) {
            arr3[counter] = arr[i];
            counter--;
        }
        for (int i = 0; i <= MaxLengthOfSequence - 1; i++) {
            printf("%d ", arr3[i]);
        }


    } else if (MaxLengthOfSequence == 0) {
        printf("No even sequence in the array");
    } else if (MaxLengthOfSequence == 1) {
        printf("The longest sequence with "
               "continuous even numbers is: ");
        for (int i = 0; i < len - 1; i++) {
            if (arr[i] % 2 == 0) {
                printf("%d ", arr[i]);
                break;
            }
        }
    }
}


int main() {
    int len_array = 0;
    // First enter the size of the array
    scanf("%d", &len_array);
    // allocating the array - will be explained later in the course
    int *arr = malloc(sizeof(int) * len_array);
    if (arr) {
        // Enter the numbers that the array will hold
        for (int start_index = 0; start_index < len_array; start_index++) {
            scanf("%d", &(arr[start_index]));
        }
        longestContinuousEvenSequence(arr, len_array);
    }
    // Freeing the array - will be explained later in the course
    free(arr);
    return 0;
}