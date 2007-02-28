  package Recipe::Std::NDoc
# *************************
; our $VERSION='0.001'
# ********************
; use strict; use utf8
; use base 'Recipe::Object'

 ; ndoc Recipe basic
      => summary        
      => param          
      => returns =>;      

; 1

__END__

# Das kann nicht direkt in der Factory::Person stehen
# weil das verwendete eval zum Laden nicht sehr Carpfreundlich ist.
# Man bekommt nicht Fehler in Zeile sowieso, sondern in eval line 5
# irgendwas.
