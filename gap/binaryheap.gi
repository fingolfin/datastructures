# Binary max-heap represented as an array
PCQL_Heap_Insert := "TODO";

PCQL_Heap_Create := function(arg)
    local isLess, data, heap, x;

    isLess := \<;
    data := [];

    if Length(arg) = 1 then
        if IsFunction(arg[1]) then
            isLess := arg[1];
        else
            data := arg[1];
        fi;
    elif Length(arg) = 2 then
        isLess := arg[1];
        data := arg[2];
    elif Length(arg) > 2 then
        Error("Wrong number of arguments");
    fi;

    heap := rec( isLess := isLess, data := [] );
    for x in data do
        PCQL_Heap_Insert(heap, x);
    od;
    return heap;
end;

PCQL_Heap_IsEmpty := function(heap)
    return Length(heap.data) = 0;
end;

PCQL_Heap_Size := function(heap)
    return Length(heap.data);
end;

# TODO: iterator; view/print; Random; ...

# Alternative name: Peek
PCQL_Heap_FindMax := function(heap)
    if Length(heap.data) = 0 then return fail; fi; # alternative: error
    return heap.data[1];
end;

_PCQL_Heap_BubbleUp := function(data, isLess, i, elm)
    local parent;
    while i > 1 do
        parent := QuoInt(i, 2);
        if not isLess(data[parent], elm) then
            break;
        fi;
        data[i] := data[parent];
        i := parent;
    od;
    data[i] := elm;
end;

# Alternative name: Push / Add
_PCQL_Heap_Insert_GAP := function(heap, elm)
    _PCQL_Heap_BubbleUp(heap.data, heap.isLess, Length(heap.data) + 1, elm);
end;

if IsBound(_PCQL_Heap_Insert_C) then
	PCQL_Heap_Insert := _PCQL_Heap_Insert_C;
else
	PCQL_Heap_Insert := _PCQL_Heap_Insert_GAP;
fi;

_PCQL_Heap_ReplaceMax_GAP := function(heap, elm)
    local data, isLess, i, left, right;
    data := heap.data;
    isLess := heap.isLess;
    i := 1;
    # treat the head slot as a hole that we bubble down
    while 2 * i <= Length(data) do
        left := 2 * i;
        right := left + 1;
        if right > Length(data) or isLess(data[right], data[left]) then
            data[i] := data[left];
            i := left;
        else
            data[i] := data[right];
            i := right;
        fi;
    od;

    # Insert the new element into the hole bubble it up.
    _PCQL_Heap_BubbleUp(heap.data, heap.isLess, i, elm);
end;

if IsBound(_PCQL_Heap_ReplaceMax_C) then
	PCQL_Heap_ReplaceMax := _PCQL_Heap_ReplaceMax_C;
else
	PCQL_Heap_ReplaceMax := _PCQL_Heap_ReplaceMax_GAP;
fi;

# Alternative name: Pop / Remove
PCQL_Heap_RemoveMax := function(heap)
    local val, data;
    data := heap.data;

    if Length(data) = 0 then
        return fail; # alternative: error
    elif Length(data) = 1 then
        return Remove(data);
    fi;

    val := data[1];
    PCQL_Heap_ReplaceMax(heap, Remove(data));
    return val;
end;


PCQL_Heap_IsValid := function(heap)
    local data, i, left, right;
    data := heap.data;
    for i in [1..Length(data)] do
        left := 2 * i;
        right := left + 1;
        if left <= Length(data) and heap.isLess(data[i], data[left]) then
            Print("data[",i,"] = ",data[i], " < ",data[left]," = data[",left,"]\n");
            return false;
        fi;
        if right <= Length(data) and heap.isLess(data[i], data[right]) then
            Print("data[",i,"] = ",data[i], " < ",data[right]," = data[",right,"]\n");
            return false;
        fi;
    od;
    return true;
end;

# DecreaseKey ?
# Merge ?
