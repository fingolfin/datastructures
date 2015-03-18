#ifndef PCQL_HEAP_H
#define PCQL_HEAP_H

#include "src/compiled.h"          /* GAP headers                */

extern UInt PCQL_isLess_RNam;
extern UInt PCQL_data_RNam;

Obj _PCQL_Heap_Insert_C(Obj self, Obj heap, Obj elm);
Obj _PCQL_Heap_ReplaceMax_C(Obj self, Obj heap, Obj elm);

#endif
