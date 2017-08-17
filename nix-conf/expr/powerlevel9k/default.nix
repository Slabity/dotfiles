{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
    name = "powerlevel9k";
    src = fetchFromGitHub {
        owner = "bhilburn";
        repo = "powerlevel9k";
        rev = "master";
        sha256 = "1zkjlbl4i8msdpr7cfwr4glksxb63zq9gwnm886qp82rlca0r4rc";
    };

    installPhase = ''
        mkdir -p $out/powerlevel9k
        mv * $out/powerlevel9k
    '';
}
