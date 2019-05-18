
## First create the compiler image by running
##   docker build --file Dockerfile.nightly --tag bench_rust_nightly .

# Make sure to change the version/date everywhere (I couldn't get ARG to work), i.e. `rustup default`
FROM bench_rust_nightly

ENV RUST_BACKTRACE 1
ENV RUSTFLAGS "-D warnings"

# Copy Cargo file only to compile dependencies in a separate layer
COPY Cargo.toml ./Cargo.toml
COPY Cargo.lock ./Cargo.lock

# Create a dummy main file so compiling dependencies works
RUN mkdir src && printf "// dummy file for building dependencies only" > src/main.rs

# Build the dependencies, to have a cached layer
RUN cargo build --all --release

# Copy the code
COPY /src ./src

# Compile the application
RUN cargo build --all --release
