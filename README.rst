
Benchmark of compile speed inside and outside Docker
=================================================

Summary
-------------------------------

To get right to the point: there are slight differences between what Docker does and what the command line does, so take this with a grain of salt, but it seems Docker is about 35% slower.

What I did
-------------------------------

I took many of the top 300 crates from crates.io and compiled them in release mode using nightly, one inside docker and once directly form the command line. (All of them compiled without any error or warning, cool right?).

Both versions use the same nightly version, the install of which is not part of the benchmark (a separate Docker image is made). The Docker image compiles the dependencies separately, since that's what I would do for caching reasons as a normal workflow. This means the process is not exactly the same with and without docker, and the difference may be as large as 3s.

Wall time is compared, since the ``time`` program does not measure Docker's system and user time correctly.

Get your own data
-------------------------------

The results might depend on hardware or OS, so you should measure for yourself. If you have rustup, Docker and bash installed, just run ``./benchmark.sh``.

If you get different results, feel free to create an issue for them to be included!

My results
-------------------------------

    native: real 172.71 s
    native: real 181.85 s
    native: real 199.70 s

    docker: real 242.26 s
    docker: real 257.58 s
    docker: real 248.54 s

So 185s vs 249s, about 35% extra time for Docker (statistically significant at p=0.05).

Why
-------------------------------

I don't know why this is the code, the difference is larger than I would have thought.

If you have any idea, please create an issue or pull request!
