#!/usr/bin/env perl

my @vals = ();

for (<>) {
    chomp;
    push(@vals, split(/\s+/, $_));
}

my $header = shift(@vals);
if ($header != 'P3') {
    die("Error unknow header: $header\n");
}

my $width = shift(@vals);
my $height = shift(@vals);
my $max_val = shift(@vals);

#print $width, $height, $max_val, "\n";
print("Len: ", scalar(@vals), "\n\n");
my @rows = ();
for (my $i=0; $i<$height; $i++) {
    for (my $b=0; $b<$width/8; $b++) {
        my $byte = '';
        my $j0 = $b*8;
        for (my $j=$j0; $j<$j0 + 8; $j++) {
            my $val = shift(@vals);
            if ($val == '0') {
                $byte = $byte . '0';
            }
            else {
                $byte = $byte . '1';
            }

            shift(@vals);
            shift(@vals);
        }
        push(@rows, sprintf("%02X", oct('0b' . $byte)));
    }
}
print join("", @rows), "\n";
