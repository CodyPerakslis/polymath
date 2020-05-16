#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
/* Challenge:
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
What is the 10 001st prime number?
*/

#define sieveCount 10000
#define FREE(ptr) free(ptr); ptr = NULL;

int findPrime(int x);
void resetSieve(bool* sieve);
void blockOut(bool* sieve, int start, int stride);
void prepareSieve(bool* sieve, int sieveStart, int* primes, int primeCount);

int main() {
  int x = findPrime(10001);
  printf("Prime: %d\n", x);
  return 0;
}

/*
Run the sieve method with a fixed-sized sieve.
After each usage of the sieve, reset it to apply to the
next sieveCount number of integers.
*/
int findPrime(int x) {
  int* primes = malloc(x*sizeof(int));
  bool* sieve = malloc(sieveCount*sizeof(bool));
  resetSieve(sieve);
  int primeCount = 0;
  int sieveStart = 2;
  int sieveStopUpdate;
  while(primeCount < x) {
    sieveStopUpdate = ceil(sqrt(sieveStart+sieveCount));
    for(int i = 0; i < sieveCount; i++) {
      if (sieve[i]) {
        primes[primeCount++] = sieveStart+i;
        if (primeCount >= x) {
          int result = primes[x-1];
          FREE(primes); FREE(sieve);
          return result;
        }
        if (sieveStart+i < sieveStopUpdate) {blockOut(sieve, sieveStart+2*i, sieveStart+i);}
      }
    }
    sieveStart += sieveCount;
    prepareSieve(sieve, sieveStart, primes, primeCount);
  }
  int result = primes[x-1];
  FREE(primes); FREE(sieve);
  return result;
}

void resetSieve(bool* sieve) {
  for(int i = 0; i < sieveCount; i++) {sieve[i] = true;}
}

void blockOut(bool* sieve, int start, int stride) {
  for (int i = start; i < sieveCount; i+=stride) {sieve[i] = false;}
}

void prepareSieve(bool* sieve, int sieveStart, int* primes, int primeCount) {
  resetSieve(sieve);
  int last;
  int sieveStopUpdate = ceil(sqrt(sieveStart+sieveCount));
  for(int i = 0; i < primeCount && primes[i] < sieveStopUpdate; i++) {
    last = primes[i] * (int)floor(sieveStart/primes[i]);
    if (last >= sieveStart) {
      blockOut(sieve, last-sieveStart, primes[i]);
    } else {
      blockOut(sieve, last+primes[i]-sieveStart, primes[i]);
    }
  }
}
