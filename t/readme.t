use Syntax::GetMethod;

# Workaround for not being in core:
class Num is Num {}
say Num.::Rat.signature; # Signature of Num.Rat

class Human {
    has $!name;
    method BUILD(:$!name) {}
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
