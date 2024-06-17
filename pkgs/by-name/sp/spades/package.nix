{
  lib,
  stdenv,
  bzip2,
  cmake,
  fetchFromGitHub,
  fetchpatch,
  ncurses,
  python3,
  readline,
  zlib-ng,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "spades";
  version = "4.0.0";

  src = fetchFromGitHub {
    owner = "ablab";
    repo = "spades";
    rev = "v${finalAttrs.version}";
    hash = "sha256-k2+ddJIgGE41KGZODovU9VdurbWerEtdqNrFDwyuFjo=";
  };

  sourceRoot = "source/src";

  patches = [
    # https://github.com/ablab/spades/pull/1314
    (fetchpatch {
      name = "copytree.patch";
      url = "https://github.com/ablab/spades/pull/1314/commits/af9feaf4cc7cbd9102362309f582e8645c471e02.patch";
      hash = "sha256-tkT7hb0TqsbLkcTs9u43nzvV8bVdh3G9VKYqFFLrQv8=";
      stripLen = 3;
      extraPrefix = "projects/";
    })
  ];

  cmakeFlags = [
    "-DZLIB_ENABLE_TESTS=OFF"
    "-DSPADES_BUILD_INTERNAL=OFF"
  ];

  preConfigure = ''
    # The CMakeListsInternal.txt file should be empty in the release tarball
    echo "" > CMakeListsInternal.txt
  '';

  nativeBuildInputs = [ cmake ];

  buildInputs = [
    bzip2
    ncurses
    python3
    readline
    zlib-ng
  ];

  doCheck = true;

  meta = {
    description = "St. Petersburg genome assembler, a toolkit for assembling and analyzing sequencing data";
    changelog = "https://github.com/ablab/spades/blob/${finalAttrs.version}/changelog.md";
    downloadPage = "https://github.com/ablab/spades";
    homepage = "http://ablab.github.io/spades";
    license = lib.licenses.gpl2Only;
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
    ];
    maintainers = with lib.maintainers; [ bzizou ];
  };
})
