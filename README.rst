
Benchmark of compile speed inside and outside Docker
=================================================

Summary
-------------------------------

To get right to the point: no statistically significant difference between native and Docker was found.

What I did
-------------------------------

I took most of the top 60 crates from crates.io and compiled them in release mode using nightly, once inside docker and once directly form the command line. (All of them compiled without any error or warning, cool right?).

Both versions use the same nightly version, the install of which is not part of the benchmark (a separate Docker image is made). Downloading dependencies is not part of the benchmark.

Wall time is compared, since the ``time`` program does not measure Docker's system and user time correctly.

An earlier version used 300 crates and had Docker compile dependencies separately for caching, see ``Dockerfile.cache`` if that is of interest (caching compiled dependency is a useful Docker+Rust workflow).

Get your own data
-------------------------------

The results might depend on hardware or OS, so you should measure for yourself. If you have rustup, Docker and bash installed, just run ``./benchmark.sh``.

If you get different results, feel free to create an issue for them to be included!

My results
-------------------------------

    docker: real 39.15 s
    docker: real 40.54 s
    docker: real 40.78 s
    docker: real 40.95 s
    docker: real 41.74 s
    docker: real 41.97 s
    docker: real 42.49 s
    docker: real 42.51 s
    docker: real 43.14 s
    docker: real 45.48 s

    native: real 32.02 s
    native: real 34.76 s
    native: real 38.16 s
    native: real 38.97 s
    native: real 39.27 s
    native: real 39.28 s
    native: real 39.72 s
    native: real 40.17 s
    native: real 41.52 s
    native: real 41.97 s

So 38.6ss vs 41.9s, 8.5% longer on Docker, but this result is not statistically significant.
