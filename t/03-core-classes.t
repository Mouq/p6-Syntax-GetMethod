use Test;
use Syntax::GetMethod;
plan 4;

lives_ok { Array.::join(<o k>, "") }, ".::method works on core types";
my &reversejoin;
lives_ok { &reversejoin = Array.::join }, "Can grab .::methods from core types";

lives_ok { reversejoin(<thing to join>, "~") }, "Grabbed .::method can be called...";

try {
    is reversejoin(<thing to join>, "~"), "thing~to~join", "...and does the right thing";
}
