# Digressions about +RTS

Running other than `+RTS -h` requires Tamarin to be built with `-prof` GHC
option, which in theory should be covered by `-fprof-auto -rtsopts` together
with `--executable-profiling` etc. However, for some reasons the runtime still
complains about lack of `-prof`. Moreover, running `-prof` with `stack` is not
allowed.
