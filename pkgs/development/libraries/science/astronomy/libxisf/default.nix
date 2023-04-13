{ stdenv, lib, fetchurl, lz4, zlib, pkg-config, pugixml, cmake }:

stdenv.mkDerivation rec {
  pname = "libxisf";
  version = "0.2.3";

  src = fetchurl {
    url = "https://gitea.nouspiro.space/nou/libXISF/archive/v${version}.tar.gz";
    sha256 = "sha256-VXTYUK/RWPlJCJveuc9SuBQCPXfHmO0vIDCCixf0cfw";
  };

  nativeBuildInputs = [ pkg-config cmake ];

  buildInputs = [ lz4 zlib pugixml ];

  meta = with lib; {
    homepage = "https://gitea.nouspiro.space/nou/libXISF";
    description = "Library for reading and writing XISF data files";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ bzizou ];
    platforms = with platforms; linux ++ darwin;
  };
}
