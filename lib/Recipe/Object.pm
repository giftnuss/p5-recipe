  package Recipe::Object
# **********************
; our $VERSION='0.001'
# ********************
; use strict; use warnings; use utf8

; use Carp
; require Params::Smart '0.04' 
; use Sub::Install 'install_sub'

; use Data::Dumper
; sub debug { print STDERR @_ 
            }

#######################################################################
# We can not use memoized Params from Params::Smart, so we
# copied the function here and prepare them for our own usage.
; my %ParamMemoization

; sub Params 
    { my $key = shift()
    ; $ParamMemoization{$key} ||= Params::Smart->new(@_)
    }
#######################################################################

; use base 'Class::Accessor::Fast'
; __PACKAGE__->mk_accessors 
   ( 'validator'  # a coderef produced by Params::Smart
   , 'condiment'  # the given condiments as array ref
   , 'pkg_sub'    # which method we build
   )

# create somthing in the derived class
; sub init
    { #print "Init: ".Dumper([@_])
    ; my $class  =shift() ### the class which handles creation: $class 
    ; my $factory=shift() ### factory providing the class: $factory
    ; my $type   =shift() ### user chosen type: $type
    ; my $recipe =shift() ### the Recipe package: $recipe
    ; my $method =shift() ### the method to create: $method
    ; my @params =@_

    ; local $Carp::CarpLevel=3
    #; if( @params==0 )
    #    { carp "nothing happens without a argument. Maybe in a future version\n"
    #          ,"is this the way to uninstall a method."
    #    ; return
    #    }
    
    ; # ok die Daten sollten in einer geigneten Struktur gespeichert werden
      # dafür sollte $class verantwortlich sein 
      # fr den Anfang sollte es gengen wenn ich mit Class::Struct und
      # Params::Smart beginne.

    ; my $subpkg = "${type}::${method}"
    ; my $self={name => 'self',position => 0, required => 1}
    ; my @template=($self,map { ref $params[$_] 
                           ? $params[$_] 
                           : { name => $params[$_], position => $_+1 }
                           } 0..$#params )    
    ; my $sub = sub
        { # produces a validated %args hash 
        ; Params($subpkg,@template)->args(@_)
        }

    # create a fresh Recipe::Object
    ; $class->new 
        ({ condiments => [@params]
         , validator  => $sub
         , pkg_sub    => $subpkg
         })
    }
# Installation is sceduled for later.
#    ; debug "Install $method in class $class with signatur:",Dumper('self',@params)
#    ; install_sub({ code => $sub, into => $class, as => $method });


; 1

__END__
