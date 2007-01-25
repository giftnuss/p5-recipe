  package Recipe::Condiment::Type
; use strict; use warnings; use utf8

; use Class::Struct

; sub valid { shift()->{'valid'}->(@_) }

; struct   
   ( name   => '$'
   , valid  => '$'
   , base   => '$'
   )

#######################################################################
; sub type ($&)
    { my ($name,$valid,$base)=@_
    ; __PACKAGE__->new
        ( name  => $name
        , valid => $valid
        , base  => $base || 'SCALAR'
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

