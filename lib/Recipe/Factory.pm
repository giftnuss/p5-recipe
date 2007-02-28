  package Recipe::Factory
# ***********************
; our $VERSION='0.01'
# *******************
; use strict; use utf8
; use base 'Class::Factory'

; use Recipe::Factory::Object
; use Package::Subroutine('pkgname')

; sub import
    { my ($pkg,@types)=@_
    ; foreach (@types)
        { my ($class,$factory)=$pkg->create_factory_class($_)
        # Class::Factory - ich verstehe wirklich nicht wieso
        # alles wunderbar funktioniert.
        ; Recipe::Factory->register_factory_type( lc($class),$factory )
        }
    }

; sub create_factory_class
    { my ($pkg,$fqcn)=@_
    ; my @pkg=split /::|'/, $fqcn # '
    ; my $class   = $pkg[-1]
    ; my $factory = "Recipe::Factory::Object::${class}"
    ; my $file    = __FILE__
    
    ; eval  "  package $factory; our \@ISA=('Recipe::Factory::Object')"
           ."; sub classloader { require $fqcn }"
           ."; sub realclass   { '$fqcn' }"
    ; $INC{pkgname($factory)}=$file
    ; ($class,$factory)
    }

; sub new 
    { my $factory=shift() ### Factory Class: $factory
    ; my $type   =shift() ### the key for Class::Factory: $type
    ; my $recipe =shift() ### the Recipe class: $recipe
    ; my @params =@_
    ; my $class  =$factory->get_factory_class($type)
    ; $class->classloader

    # throwing an exception is done by CF, so better catch it here
    ; die unless ($class)

    ; if ( @params )    # we create something
        { return $class->init($factory,$type,$recipe,@params) }

    ; $class->realclass->new() # we cook something
    }

; 1

__END__

