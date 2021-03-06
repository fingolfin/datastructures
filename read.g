#############################################################################
##
#W    read.g                 The GAPData package              Markus Pfeiffer
##

#############################################################################
##
#R  Read the install files.
##

DeclareInfoClass( "InfoGAPData" );
SetInfoLevel( InfoGAPData, 1 );


ReadPackage("gapdata", "gap/lqueue.gi");

ReadPackage("gapdata", "gap/avltree.gi");
ReadPackage("gapdata", "gap/hash.gi");
ReadPackage("gapdata", "gap/cache.gi");
ReadPackage("gapdata", "gap/dllist.gi");

ReadPackage("gapdata", "gap/pairingheap.gi");


# ReadPackage("gapdata", "gap/cache2.gi");

#E  read.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

