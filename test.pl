#!/usr/bin/perl

=begin
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
=cut

@array1 = (1..5);
@array2 = (6..8);

=begin
while ($element = shift(@array)) {
   print("$element - ");
}
print("The End");
=cut

%table = ();
$table{0} = \@array1;
$table{1} = \@array2;
$table{3} = \@array1;
#$aref = \@array;

=begin
foreach (sort keys %table) {
	print "$_ : $table{$_}\n";
}
=cut

@queue = @{$table{1}};
#print_array(@queue);

$q_size = @queue;

print "$q_size";

sub print_array {
	my @list = @_;
	while ($element = shift(@list)) {
		print("$element - ");
	}
	print("The End");
}


