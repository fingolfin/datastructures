#include "binaryheap.h"

UInt PCQL_isLess_RNam = 0;
UInt PCQL_data_RNam = 0;


static void _PCQL_Heap_BubbleUp_C(Obj data, Obj isLess, Int i, Obj elm)
{
    if ( LEN_PLIST( data ) < i ) {
        GROW_PLIST( data, i );
        SET_LEN_PLIST( data, i );
        CHANGED_BAG( data );
    }

    while (i > 1) {
        Obj parent = ELM_PLIST(data, i >> 1);
        if (False == CALL_2ARGS(isLess, parent, elm))
            break;
        SET_ELM_PLIST( data, i, parent );
        CHANGED_BAG( data );
        i >>= 1;
    }

    SET_ELM_PLIST( data, i, elm );
    CHANGED_BAG( data );
}

static Int _PCQL_Heap_BubbleDown_C(Obj data, Obj isLess, Int i, Obj elm)
{
    Int len = LEN_PLIST(data);
    while (2 * i <= len) {
        Int left = 2 * i;
        Int right = 2 * i + 1;
        if (right > len || True == CALL_2ARGS(isLess, ELM_PLIST(data, right), ELM_PLIST(data, left))) {
            SET_ELM_PLIST( data, i, ELM_PLIST(data, left) );
            i = left;
        } else {
            SET_ELM_PLIST( data, i, ELM_PLIST(data, right) );
            i = right;
        }
        CHANGED_BAG( data );
    }

    return i;
}

Obj _PCQL_Heap_Insert_C(Obj self, Obj heap, Obj elm)
{
    Obj data = ElmPRec(heap, PCQL_data_RNam);
    Obj isLess = ElmPRec(heap, PCQL_isLess_RNam);

    if (!IS_DENSE_PLIST(data))
        ErrorQuit("<data> is not a dense plist", 0L, 0L);

    Int len = LEN_PLIST(data);
    if (len == 0)
        AssPlistEmpty(data, 1, elm);
        // FIXME: or should we really use AssPlist ??
    else
        _PCQL_Heap_BubbleUp_C(data, isLess, len + 1, elm);

    return 0;
}

/*
TODO: implement efficient _PCQL_Heap_Create_C which runs in O(n) instead
of the native "insert elements using _PCQL_Heap_Insert_C" which runs in
O(n*log(n))

Wikipedia:

Build-Max-Heap[4] (A):
 heap_length[A] <- length[A]
   for i <- floor(length[A]/2) downto 1 do
    Max-Heapify(A, i)

from GAP kernel's HEAP_SORT_PLIST:

  UInt len = LEN_LIST(list);
  UInt i;
  for (i = (len/2); i > 0 ; i--)
    BubbleDown(list, i, len);

*/

/* TODO: implement own alternative to HEAP_SORT_PLIST


And while at it:

SORT_LIST
SortDensePlist
SORT_LISTComp
SortDensePlistComp
SORT_PARA_LIST
SortParaDensePlistPara
SORT_PARA_LISTComp
SortParaDensePlistComp

But PLEASE not by doing lots of copy & paste! Either we (ab)use the preprocessor,
or use a C++ template.


*/

Obj _PCQL_Heap_ReplaceMax_C(Obj self, Obj heap, Obj elm)
{
    Obj data = ElmPRec(heap, PCQL_data_RNam);
    Obj isLess = ElmPRec(heap, PCQL_isLess_RNam);

    if (!IS_DENSE_PLIST(data))
        ErrorQuit("<data> is not a dense plist", 0L, 0L);

    // treat the head slot as a hole that we move down into a leaf
    Int i = _PCQL_Heap_BubbleDown_C(data, isLess, 1, elm);

    // insert the new element into the leaf-hole and move it up
    _PCQL_Heap_BubbleUp_C(data, isLess, i, elm);

    // TODO
    return 0;
}
