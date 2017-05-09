#! /usr/bin/perl
# Percolation question 2
use Math::Trig;
use Math::Complex;
# Inputs Initialization
$r = 1; $n = 10;
$simTimes = 100; # number of simulation

# run the simulation for all possible q values
# q is valid distance

open(DATA, ">output2.txt") or die "Couldn't open file file.txt, $!";

for (my $q = 0; $q <= $r; $q += 0.01) {
	$sum = 0;
	# simulate 100 times
	for (my $iteration = 0; $iteration < $simTimes; $iteration++) {
		# build coordinate list
		@userX = ();
		@userY = ();
		for (my $i = 0; $i < $n; $i++) {
			$theta = 2 * pi * rand($r); # degree of current user
			# generate a random coordinate x-y pair
			my $tempR = 0;
			$u = rand($r) + rand($r);
			if ($u > $r) {
				$tempR = 2 - $u;
			} else {
				$tempR = $u;
			}
			$tempVarX = $tempR * cos($theta);
			$tempVarY = $tempR * sin($theta);
			push(@userX, $tempVarX);
			push(@userY, $tempVarY);
		}

		my @connX = (); # connected list of X coordinate
		my @connY = (); # connected list of Y coordinate
		my $conn = 0; # counter of connected users
		my @locations = (); # connected list

		# check the valid users
		for (my $i = 0; $i < $n; $i++) {
			$tempVarX = $userX[$i];
			$tempVarY = $userY[$i];
			# compute the distance from the origin
			$dist = sqrt(($tempVarX * $tempVarX) + ($tempVarY * $tempVarY));
			if($dist <= $q) {
				push(@connX, $tempVarX);
				push(@connY, $tempVarY);
				$conn++;
				push(@locations, $i);
			}
		}

		# check the connectivity of the entire graph
		my $sizeConn = @connX;
		while ($sizeConn > 0) {
			$tempVarX = $connX[0];
			$tempVarY = $connY[0];
			for (my $i = 0; $i < $n; $i++) {
				if($i ~~ @locations) {} 
				else {
					$tempVar2X = $userX[$i];
					$tempVar2Y = $userY[$i];
					$xDist = $tempVarX - $tempVar2X;
					$yDist = $tempVarY - $tempVar2Y;
					$dist = sqrt(($xDist * $xDist) + ($yDist * $yDist));
					if($dist <= $q) {
						push(@connX, $tempVar2X);
						push(@connY, $tempVar2Y);
						$conn++;
						push(@locations, $i);
					}
				}
			}
			shift(@connX);
			shift(@connY);
			$sizeConn = @connX;
		}
		# total times when a and b are connected
		$sum = $sum + $conn;
	}
	# after 100 simulations, calculate the connection probability
	$probability = $sum / (100 * $n);
	print "q: $q, probability of communication: $probability\n";
	print DATA "$q\t$probability\n";
}

close(DATA) || die "Couldn't close file properly";

print "\nFinish simulation, please check the output.txt file\n";
