{ stdenv
, lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, cython
, mock
, numpy
, pathlib
, pytest
, pytz
}:

buildPythonPackage rec {
  pname = "srsly";
  version = "2.0.1";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "fa3c7375be8fe75f23c27feafbfb5f738d55ffdbf02964c6896fb7684f519a52";
  };

  nativeBuildInputs = [ cython ];

  checkInputs = [
    mock
    numpy
    pytest
    pytz
  ];

  # TypeError: cannot serialize '_io.BufferedRandom' object
  # Possibly because of sandbox restrictions.
  doCheck = false;

  pythonImportsCheck = [ "srsly" ];

  meta = with stdenv.lib; {
    description = "Modern high-performance serialization utilities for Python";
    homepage = "https://github.com/explosion/srsly";
    license = licenses.mit;
    maintainers = with maintainers; [ danieldk ];
  };
}
