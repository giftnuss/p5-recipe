  package Recipe::Std::Person
# ***************************
; our $VERSION='0.002'
# ********************
; use strict; use utf8
; use base 'Recipe::Object'

; use Recipe::Condiment

; person Recipe 'idealistic_man'

; person Recipe abstract => undef

; person Recipe simple 
    => required('firstname','surname')->string()
    => optional('email')->email()

; 1

__END__

