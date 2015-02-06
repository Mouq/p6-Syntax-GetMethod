# Syntax::GetMethod

Implements syntactic sugar for getting the method of a package.

## Synopsis

    use Syntax::GetMethod;

    class Num is Num {} # Workaround for not being in core
    say Num.::Rat.signature; # Signature of Num.Rat

    class Human {
        has $!name;
        method whoami {
            $!name;
        }
    }
    class Amnesiac is Human {
        method whoami {
            "Uhh..."
        }
    }
    my &recall-name = Human.::whoami;
    my $am = Amnesiac.new(:name<Margaret>);
    say $am.whoami; # "Uhh..."
    say recall-name $am; # "Margaret"

## Motivation

Languages with a focus on the functional paradigm, (Javascript will be as an
example), generally allow for syntactically simple retrieval of method-objects.
Javascript simply requires omission of parentheses:

    foo.my-method

In Perl 6, the default behavior of that syntax is to call "my-method". To
actually get the method object, relatively cumbersome meta-object calls must be
used:

    $foo.^find_method('my-method')

This topic comes up with some regularity on #perl6, and the best solution that
can be offered is "use the metamodel".

## Description

A potential alternative to the above in Perl 6 could be:

    $foo.::my-method

This has the advantages of being similar to package lookup syntax of the form
`$foo::our-sub`, or `$foo.Bar::bar's-method` and being unused by any other construct.

    $foo.::my-method($bar)

is then interpreted as getting `$foo.::my-method` and then calling it with
`$bar` as the invocant. Similarly with multiple arguments.

## Issues

Currently, `$foo.::my-method` *will* be parsed, however in all cases it is
exactly equivalent to `$foo.my-method`. The probability that anyone is using
his syntax is... exceptionally low.

The documentation also calls the `$foo.Bar::my-method` syntax `postfix .::`.
The title of this would need to be clarified.

One of the issues in *this* implementation is that augmenting Mu to support
`dispatch:<.::>` doesn't augment all the other classes to support it. I'm not
sure if this is correct behavior. However, having this syntax in core would
solve this issue.
