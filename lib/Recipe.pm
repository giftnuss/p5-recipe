  package Recipe
; use Sub::Uplevel # for my basis
; use strict; use warnings; use utf8

; use Recipe::Factory

; our ($AUTOLOAD)

; sub AUTOLOAD
    { $AUTOLOAD =~ s/^.*:://
    ; my $recipe=Recipe::Factory->new($AUTOLOAD => @_)
    }

; 1

__END__

=head1 NAME

Recipe - create, write and cook it

=head1 SYNOPSIS

- :)

=head1 DESCRIPTION

=head2 Reserved Keys


The methods use Params::Smart to validate the params. This
keys are for internal use.

=over 3

=item self

We build methods so it stands for the created object. It is common that
this is the return value of the method too.

=back 3
