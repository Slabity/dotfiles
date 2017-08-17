# Arguments to be used in this function.
#
# stdenv is an argument in nearly all Nix packages. It provides a standard
# environment with basic UNIX utilities like a C++ compiler, a bash shell,
# coreutils, etc.
#
# fetchurl is a function that simply downloads files.
#
# perl is the perl interpreter.
{ stdenv, fetchurl, perl }:

# Make a derivation from a set of attributes.
stdenv.mkDerivation {
    # Create a symbolic name and version. This is required for mkDerivation.
    name = "hello-2.1.1";

    # Specify what builds the package. This can be omitted and set to the
    # default 'configure; make; make install' build chain.
    # builder = ./builder.sh;

    # Specify a dependency called 'src'.
    src = fetchurl {
        url = ftp://ftp.nluug.nl/pub/gnu/hello/hello-2.1.1.tar.gz;
        sha256 = "1md7jsfd8pa45z73bz1kszpp01yw6x5ljkjk2hx7wl800any6465";
    };

    # Shorthand for 'perl = perl;', which binds the environment variable 'perl'
    # in the builder to the location of the perl package.
    inherit perl;
}
