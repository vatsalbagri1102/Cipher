// version 1.0 11/12/2022
#include <stdio.h>
#include "cipher.h"

#ifdef MYDECRYPT_C
TODO("using Cdecrypt.c");

int
decrypt(char *iobuf, char *bookbuf, int cnt)
{
    
    char output = 0;
   
    for (int i = 0; i < cnt; i++) {
        //xor to get the reverse version of the original
        *iobuf = *bookbuf ^ *iobuf;
        bookbuf++;

        for (int j = 0; j < BITS; j++) {

            unsigned int last = 0;

            output = output<<1; //shift output to the left (make space for next)            
            last = *iobuf % 2;    //get access to the last element
            output += last;  // update new char with last element of iobuf
            *iobuf = *iobuf>>1;    //shift right iobuf by 1 (access next to last)

    
        }

        *iobuf = output; // reassign iobuf to the original version
        iobuf++;
        
    }

    return cnt;
}

#elif defined MYDECRYPT_S
TODO("using decrypt.S");
#else
TODO("using solution decrypt");
#endif
