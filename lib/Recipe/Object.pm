  package Recipe::Object
; use strict; use warnings; use utf8

; use Carp
; use Params::Smart () 
; use Sub::Install 'install_sub'

; use Data::Dumper
; sub debug { print STDERR @_ }

#######################################################################
# We can not use memoized Params from Params::Smart, so we
# copied the function here and prepare them for our own usage.
; my %ParamMemoization

; sub Params 
    { my $key = shift()
    ; $ParamMemoization{$key} ||= Params::Smart->new(@_)
    }
#######################################################################

# create somthing in the derived class
; sub init
    { print "Init: ".Dumper([@_])
    ; my $class  =shift() ### the class which handles creation: $class 
    ; my $factory=shift() ### factory providing the class: $factory
    ; my $type   =shift() ### user chosen type: $type
    ; my $recipe =shift() ### the Recipe package: $recipe
    ; my $method =shift() ### the method to create: $method
    ; my @params =@_

    ; local $Carp::CarpLevel=3
    ; if( @params==0 )
        { carp "nothing happens without a argument. Maybe in a future version\n"
              ,"is this the way to uninstall a method."
        ; return
        }
    
    ; # ok die Daten sollten in einer geigneten Struktur gespeichert werden
      # dafür sollte $class verantwortlich sein 
      # fr den Anfang sollte es gengen wenn ich mit Class::Struct und
      # Params::Smart beginne.

    ; my $subpkg = "${class}::${type}"
    ; my $self={name => 'self',position => 0, required => 1}
    ; my @template=($self,@params)    
    ; my $sub = sub
        { return bless([@_,@params],$subpkg) if @_==1
        ; my %args = Params($subpkg,@template)->args(@_)
        ; print Dumper(\%args)
        ; $args{self}
        }
    ; debug "Install $method in class $class with signatur:",Dumper('self',@params)
    ; install_sub({ code => $sub, into => $class, as => $method });
    }

; sub new
    { bless {}, shift() }

; 1

__END__
