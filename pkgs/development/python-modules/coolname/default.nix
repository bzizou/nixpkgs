{ lib
, buildPythonPackage
, fetchPypi
, setuptools
}:

buildPythonPackage rec {
  pname = "coolname";
  version = "2.2.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bF1XMXWRBEeefKGVqbZPeQCsW+rUAYPAkyPH0L6edcc=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  meta = with lib; {
    description = "Generates random human-readable strings";
    homepage = "https://github.com/alexanderlukanin13/coolname";
    license = licenses.bsd2;
    maintainers = with maintainers; [ bzizou ];
  };
}
