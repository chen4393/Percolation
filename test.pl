#!/usr/bin/perl -l

my %color_of = (
    apple  => "red",
    orange => "orange",
    grape  => "purple",
);

$color_of{apple} = "green";
print "$color_of{apple}";

$color_of{water} = undef;

for my $fruit (keys %color_of) {
    print "The color of '$fruit' is $color_of{$fruit}";
}

print scalar keys %color_of;

@array = (1..5);

$aref = \@array;
print aref;

=begin
while ($element = shift(@array)) {
   print("$element - ");
}
print("The End");
=end

