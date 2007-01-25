  package Recipe::Factory
; use strict

; use base 'Class::Factory'

; our (@TYPES)
; sub addtype # called in the BEGIN initilization

; BEGIN 
    { sub rf () { 'Recipe::Factory::' }
    ; sub addtype { push our @TYPES , @_ }
    ; addtype
        #[ application   => rf.'Application'    , "Universal application type" ],
        [ person        => rf.'Person',          "Society member" ]
    }

; INIT
    { Recipe::Factory->register_factory_type( @{$_}[0,1] ) for @TYPES 
    }

; sub new 
    { my $factory=shift() ### Factory Class: $factory
    ; my $type   =shift() ### the key for Class::Factory: $type
    ; my $recipe =shift() ### the Recipe class: $recipe
    ; my @params =@_
    ; my $class  =$factory->get_factory_class($type)
    ; $class->classloader

    # throwing an exception is done by CF, so better catch it here
    ; die unless ($class)

    ; if ( @params )    # we create something
        { return $class->init($factory,$type,$recipe,@params) }

    ; $class->realclass->new() # we cook something
    }

; 1

__END__
