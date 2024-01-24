{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, setuptools-scm
, sniffio
}:

buildPythonPackage rec {
  pname = "asgi-lifespan";
  version = "2.1.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Xi7/rwv+OYKc8tZOfsxHx9htZ2plmfevujeMMfXjowg=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];
  propagatedBuildInputs = [
    sniffio
  ];

  meta = with lib; {
    description = "Send startup/shutdown lifespan events into ASGI applications";
    homepage = "https://github.com/florimondmanca/asgi-lifespan";
    license = licenses.mit;
    maintainers = with maintainers; [ bzizou ];
  };
}
