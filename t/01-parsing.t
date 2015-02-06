use Test;
use Syntax::GetMethod;
plan 4;

macro noopify(*@p) {
    quasi {}
}
sub parses_ok(Str $test, *@p) {
    lives_ok { EVAL 'noopify $test' }, |@p;
}

parses_ok 'Array.::join', "Getmethod syntax works on types";
parses_ok 'noopify Array.::join([1,2], "-")', "Can parse call to gotten method";

parses_ok 'noopify (<arbitrary> ~ <object>).::join', "Can parse getmethod syntax on whatever";
parses_ok 'noopify (<arbitrary> ~ <object>).::join(<something else>.item, "!")', "Can parse call to gotten method";

# vim: ft=perl6
