# test constructor of Recipe::Condiment

; use strict; use utf8

; use Test::More tests => 12

; use_ok('Recipe::Condiment')

# test private constructor
; ok(0+@{[Recipe::Condiment->_new()]}==0,
    ,"empty object is empty list in list context")

; ok(eq_hash(scalar Recipe::Condiment->_new(), {})
    ,"empty object is empty hashref in scalar context")

# count result list
; my $name="test%d"
; for my $t ( 1..3 )
  { my @args; push @args,sprintf($name,$_) for 1..$t
  ; ok(0+@{[Recipe::Condiment->_new(@args)]}==$t,
    ,"list with $t elements in list context")
  ; ok(eq_hash(scalar Recipe::Condiment->_new(@args),
    { 1 => { sprintf($name,1) => 
               { position => 0, name => sprintf($name,1) }}
    , 2 => { sprintf($name,1) =>
               { position => 0, name => sprintf($name,1) }
           , sprintf($name,2) =>
               { position => 1, name => sprintf($name,2) }}
    , 3 => { sprintf($name,1) =>
               { position => 0, name => sprintf($name,1) }
           , sprintf($name,2) =>
               { position => 1, name => sprintf($name,2) } 
           , sprintf($name,3) => 
               { position => 2, name => sprintf($name,3) }}
    }->{$t}),"correct hashref for $t args in scalar context")

  ; ok(eq_array([Recipe::Condiment->_new(@args)],
    { 1 => [ { position => 0, name => sprintf($name,1) } ]
    , 2 => [ { position => 0, name => sprintf($name,1) }
           , { position => 1, name => sprintf($name,2) } ]
    , 3 => [ { position => 0, name => sprintf($name,1) }
           , { position => 1, name => sprintf($name,2) }
           , { position => 2, name => sprintf($name,3) } ]
    }->{$t}),"correct list of hasrefs for $t in list context")
  }

; use Data::Dumper
; for my $t ( 1..3 )
  { my @args; push @args,sprintf($name,$_) for 1..$t
 # ; print Dumper([Recipe::Condiment->_new(@args)])
  }
