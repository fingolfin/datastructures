/*
 * PCQL: Polycyclic Quotients of L-Presented Groups
 * Copyright (C) 2010-2014  Max Horn
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#ifndef PCQL_HASH_H
#define PCQL_HASH_H

#include "src/compiled.h"          /* GAP headers                */

extern UInt PCQL_Capacity_RNam;
extern UInt PCQL_Deleted_RNam;
extern UInt PCQL_Size_RNam;
extern UInt PCQL_Keys_RNam;
extern UInt PCQL_Vals_RNam;
extern UInt PCQL_HashFun_RNam;
extern UInt PCQL_EqFun_RNam;


Obj _PCQL_Hash_Lookup_C(Obj self, Obj ht, Obj key);
Obj _PCQL_Hash_LookupCreate_C(Obj self, Obj ht, Obj key);

Obj _PCQL_Hash_Resize_C(Obj self, Obj ht, Obj new_capacity);
Obj _PCQL_Hash_SetValue_C(Obj self, Obj ht, Obj key, Obj val);
Obj _PCQL_Hash_AccumulateValue_C(Obj self, Obj ht, Obj key, Obj val);

#endif
