# MAGMA

MAGMA.jl: wrapper of MAGMA in Julia. Still work in progress.
We thank Roger-luo for the nice code. https://github.com/Roger-luo/MAGMA.jl

## Installation

To use this package, use `dev` in Pkg mode.

```
(pkg)> dev https://github.com/MGYamada/MAGMA.jl.git
```

The Installation of MAGMA and its location of shared library. With the constant 'libmagma' correctly set (by default const libmagma = "/usr/local/magma/lib/libmagma.so"), one should be able to use ccall to call the functions in MAGMA shared lib.

## License

MIT
