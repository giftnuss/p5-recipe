  package Recipe
# **************
; our $VERSION='0.01'
# *******************
; use strict; use utf8

; use Recipe::Factory ()
; use Package::Subroutine ('pkgname')

; our ($AUTOLOAD)

; sub factory { 'Recipe::Factory' }

; sub AUTOLOAD
    { my ($self,@args)=@_
    ; $AUTOLOAD =~ s/^.*:://
    ; my $recipe=$self->factory->new($AUTOLOAD => @_)
    }
    
; sub import
    { my $self=shift()
    ; if ( @_ )
        { $self->factory->import(@_) }
    }

; 1

__END__

=head1 NAME

Recipe - create, write and cook it

=head1 SYNOPSIS

Writing a recipe:

    package Recipe::Std::NDoc 
  ; use base 'Recipe::Object'

  ; ndoc Recipe basic
      => summary        
      => param          
      => returns           
      =>;
      
=head1 DESCRIPTION

=head2 Reserved Keys


The methods use Params::Smart to validate the params. This
keys are for internal use.

=over 3

=item self

We build methods so it stands for the created object. It is common that
this is the return value of the method too.

=back 3
