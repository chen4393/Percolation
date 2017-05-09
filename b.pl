#! /usr/bin/perl
#Question: 4b
use Math::Trig;
use Math::Complex;
#Initializing Parameters
$towerRadius = 1; $UserNumber = 90; $towerX = 0; $towerY = 0;
for (my $q=0;$q<($towerRadius+0.01);$q=$q+0.01) {
$sum = 0;
for (my $iteration=0;$iteration<100;$iteration++) {
@userX = ();
@userY = ();
for (my $i=0;$i<$UserNumber;$i=$i+1) {
$t = 2*pi*rand($towerRadius);
$u = rand($towerRadius) + rand($towerRadius);
if ($u>1) {
$r = 2 - $u;
} else {
$r = $u;
}
$tempVarX = $r*cos($t);
$tempVarY = $r*sin($t);
push(@userX, $tempVarX);
push(@userY, $tempVarY);
}
my @touchX = ();
my @touchY = ();
my $touch = 0;
my @locations = ();
for (my $i=0;$i<$UserNumber;$i=$i+1) {
$tempVarX = $userX[$i];
$tempVarY = $userY[$i];
$dist =
sqrt(($tempVarX*$tempVarX)+($tempVarY*$tempVarY));
if($dist <= $q) {
push(@touchX, $tempVarX);
push(@touchY, $tempVarY);
$touch = $touch+1;
push(@locations, $i);
}
}
my $sizeConn = @touchX;
while ($sizeConn > 0) {
$tempVarX = $touchX[0];
$tempVarY = $touchY[0];
for (my $i=0;$i<$UserNumber;$i=$i+1) {
if($i ~~ @locations) {
} else {
$tempVar2X = $userX[$i];
$tempVar2Y = $userY[$i];
$xDist = $tempVarX - $tempVar2X;$yDist = $tempVarY - $tempVar2Y;
$dist =
sqrt(($xDist*$xDist)+($yDist*$yDist));
if($dist <= $q) {
push(@touchX, $tempVar2X);
push(@touchY, $tempVar2Y);
$touch = $touch+1;
push(@locations, $i);
}
}
}
shift(@touchX);
shift(@touchY);
$sizeConn = @touchX;
}
$sum = $sum + $touch;
}
$probability = ($sum)/(100*$UserNumber);
print "$q,$probability\n";
}
