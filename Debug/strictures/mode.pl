use strict;
use warnings;

use strictures 1;

__END__

=head1 DESCRIPTION

Эта прагма эквивалентна такому коду:

use strict;
use warnings FATAL => 'all';
 
Т.е. теперь любые предупреждения будут трактоваться как ошибки. Кроме того, в случае, если strictures выявит, что запуск происходит в условиях разработки (запуск скрипта из каталогов t, xt, lib, blib и наличие в текущем каталоге .git или .svn), это расширяется в конструкцию:

use strict;
use warnings FATAL => 'all';
no indirect 'fatal';
no multidimensional;       
no bareword::filehandles;

=cut
