use strict;
use warnings;

my ( $a, $b ) = (1, 0);
print $a / $b;

__END__

=head1 DESCRIPTION

В случае если в коде возникает ошибка или даже предупреждение, происходит остановка программы и переход в интерактивную оболочку Devel::REPL.

perl -MCarp::REPL=warn debug.pl

=cut
