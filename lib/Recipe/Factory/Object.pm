  package Recipe::Factory::Object
; use strict; use warnings; use utf8

; our $VERSION=0.001
    
; sub init
    { my $factory_class=shift()
    ; $factory_class->classloader
    ; $factory_class->realclass->init(@_)
    }

; 1

__END__ 
