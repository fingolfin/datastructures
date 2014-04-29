#############################################################################
##
#W  queue.gd                    GAP library                   Reimer Behrends
##
##
#Y  Copyright (C) 2013 The GAP Group
##
##  This file implements queues. These can be used both as FIFO queues,
##  as deques, and as stacks.

InstallMethod(NewQueue,
        "for IsPlistQueueRep, a sample object, and a positive integer", 
        [IsPlistQueueRep, IsObject, IsPosInt],
function(filter, sample, capacity)
  local result, i, t;
  
  result := [1, 1, capacity, EmptyPlist(capacity)];
  for i in [1..capacity] do
    result[4][i] := fail;
  od;
  
  t := NewType(CollectionsFamily(FamilyObj(sample)), filter and IsPositionalObjectRep);
  
  Objectify(t, result);

  return result;
end);

InstallMethod(PushQueueBack,
        "for IsPlistQueue and an object",
        [IsPlistQueueRep, IsObject],
function(queue,el)
  local head, tail, last;
  head := queue![QHEAD];
  tail := queue![QTAIL];
  last := queue![QCAPACITY];
  if tail = last then
    if head = 1 then
      PlistQueueExpand(queue);
      tail := queue![QTAIL];
      queue![QDATA][tail] := el;
      tail := tail + 1;
      queue![QTAIL] := tail;
    else
      queue![QTAIL] := 1;
      queue![QDATA][last] := el;
    fi;
  elif tail + 1 <> head then
    queue![QDATA][tail] := el;
    tail := tail + 1;
    queue![QTAIL] := tail;
  else
    PlistQueueExpand(queue);
    tail := queue![QTAIL];
    queue![QDATA][tail] := el;
    tail := tail + 1;
    queue![QTAIL] := tail;
  fi;
end);

InstallMethod(PushQueueFront,
        "for IsPlistQueue and an object",
        [IsPlistQueueRep, IsObject],
function(queue, el)
  local head, tail, last;
  head := queue![QHEAD];
  tail := queue![QTAIL];
  last := queue![QCAPACITY];
  if head = 1 then
    if tail = last then
      PlistQueueExpand(queue);
      head := queue![QCAPACITY];
      queue![QDATA][head] := el;
      queue![QHEAD] := head;
    else
      queue![QHEAD] := last;
      queue![QDATA][last] := el;
    fi;
  elif tail + 1 <> head then
    head := head - 1;
    queue![QDATA][head] := el;
    queue![QHEAD] := head;
  else
    PlistQueueExpand(queue);
    head := Length(queue);
    queue![QDATA][head] := el;
    queue![QHEAD] := head;
  fi;
end);

InstallMethod(PopQueueFront,
        "for IsPlistQueue and an object",
        [IsPlistQueueRep],
function(queue)
  local head, tail, last, result;
  head := queue![QHEAD];
  tail := queue![QTAIL];
  last := queue![QCAPACITY];
  if head <> tail then
    if head = last then
      head := 1;
      result := queue![QDATA][last];
      queue![QDATA][last] := fail;
    else
      head := head + 1;
      result := queue![QDATA][head-1];
      queue![QDATA][head-1] := fail;
    fi;
    queue![QHEAD] := head;
    return result;
  fi;
  return fail;
end);

InstallMethod(PopQueueBack,
        "for IsPlistQueue and an object",
        [IsPlistQueueRep],
function(queue)
  local head, tail, last, result;
  head := queue![QHEAD];
  tail := queue![QTAIL];
  last := queue![QCAPACITY];
  if head <> tail then
    if tail = 1 then
      tail := last;
    else
      tail := tail - 1;
    fi;
    result := queue![QDATA][tail];
    queue![QDATA][tail] := fail;
    queue![QTAIL] := tail;
    return result;
  fi;
  return fail;
end);

InstallMethod(IsEmpty,
        "for IsPlistQueue",
        [IsPlistQueueRep],
function(queue)
  return queue![QHEAD] = queue![QTAIL];
end);

InstallMethod(Length,
        "for IsPlistQueue",
        [IsPlistQueueRep],
function(queue)
  local head, tail;
  head := queue![QHEAD];
  tail := queue![QTAIL];

  if tail >= head then
    return tail - head;
  else
    return Capacity(queue) - (head - tail);
  fi;
end);

InstallMethod(Capacity,
        "for IsPlistQueue",
        [IsPlistQueueRep],
function(queue)
    return queue![QCAPACITY];
end);

InstallGlobalFunction(PlistQueueExpand,
function(queue)
  local result, p, head, tail, last;
  head := queue![QHEAD];
  tail := queue![QTAIL];
  last := queue![QCAPACITY];
  queue![QCAPACITY] := queue![QCAPACITY] * 2;
  p := queue![QCAPACITY];
  result := EmptyPlist(p);
  while p > 0 do
    result[p] := fail;
    p := p - 1;
  od;
  p := 1;
  while head <> tail do
    result[p] := queue![QDATA][head];
    p := p + 1;
    head := head + 1;
    if head > last then
      head := 1;
    fi;
  od;
  queue![QTAIL] := p;
  
  queue![QDATA] := result;
end);

InstallMethod( ViewObj,
        "for a PlistQueue",
        [ IsPlistQueueRep ],
function(queue)
    Print("<queue with ");
    Print(Length(queue),"/",Capacity(queue));
    Print(" entries>");
end);

InstallMethod( PrintObj,
        "for a PlistQueue",
        [ IsPlistQueueRep ],
function(queue)
  Print("<queue with ");
  Print(Length(queue),"/",Capacity(queue));
  Print(" entries: \n");
  Print(queue![QDATA]);
  Print(">");
end);

