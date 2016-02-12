#ifndef HASHTABLE_H
#define HASHTABLE_H

extern Obj HTGrow;

Obj HTAdd_TreeHash_C(Obj self, Obj ht, Obj x, Obj v);
Obj HTValue_TreeHash_C(Obj self, Obj ht, Obj x);
Obj HTDelete_TreeHash_C(Obj self, Obj ht, Obj x);
Obj HTUpdate_TreeHash_C(Obj self, Obj ht, Obj x, Obj v);

#endif
