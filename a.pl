#! /usr/bin/perl
# Question: 4a
use Data::Dumper;
#Initializing parameters
$n = 100; $m = 10; 
$a = 5; $b = 8; # 2 random vertices

# run the simulation for all possible p values
# p is connected probability
for($p = 0; $p < 1.01; $p = $p + 0.01) {
	$sum = 0;
	# simulate 100 times
	for (my $iteration = 0; $iteration < 100; $iteration++) {
		%nodeGraph = ();# adjacency list
		%nodeConnGraph = ();# connected adjacency list
		my $connected = 0;
		
		# build adjacency list
		for (my $i = 0; $i < $n; $i = $i + 1) {
			my $currentNode = $i;
			my @nodeNeighbors = ();
			# choose m neighbors
			my $counter = $m;
			while ($counter > 0) {
				my $nearby = int(rand($n));
				# keep generating different random vertex
				while (($nearby == $currentNode) || 
				($nearby ~~ @nodeNeighbors)) {
					$nearby = int(rand($n));
				}
				push @nodeNeighbors, $nearby;
				$counter = $counter - 1;
			}
			# key is vertex index, value is its neighbors
			$nodeGraph{$i} = \@nodeNeighbors;
		}

		# build connected adjacency list
		if ($p eq 0) {
			# no connected, build an empty list for each vertex
			my @connectedNeighbors = ();
			for (my $temp = 0; $temp < $n; $temp++) {
				$nodeConnGraph{$i} = \@connectedNeighbors;
			}
		} elsif ($p eq 1) {
			# all connected, use adjacency list
			%nodeConnGraph = %nodeGraph;
		} else {
			for (my $temp = 0; $temp < $n; $temp++) {
				my $key = $temp;
				my @value = @{$nodeGraph{$key}};
				my @connectedNeighbors = ();
				while($nearby = shift @value) {
					my $randomNumber = rand();
					# regard its neighbor connected with a probability
					if($randomNumber < $p) {
						push @connectedNeighbors, $nearby;
					}
				}
				$nodeConnGraph{$key} = \@connectedNeighbors;
			}
		}

		# check the connectivity of a random vertex a
		@nodeQueue = @{$nodeConnGraph{$a}};
		$queueSize = @nodeQueue;
		@visitedNodes = ();
		while($queueSize > 0) {
			# dump one of a's neighbor as element
			my $element = shift @nodeQueue;
			# mark it as visited
			push @visitedNodes, $element;
			if ($element eq $b) {
				# if b is a's neighbor, count it and break
				$connected = 1;
				last;
			} else {
				my @elementConnections = @{$nodeConnGraph{$element}};
				# scan the neighbors of one of this a's neighbor
				while ($tempNode = shift @elementConnections) {
=begin 
					if this element's neighbor not visited, 
					push into the queue and prepare for visiting
=cut 
					if($tempNode ~~ @visitedNodes) {}
					else {
						push @nodeQueue, $tempNode;
					}
				}
			}
			$queueSize = @nodeQueue;
		}
		# total times when a and b are connected
		$sum = $sum + $connected;
	}
	# after 100 simulations, calculate the connection probability
	$probability = $sum / 100;
	print "$p, $probability\n";
}
