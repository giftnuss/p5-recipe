  package Recipe::Condiment::Type
# *******************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8
; use Class::Struct

; sub valid { shift()->{'_valid'}->(@_) }

; struct   
   ( _name   => '$'
   , _valid  => '$'
   , _base   => '$'
   )

#######################################################################
; sub type ($&@)
    { my ($name,$valid,$base)=@_
    ; __PACKAGE__->new
        ( _name  => $name
        , _valid => $valid
        , _base  => $base || 'SCALAR'
        )
    }

; sub string
    { my @args=@_
    ; type('STRING',sub { $_[0]=~/^.*$/ })
    }

; sub email
    { type('EMAIL',sub { $_[0]=~/^\w[\w\.]+\@\w[\w\.]*\w$/ }) }
    
; 1

__END__

