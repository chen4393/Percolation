#! /usr/bin/perl
# Question: 4a
use Data::Dumper;
#Initializing parameters
$n=100; $m=10; $a = 5; $b = 8;

for($p = 0; $p < 1.01; $p = $p + 0.01) {
	$sum = 0;

	for(my $iteration=0; $iteration < 100; $iteration++) {
		%nodeGraph = ();
		%nodeConnGraph = ();
		my $connected = 0;
		
		for(my $i = 0; $i < $n; $i = $i + 1) {
			my $currentNode = $i;
			my @nodeNeighbors = ();
			my $counter = $m;
			while($counter > 0) {
				my $nearby = int(rand($n));
				# keep generating different random node
				while(($nearby == $currentNode) || ($nearby ~~ @nodeNeighbors)) {
					$nearby = int(rand($n));
				}
				push @nodeNeighbors, $nearby;
				$counter = $counter - 1;
			}
			$nodeGraph{$i} = \@nodeNeighbors;
		}

		if($p eq 0) {
			my @connectedNeighbors = ();
			for(my $temp = 0; $temp < 100; $temp++) {
				$nodeConnGraph{$i} = \@connectedNeighbors;
			}
		} elsif($p eq 1) {
			%nodeConnGraph = %nodeGraph;
		} else {
			for(my $temp=0; $temp<100; $temp++) {
				my $key = $temp;
				my @value = @{$nodeGraph{$key}};
				my @connectedNeighbors = ();
				while($nearby = shift @value) {
					my $randomNumber = rand();
					if($randomNumber < $p) {
						push @connectedNeighbors, $nearby;
					}
				}
				$nodeConnGraph{$key} = \@connectedNeighbors;
			}
		}

		@nodeQueue = @{$nodeConnGraph{$a}};
		$queueSize = @nodeQueue;@visitedNodes = ();
		while($queueSize > 0) {
			my $element = shift @nodeQueue;
			push @visitedNodes, $element;
			if($element eq $b) {
				$connected = 1;
				last;
			} else {
				my @elementConnections =
				@{$nodeConnGraph{$element}};
				while($tempNode = shift @elementConnections) {
					if($tempNode ~~ @visitedNodes) {}
					else {
						push @nodeQueue, $tempNode;
					}
				}
			}
			$queueSize = @nodeQueue;
		}

		$sum = $sum + $connected;
	}

	$probability = $sum/100;
	print "$p,$probability\n";
}
