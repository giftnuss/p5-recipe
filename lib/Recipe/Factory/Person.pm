
; BEGIN { die 'NUR ZUR DOKUMENTATION',caller }
  package Recipe::Factory::Person
; use strict; use warnings; use utf8

; use base 'Recipe::Factory::Object'

; sub classloader { require Recipe::Std::Person }
; sub realclass { "Recipe::Std::Person" }

; 1

__END__

Da nun ein Anfang gemacht ist, wird die erste Implementierung des Typdefinierers
über importierte Funktionen ohne Paket erfolgen.

Heiße Kandidaten sind wie man sieht 
qw/var required optional/

Der Name ist natürlich Condiment - :) 

Why not ingredents 

condiment - aroma gewürz zutat
ingredents - zutaten inhaltsstoffe bestandteil

Das sagt alles.

callbacks are determined by type


Entscheidung was default ist - optional oder required

    name
           The name of the parameter. May include aliases, separated by vertical bars.

       required
           The parameter is required if true.

       default
           A default value of the parameter.

       slurp
           This parameter slurps the remaining arguments if true. The parameter will be an array
           reference.

       name_only
           This parameter may be specified using named-calls only if true.

       needs
           This parameter needs these other parameters to be specified (either as a list refer-
           ence, or a string for a single required parameter).
       type
           Not yet implemented. Use the callback to validate the value.

       callback
           An optional callback which validates and coerces the parameter.  The callback is passed
           the parameter-parsing object, the name of the parameter, and the value:

             callback => sub {
               my ($self, $name, $value) = @_;
               ...
               return $value;
             },

           The $name is the primary name for the parameter, and not any aliases which might have
           been used.

           It is expected to return the coerced value, or die if there is a problem:

             callback => sub {
               my ($self, $name, $value, $hashref) = @_;
               die "$name must be >= 0"
                 if ($value < 0);
               return $value || 1;
             },

           Callbacks can also update the acceptable parameters:

             callback => sub {
               my ($self, $name, $value, $hashref) = @_;
               if ($value eq "zip") {
                 $self->set_param( {
                   name    => "compression_level",
                   default => 6,
                 } );
               }

