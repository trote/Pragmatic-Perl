use strict;
use warnings;

my $app = sub {
    my $env = shift;

# Производим необходимые манипуляции с $env
    return [200, ['Content-Type' => 'text/plain'], ["hello, world\n"]];
};

__END__

starman --port 5000 app.psgi
