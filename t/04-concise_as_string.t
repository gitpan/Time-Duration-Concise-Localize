use strict;
use warnings;

use Test::More tests => 17;
use Test::NoWarnings;

use Time::Duration::Concise::Localize;

use lib './t/';

my %display_tests = (
    '1d' => {
        1 => '1 day',
        2 => '1 day',
        3 => '1 day',
        4 => '1 day',
    },
    '1h3m' => {
        1 => '1 hour',
        2 => '1 hour 3 minutes',
        3 => '1 hour 3 minutes',
        4 => '1 hour 3 minutes',
    },
    '1d34m12s' => {
        1 => '1 day',
        2 => '1 day 34 minutes',
        3 => '1 day 34 minutes 12 seconds',
        4 => '1 day 34 minutes 12 seconds',
    },
    '4d12h16m8s' => {
        1 => '4 days',
        2 => '4 days 12 hours',
        3 => '4 days 12 hours 16 minutes',
        4 => '4 days 12 hours 16 minutes 8 seconds',
      }

);

foreach my $code (sort keys %display_tests) {
    my %elements = %{$display_tests{$code}};
    my $ti       = Time::Duration::Concise::Localize->new(
        interval => $code,
        'localize_class' => 'i18n',
        'localize_method' => sub {
             i18n->new( 'language' => 'en_us' )->translate_time_duration(@_);
         }
    );
    foreach my $length (sort keys %elements) {
        is($ti->as_string($length), $elements{$length}, 'Display ' . $code . ' of length ' . $length . ' is ' . $elements{$length});
    }

}

