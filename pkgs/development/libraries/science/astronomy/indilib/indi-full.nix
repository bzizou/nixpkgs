{ stdenv, lib, callPackage, fetchFromGitHub, indilib }:

let
  inherit (indilib) version;
#  indi-3rdparty-src = fetchFromGitHub {
#    owner = "bzizou";
#    repo = "indi-3rdparty";
#    rev = "8a121cff899eca6f658971c4aee67380f66defcf";
#    hash = "sha256-Usin1gw35sXCR/lh8uXKjD2RAaRgQ6YX6hUtWFOANbs=";
#  };

### For local dev - To remove after github push
  indi-3rdparty-src = ./indi-3rdparty.tgz;
###

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
