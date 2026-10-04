# Rat Programming Language

## Build and run the existing checks

Use CMake 3.15 or newer and a compiler supporting C++20. The current executable
runs eight lexer/parser/compiler/semantic test groups; it is not a complete
language command-line interface.

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build
cd build
ctest --output-on-failure
```

On Windows, run these commands in a Visual Studio Native Tools prompt and add
`-G "NMake Makefiles"` to the configure command. For multi-configuration generators,
select the configuration with `cmake --build build --config Debug` and
`ctest -C Debug --output-on-failure`.

CMake honors the selected compiler and build configuration. The source uses
C++20; it does not require C++23. Assertions remain enabled for this test executable
in Release too. Enable AddressSanitizer on GCC/Clang with
`-DRAT_ENABLE_ASAN=ON`.

On systems with GNU Make and a single-configuration CMake generator, `make rat`
configures, builds and runs the checks from the build directory. `make compile`
additionally uses Clang to compile the generated `build/data/compile.ll` and runs
the result. Set `BUILD_DIR`, `CMAKE`, `CMAKE_FLAGS` or `CLANG` to override those defaults.
CTest supplies the copied data directory; generated IR stays in the build tree.

![Logo](https://i.imgur.com/X0G455X.jpeg)

## Introduction

"In many ways, the work of a programmer is easy. We risk very little yet enjoy a position over those who offer up their code and their selves to our judgment. We thrive on ambiguous commit messages, which are fun to write and to read. But the bitter truth we programmers must face, is that in the grand scheme of things, the average piece of junk code is probably more meaningful than our criticism designating it so. But there are times when a programmer truly risks something, and that is in the discovery and defense of the new. The world is often unkind to new talent, new creations. The new needs friends.

Last night, I experienced something new, an extra-ordinary language from a singularly unexpected source. To say that both the language and its maker have challenged my preconceptions about fine coding is a gross understatement. They have rocked me to my core. In the past, I have made no secret of my disdain for Alan Turing's famous quote: ‘Sometimes it is the people no one can imagine anything of who do the things no one can imagine.’ But I realize, only now do I truly understand what he meant. Not everyone can become a great computer scientist, but a great computer scientist can come from anywhere. It is difficult to imagine more humble origins than those of the genius now cooking at RatLang, who is, in this programmer's opinion, nothing less than the finest coder on Github. I will be returning to noahjhan/rat soon, hungry for more."

-Anonymous Reviewer

Rat is a bare bones, general purpose, statically-typed, purely functional, 'rataturing-complete', personal-project programming language inspired by the Pixar film, Ratatouille. It combines features of Haskell, C, OCaml, and Rust. But is currently a glorified lexer. Honestly, it is a gloried main.cpp file. #UNIT_TESTING! 

## Informal Grammar

### Basic Syntax

**Hello World**: A simple rat program

    fn_ main() {
        println("Hello, World")
        rev                         // return void
    }

**Keywords**: 

fn specifies a pure function - first class function with static return type

fn_ specifies a void function - no return (this is useful for syscalls) 

fn? specifies an optional function - can return NULL, output will be cast to optional type

fn/ specifies an anonymous or lambda function

**Loops**: Recursion

Rat is a functional programming language, which means no conventional for-loops. 

    fn_ printer(start: uint, end: uint) {
        if (start >= end) {                 // base case
            rev
        }

        print(start)
        printer(start + 1, end)             // recursive step 
        rev
    }


    fn_ main() {
        printer(0, 9)
        rev
    }
    
    // expected output: "0123456789"

**Conditional Statments**

    let x: int = 10

    if (x > 10) {
        print("x is greater than 10")
    } else if (x < 10) {
        print("x is less than 10")
    } else {
        print("x is equal to 10")
    }

    // expected output: "x is equal to 10"
