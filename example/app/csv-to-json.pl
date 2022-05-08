use v5.25;
use warnings;

use Text::CSV_XS qw(csv);
use JSON;

my $f = 'work.csv';
{
	local $/ = undef;
	open my $fd, '>', $f;
	print $fd (<STDIN>);
	close $fd;
}

my $csv_aoa = csv(in => $f);
my $headers = shift @$csv_aoa;

my @table = ();

for my $row (@$csv_aoa) {
    my %row = ();
    @row{@$headers} = @$row;
    push @table, \%row;
}

my $json = JSON->new->pretty;
say $json->encode(\@table);
