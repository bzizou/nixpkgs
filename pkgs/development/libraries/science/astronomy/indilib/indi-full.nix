{ stdenv, lib, callPackage, fetchFromGitHub, indilib }:

let
  inherit (indilib) version;
  indi-3rdparty-src = fetchFromGitHub {
    owner = "bzizou";
    repo = "indi-3rdparty";
    rev = "0f426179f5b9086ddf2eb64615188e9508f1b66c";
    hash = "sha256-pc85QJz0qbOMxLWfyCJCg21+9IXy+x6eqGvkcEPbECA=";
  };

#  indi-3rdparty-src = ./indi-3rdparty.tgz ;

  indi-firmware = callPackage ./indi-firmware.nix {
    inherit version;
    src = indi-3rdparty-src;
  };
  indi-3rdparty = callPackage ./indi-3rdparty.nix {
    inherit version;
    src = indi-3rdparty-src;
    withFirmware = stdenv.isx86_64 || stdenv.isAarch64;
    firmware = indi-firmware;
  };
in
callPackage ./indi-with-drivers.nix {
  pname = "indi-full";
  inherit version;
  extraDrivers = [
    indi-3rdparty
  ] ++ lib.optional (stdenv.isx86_64 || stdenv.isAarch64) indi-firmware
  ;
}
