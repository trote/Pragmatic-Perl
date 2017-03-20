package Logger;

use strict;
use warnings;
use v5.10;

use Term::ANSIColor ':constants';

use utf8;

sub Debug { say STDERR         shift        }
sub Info  { say STDERR GREEN,  shift, RESET }
sub Warn  { say STDERR YELLOW, shift, RESET }
sub Error { say STDERR RED,    shift, RESET }

1;

package Adapter; # Свой адаптер к Logger

use strict;
use warnings;

use Log::Any::Adapter::Util 'make_method';

use parent 'Log::Any::Adapter::Base';

my %pairs = (
    Debug => [qw/ debug /],
    Info  => [qw/ info inform /],
    Warn  => [qw/ notice warn warning /],
    Error => [qw/ err error fatal crit critical alert emergency /],
);

while (my ( $function, $methods ) = each %pairs) {
    my $code = <<"EOC";
sub {
    my ( \$self, \@msgs ) = \@_;

    Logger::$function join('', \@msgs);
}
EOC

    my $sub = eval $code;

    for my $method ( @$methods ) {
        make_method $method, $sub;
    }
}

for my $method ( Log::Any->detection_methods ) {
    make_method $method, sub { 1 }; # Делаем вид, что логируется любой уровень важности
}

1;

package CoffeeMaker;

use strict;
use warnings;
use utf8;

use Log::Any '$log';

sub make {
    my ( $self, $temperature ) = @_;

    $log->debug( "лоток загружен, вода есть" );
    $log->info( "варю кофе, температура $temperature" );
    $log->warn( "осторожно, горячо!" ) if $temperature > 70;
    $log->error( "непредвиденная проблема" );
    $log->info( "готово" );

    return;
}

1;

package main;
use strict;
use warnings;

use Log::Any::Adapter;
Log::Any::Adapter->set('+Adapter');

CoffeeMaker->make(80);
