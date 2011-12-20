# File Pairs

*Finds .nef files, which have been abandoned by their .jpeg files. Figures out where to move them, or whether to delete them.*

## Build

From project root:

    cake build

## Test

    node production/src/js/pair_resolver.js test/fixtures/with-subdirectories-some-deleted-some-moved/ |less
