  package Recipe::Condiment
# *************************
; our $VERSION='0.001'
; our $AUTOLOAD
# ********************
; use strict; use warnings; use utf8

########################
# External Modules
########################
; use Error
; use Package::Subroutine
; use Recipe::Condiment::Type

########################
# Define Exceptions
########################
# Class to build Exception classes
# use Recipe::Error qw/BadName NameExists/ or something similar
; package Recipe::Condiment::Error::BadName
; use base 'Error'

; package Recipe::Condiment::Error::NameExists
; use base 'Error'

########################
# Internal Types
########################
; package Recipe::Condiment::Name

; sub valid 
  { my $val=$_[1]; !ref($val) && length($val)<60 }

########################
# Back to Main Class
########################
; package Recipe::Condiment

# ok, global variables are a common concept - so a recipe should contain one
; our $DEFAULT_FOR_VAR='required'

; sub import
    { export Package::Subroutine _ => qw/required optional var/ }

########################
# Constructor
########################
{# is private/protected
 ; sub _new 
   { my $self=shift
   ; (bless {},$self)->_name(@_) 
   }

 # first condiment is called var, Who knows like it smells?
 ; sub var
   { my $self=shift()
   ; return $self->_name(@_) if ref $self
   ; unshift @_,$self if defined $self
   ; __PACKAGE__->_new(@_)->$DEFAULT_FOR_VAR 
   }

 ; sub _name
   { my $self=shift()
   ; my $pos=keys %$self
   ; foreach (@_)
      {    
      ; throw Recipe::Condiment::Error::BadName 
          (-object => $self, -value => $_)
          unless valid Recipe::Condiment::Name $_

      ; throw Recipe::Condiment::Error::NameExists
          (-object => $self, -value => $_)
          if exists $$self{$_}

      ; $self->{$_}->{position} = ++$pos
      ; $self->{$_}->{name}     = $_
      }
   ; wantarray ? sort { $a->{'position'} <=> $b->{'position'} } values(%$self) : $self
   }

 # second condiment is called required - crazy little thing.
 ; sub _set_required
   { my $val =shift()
   ; my $self=shift()

   ; unless(ref $self)
       { unshift @_,$self if defined $self
       ; $self=__PACKAGE__->_new()
       }
   ; $_->{'required'}=$val foreach $self->_name(@_)
   ; $self->_name()
   }

 ; sub required { _set_required(1,@_) }
 ; sub optional { _set_required(0,@_) }
}

; sub DESTROY {}
#############################
# Type-Objects and more
#############################
; sub AUTOLOAD
    { $AUTOLOAD =~ s/^.*:://
    ; my $self=shift()
    ; my $action = Recipe::Condiment::Type->can($AUTOLOAD)
    ; if( $action )
        { 
          $_->{'type'}=&$action(@_) foreach $self->_name()
        }
    ; $self->_name()
    }

; 1

__END__

 { name 

########################
# Public Builder
########################

; sub required
    { (%$self = (%$self,@_)) && (return $self) if $self=shift()
    ; __PACKAGE__->new(required => 1,@_) 
    }

; sub optional
    { (%$self = (%$self,@_)) && (return $self) if $self=shift()
    ; __PACKAGE__->new(required => 0,@_)
    }  

########################
# Typen
########################
sub AUTOLOAD
    { @_ }

; 1

__END__


