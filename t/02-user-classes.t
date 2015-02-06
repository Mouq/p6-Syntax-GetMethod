use Test;
use Syntax::GetMethod;

my class NOK {
    method test($message) {
        say self.^name.lc, " ", ++$, " - ",  $message
    }
}
my class OK is NOK {
}

say '1..2';
NOK.::test(OK, ".::method passes new invocant");
my &tester = NOK.::test;
tester OK, ".::method can be used functionally";
