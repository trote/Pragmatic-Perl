use strict;
use warnings;

use Plack;
use Plack::Request;
use Plack::Builder;

sub build_app {
    my $param = shift;

    return sub {
        my $env = shift;

        my $req = Plack::Request->new($env); # содержит в себе данные запроса клиента
        my $res = $req->new_response(200);   # ответ клиенту
        $res->header('Content-Type' => 'text/html', charset => 'Utf-8');

        my $params = $req->parameters();     # возвращает параметры в виде Hash::MultiValue
        my $body;
        if ( $params->{string} ) {
            if ($param eq 'reverse') {
                $body = scalar reverse $params->{string};
            } elsif ( $param eq 'palindrome' ) {
                $body =
                    palindrome( $params->{string} )
                    ? 'Palindrome'
                    : 'Not a palindrome';
            } else {
                $body = 'string exists';
            }
        } else {
            $body = 'empty string';
        }
        $res->body($body); # тело ответа

        $res->finalize(); # преобразование объекта ответа в ссылку на массив PSGI-ответа (состоит из статуса, заголовков и тела ответа)
    };
}

sub palindrome {
    my $string = shift;

    $string = lc $string;
    $string =~ s/\s//gs;

    ($string eq reverse $string) ? 1 : 0;
}

my $main_app = builder {
    mount "/reverse"    => builder { build_app('reverse') };
    mount "/palindrome" => builder { build_app('palindrome') };
    mount "/"           => builder { build_app() };
};

__END__

starman --port 5000 app.psgi
