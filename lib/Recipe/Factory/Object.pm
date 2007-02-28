  package Recipe::Factory::Object
# *******************************
; our $VERSION='0.001'
# ********************
; use strict; use utf8
    
; sub init
    { my $factory_class=shift()
    ; $factory_class->realclass->init(@_)
    }

; 1

__END__ 
