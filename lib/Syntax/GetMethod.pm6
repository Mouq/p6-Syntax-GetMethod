use MONKEY_TYPING;
#slang GetMethod {
# ...
#}
role Syntax::GetMethod::Grammar {
    # XXX NOT COMPOSABLE
    # Hopefully in the future there will be a way to just add '::' to the
    # alternation without having to copy the entire token definition.
    token dotty:sym<.*> {
         $<sym>=['.' [ <[+*?=]> | '^' '!'? | '::' ]] <dottyop>
         <O('%methodcall')>
    }
}

augment class Mu {
    proto method dispatch:<.::>(Mu \SELF: $name, |c) {*}
    multi method dispatch:<.::>(Mu \SELF: $name) {
        SELF.^find_method($name)
    }
    multi method dispatch:<.::>(Mu \SELF: $name, |c) {
        SELF.^find_method($name)(|c)
    }
}

sub slangify ($role, :$into = 'MAIN') {
    nqp::bindkey(%*LANG, $into, %*LANG{$into}.HOW.mixin(%*LANG{$into}, $role));
}

sub EXPORT {
    slangify Syntax::GetMethod::Grammar;
    {}
}
