  package Recipe::Std::Person
; use strict; use warnings; use utf8
; use base 'Recipe::Object'

; our $VERSION=0.001

; use Recipe::Condiment

; person Recipe 'idealistic_man'

; person Recipe abstract => undef

; person Recipe simple 
    => required('firstname','surname')->string()
    => optional('email')->email()

; 1

__END__

# Das kann nicht direkt in der Factory::Person stehen
# weil das verwendete eval zum Laden nicht sehr Carpfreundlich ist.
# Man bekommt nicht Fehler in Zeile sowieso, sondern in eval line 5
# irgendwas.
