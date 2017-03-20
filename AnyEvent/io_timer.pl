use strict;
use warnings;
use AnyEvent;

# переменные состояния
my $done = AnyEvent->condvar;

my ( $w, $t );

# страж ввода/вывода
$w = AnyEvent->io (
    fh => \*STDIN,
    poll => 'r',
    cb => sub {
        chomp (my $input = <STDIN>);
        warn "read: $input\n";
        undef $w;
        undef $t;
        $done->send();
    }
);

# страж времени (таймер)
$t = AnyEvent->timer (
    after => 4.2,
    cb => sub {
        if (defined $w) {
            warn "no input for a 4.2 sec\n";
            undef $w;
            undef $t;
        }
        $done->send();
    }
);

# Приводит к блокирующему ожиданию, пока в одном из колбэков не будет сделан вызов $done->send()
$done->recv();

__END__

=head1 DESCRIPTION

Программа ожидает ввода пользователя с STDIN, и если ввода нет в течении 4.2 секунд — прерывает свою работу. Если ввод есть — выводит введённую строку.

=cut
