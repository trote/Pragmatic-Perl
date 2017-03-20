use warnings;
use strict;
use v5.10;

use XML::Simple;

my $xs = XML::Simple->new();

my $hashref = {
    cats => {
        cat => [
            {
                name  => 'Daisy',
                value => 4
            },
            {
                name  => 'Abby',
                value => 5
            },
        ]
    }
};
say $xs->XMLout($hashref);
# <opt>
#   <cats>
#     <cat name="Daisy" value="4" ></cat>
#     <cat name="Abby" value="5" ></cat>
#   </cats>
# </opt>

$hashref = {
    cat => [
        {
            name  => 'Daisy',
            content => 4
        },
        {
            name  => 'Abby',
            content => 5
        },
    ]
};
say $xs->XMLout(
    $hashref,
    XMLDecl  => '<?xml version="1.0" encoding="UTF8"?>',
    RootName => 'cats'
);
# <?xml version="1.0" encoding="UTF8"?>
# <cats>
#   <cat name="Daisy">4</cat>
#   <cat name="Abby">5</cat>
# </cats>

$hashref = {
    cat => [
        {
            name => 'Daisy',
            weight => {
                content => 4,
            },
            age => {
                content => 3.5,
            },
        },
        {
            name => 'Abby',
            weight => {
                content => 5,
            },
            age => {
                content => 6,
            },
        },
    ]
};
say $xs->XMLout(
    $hashref,
    XMLDecl  => '<?xml version="1.0" encoding="UTF8"?>',
    RootName => 'cats'
);
# <?xml version="1.0" encoding="UTF8"?>
# <cats>
#   <cat name="Daisy">
#     <age>3.5</age>
#     <weight>4</weight>
#   </cat>
#   <cat name="Abby">
#     <age>6</age>
#     <weight>5</weight>
#   </cat>
# </cats>

$hashref = {
    cat => [
        {
            name => 'Daisy',
            content => {
                weight => 4,
                age => 3.5,
            },
        },
        {
            name => 'Abby',
            weight => {
                content => 5,
            },
            age => {
                content => 6,
            },
        },
    ]
};
say $xs->XMLout(
    $hashref,
    XMLDecl  => '<?xml version="1.0" encoding="UTF8"?>',
    RootName => 'cats',
    ContentKey => ''
);
# <?xml version="1.0" encoding="UTF8"?>
# <cats>
#   <cat name="Daisy">
#     <content age="3.5" weight="4" />
#   </cat>
#   <cat name="Abby">
#     <age content="6" />
#     <weight content="5" />
#   </cat>
# </cats>

$hashref = {
    cat => [
        {
            name => 'Daisy',
            content => {
                weight => 4,
                age => 3.5,
            },
        },
    ]
};
say $xs->XMLout($hashref, NoAttr => 1);
# <opt>
#   <cat>
#     <name>Daisy</name>
#     <content>
#       <age>3.5</age>
#       <weight>4</weight>
#     </content>
#   </cat>
# </opt>

use Data::Dumper;

my $ref = $xs->XMLin(<<'XML');
<cats>
  <cat name="Daisy">
    <age>3.5</age>
    <weight>4</weight>
  </cat>
  <cat name="Abby">
    <age>6</age>
    <weight>5</weight>
  </cat>
</cats>
XML
print Dumper $ref;
# $VAR1 = {
#           'cat' => {
#                    'Daisy' => {
#                               'weight' => '4',
#                               'age' => '3.5'
#                             },
#                    'Abby' => {
#                              'age' => '6',
#                              'weight' => '5'
#                            }
#                  }
#         };

$ref = $xs->XMLin(<<'XML', KeyAttr => '', ForceArray=>['cat']);
<cats>
  <cat name="Daisy">
    <age>3.5</age>
    <weight>4</weight>
  </cat>
  <cat name="Abby">
    <age>6</age>
    <weight>5</weight>
  </cat>
</cats>
XML
print Dumper $ref;
# $VAR1 = {
#           'cat' => [
#                    {
#                      'age' => '3.5',
#                      'weight' => '4',
#                      'name' => 'Daisy'
#                    },
#                    {
#                      'name' => 'Abby',
#                      'weight' => '5',
#                      'age' => '6'
#                    }
#                  ]
#         };

$ref = $xs->XMLin(<<'XML', KeyAttr => '');
<cats>
  <cat name="Daisy">
    <age>3.5</age>
    <weight>4</weight>
  </cat>
</cats>
XML
print Dumper $ref;
# $VAR1 = {
#           'cat' => {
#                    'name' => 'Daisy',
#                    'age' => '3.5',
#                    'weight' => '4'
#                  }
#         };

$ref = $xs->XMLin(<<'XML', KeyAttr => '', ForceArray=>['cat']);
<cats>
  <cat name="Daisy">
    <age>3.5</age>
    <weight>4</weight>
  </cat>
</cats>
XML
print Dumper $ref;
# $VAR1 = {
#           'cat' => [
#                    {
#                      'name' => 'Daisy',
#                      'weight' => '4',
#                      'age' => '3.5'
#                    }
#                  ]
#         };
