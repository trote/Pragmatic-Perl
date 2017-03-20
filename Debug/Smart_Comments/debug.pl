use strict;
use warnings;

use Smart::Comments;

my $var = 10;
### assert: $var == 10
### check: $var < 10
### $var
### Doubled $var: $var*2
### Do some work
### <now> Do some work at <here>

__END__

=head1 DESCRIPTION

Позволяет вставлять команды отладки через комментарии

perl -MSmart::Comments debug.pl

=cut
