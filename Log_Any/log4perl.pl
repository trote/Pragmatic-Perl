use strict;
use warnings;

use Log::Any qw/$log/;
use Log::Any::Adapter;
use Log::Log4perl;

my $loginit = q{
log4perl.rootLogger = DEBUG, Screen
log4perl.appender.Screen = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.layout = Log::Log4perl::Layout::PatternLayout
log4perl.appender.Screen.stderr = 1
log4perl.appender.Screen.layout.ConversionPattern = %d %m %n
};

Log::Log4perl->init(\$loginit);
Log::Any::Adapter->set( 'Log4perl' );

$log->debug("что-то произошло");
