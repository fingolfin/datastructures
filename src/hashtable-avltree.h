#ifndef HASHTABLE_AVLTREE_H
#define HASHTABLE_AVLTREE_H

#include "src/compiled.h" /* GAP headers */

extern Obj HTGrow;

Obj HTAdd_TreeHash_C(Obj self, Obj ht, Obj x, Obj v);
Obj HTValue_TreeHash_C(Obj self, Obj ht, Obj x);
Obj HTDelete_TreeHash_C(Obj self, Obj ht, Obj x);
Obj HTUpdate_TreeHash_C(Obj self, Obj ht, Obj x, Obj v);

#endif
