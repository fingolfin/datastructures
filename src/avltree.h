#ifndef AVLTREE_H
#define AVLTREE_H

#include "src/compiled.h" /* GAP headers */

/* Interface for AVLTrees */
extern Obj AVLTreeType;
extern Obj AVLTreeTypeMutable;
extern Obj AVLTree;

Obj AVLCmp_C(Obj self, Obj a, Obj b);
Obj AVLNewNode_C( Obj self, Obj t );
Obj AVLFreeNode_C( Obj self, Obj t, Obj n);
Obj AVLFind_C( Obj self, Obj t, Obj d );
Obj AVLIndexFind_C( Obj self, Obj t, Obj i );
Obj AVLFindIndex_C( Obj self, Obj t, Obj d );
Obj AVLLookup_C( Obj self, Obj t, Obj d );
Obj AVLIndex_C( Obj self, Obj t, Obj i );
Obj AVLIndexLookup_C( Obj self, Obj t, Obj i );
Obj AVLRebalance_C( Obj self, Obj tree, Obj q );
Obj AVLAdd_C( Obj self, Obj tree, Obj data, Obj value );
Obj AVLIndexAdd_C( Obj self, Obj tree, Obj data, Obj value, Obj ind );
Obj AVLDelete_C( Obj self, Obj tree, Obj data);
Obj AVLIndexDelete_C( Obj self, Obj tree, Obj index);

Int AVLFind( Obj t, Obj d );
Obj AVLValue( Obj t, Int n );
void SetAVLValue( Obj t, Int n, Obj v );

#endif
