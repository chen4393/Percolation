#! /usr/bin/perl
# Percolation question 1
use Data::Dumper;
# Inputs Initialization
$n = 100; $m = 10; 
$a = 23; $b = 84; # 2 random vertices
$simTimes = 100; # number of simulation

# run the simulation for all possible p values
# p is connected probability

open(DATA, ">output.txt") or die "Couldn't open file file.txt, $!";

for($p = 0; $p <= 1; $p += 0.01) {
	$sum = 0;
	# simulate 100 times
	for (my $iteration = 0; $iteration < $simTimes; $iteration++) {
		%adjList = (); # adjacency list
		%connList = (); # connected adjacency list
		my $connected = 0;
		
		# build adjacency list
		for (my $i = 0; $i < $n; $i = $i + 1) {
			my $currentNode = $i;
			my @nodeNeighbors = ();
			# choose m neighbors
			my $counter = $m;
			while ($counter > 0) {
				my $randomNode = int(rand($n));
				# keep generating different random vertex
				while (($randomNode == $currentNode) || 
				($randomNode ~~ @nodeNeighbors)) {
					$randomNode = int(rand($n));
				}
				push @nodeNeighbors, $randomNode;
				$counter = $counter - 1;
			}
			# key is vertex index, value is its neighbors
			$adjList{$i} = \@nodeNeighbors;
		}

		# build connected adjacency list
		if ($p eq 0) {
			# no connected, build an empty list for each vertex
			my @connectedNeighbors = ();
			for (my $temp = 0; $temp < $n; $temp++) {
				$connList{$i} = \@connectedNeighbors;
			}
		} elsif ($p eq 1) {
			# all connected, use adjacency list
			%connList = %adjList;
		} else {
			# check all the involved neighbors to see the connectivity
			for (my $j = 0; $j < $n; $j++) {
				my $key = $j;
				my @value = @{$adjList{$key}};
				my @connectedNeighbors = ();
				while($nearby = shift @value) {
					my $randomNumber = rand();
					# regard its neighbor connected with a probability
					if($randomNumber < $p) {
						push @connectedNeighbors, $nearby;
					}
				}
				$connList{$key} = \@connectedNeighbors;
			}
		}

		# check the connectivity of a random vertex a
		@neighbors = @{$connList{$a}};
		$queueSize = @neighbors;
		@visitedNodes = ();
		while($queueSize > 0) {
			# dump one of a's neighbor as element
			my $element = shift @neighbors;
			# mark it as visited
			push @visitedNodes, $element;
			if ($element eq $b) {
				# if b is a's neighbor, count it and break
				$connected = 1;
				last;
			} else {
				my @elementConnections = @{$connList{$element}};
				# scan the neighbors of one of this a's neighbor
				while ($tempNode = shift @elementConnections) {
=begin 
					if this element's neighbor not visited, 
					push into the queue and prepare for visiting
=cut 
					if($tempNode ~~ @visitedNodes) {}
					else {
						push @neighbors, $tempNode;
					}
				}
			}
			$queueSize = @neighbors;
		}
		# total times when a and b are connected
		$sum += $connected;
	}
	# after 100 simulations, calculate the connection probability
	$probability = $sum / 100;
	print "p: $p, probability of a-b connectivity: $probability\n";
	print DATA "$p\t$probability\n";
}

close(DATA) || die "Couldn't close file properly";

print "\nFinish simulation, please check the output.txt file\n";
