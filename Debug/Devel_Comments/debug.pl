use strict;
use warnings;

use Devel::Comments *STDOUT;

my $var = 10;
### assert: $var == 10
### check: $var < 10
### $var
### Doubled $var: $var*2
### Do some work
### <now> Do some work at <here>

__END__

=head1 DESCRIPTION

Позволяет вставлять команды отладки через комментарии и выводить сообщения не на экран, а в файл.

=cut
