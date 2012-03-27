# What is PrepArg ?

PrepArg is a simple and *agnostic* argument parser for C and C++, based primarily on preprocessor directives. Thus:
* it does not allocate any dynamic memory;
* it does not depend on any specific library;
* it is highly configurable.

It follows the [GNU conventions](http://www.gnu.org/software/libc/manual/html_node/Argument-Syntax.html).

Following the DRY (Don't Repeat Yourself) principles, things are specified once (as much as possible).

# A simple example

## Declarations

Arguments must by defined in a separate file, containing declarations like:

```cpp
DESCRIPTION( "test prg" );

SARG( 's', my_string , "A string" , "default value" );
BARG( 'b', my_boolean, "A boolean", false );
```

`SARG` means String argument. By default, it will be stored in a `const char *`.`SARG` means boolean argument (a flag).

Arguments of `SARG`, `BARG`, ... are:
* char for single letter options (-s, -b, ...). as specified by the gnu conventions, multiple options (specified with the single char versions) may follow a hyphen delimiter in a single token if the options do not take arguments. Thus, ‘-abc’ is equivalent to ‘-a -b -c’.
* variable name. This value is also used for long options, but '_' are replace by '-'. In this example, PrepArg will look for '--my-string' and '--my-boolean'
* argument description. Used by the usage function.
* default value.

## Use

To use these declarations, you have to `#define` a macro containing the name of this file and `#include` the PrepArg files to get the corresponding functionnalities, as in:


```cpp
// path of the aformentionned file
#define PREPARG_FILE "../my_args.h"

// will include the "generated" usage function (and some helpers for parse)
#include <PrepArg/usage.h>

int main( int argc, char **argv ) {
    // will include the variables declaraction (my_string, my_boolean, ...) with their default values
    #include <PrepArg/declarations.h>

    // for loop that will parse the arguments of main
    #include <PrepArg/parse.h>

    // helper that will display the arguments names, and their values
    #include <PrepArg/info.h>

    // obviously, results can be used directly
    int foo = 2 * my_boolean;
}
```


# Configuration

Configuration may be done using `#define` and main options are defined in [src/PrepArg/default_values.h].

For example, if `const char *` is to be replaced by `std::string`, one can write something like

```cpp
#define PREPARG_S( A ) std::string A
#include <PrepArg/usage.h>

int main( int argc, char **argv ) {
    ...
}
```

By the way, some configurations issues can also be treated using specific `.h` files, as e.g. in [tests/test_class.cpp] which illustrates how to store the variables as class attributes.


# And now ?

This code is under the LGPLv3 license.

Feel free to use it and... if you want to add some new types (`xARG`) or new functionnalities, you are very welcome !
