package BestLogEver;
use Moo;
use Module::Runtime qw(require_module);

has 'storage' => (
   is => 'ro', # read only
   isa => sub { die 'bad storage name' unless $_[0] && ! ref $_[0] } # функцию проверки значения атрибута
);

has 'storage_object' => (
    is => 'lazy' # Атрибут будет создан при первом обращении, для создания атрибута будет использована функция с префиксом _build_
);

sub _build_storage_object {
    my $self = shift;
    
    my $class = 'BestLogEver::Storage::' . $self->storage;
    require_module($class);
    return $class->new;
}

sub log {
    my ( $self, $message ) = @_;
    
    $self->storage_object->log($message);
}

1;

package BestLogEver::Role::Storage;
use strict;
use warnings;
use Moo::Role;

requires 'log'; # Требует, чтобы класс, реализующий данную роль обязательно имел указанный метод log.

# Задаёт функцию, которая вызывается перед запуском log
before log => sub {
    chomp $_[1];
    $_[1] .= "\n";
};

1;

package BestLogEver::Storage::Screen;
use Moo;
with 'BestLogEver::Role::Storage'; # Подключаем роль

sub log {
    my ( $self, $message ) = @_;
    print $message;
}

1;

package main;

use strict;
use warnings;
use BestLogEver;
use v5.10;

my $log = BestLogEver->new( storage => 'Screen' );
say $log->storage;
$log->log("hello, world!");
