{ pythonOlder
, buildPythonPackage
, fetchPypi
, lib
, kicad
, versioneer
}:
buildPythonPackage rec {
  pname = "pcbnewTransition";
  version = "0.4.1";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-+mRExuDuEYxSSlrkEjSyPK+RRJZo+YJH7WnUVfjblRQ=";
  };

  propagatedBuildInputs = [
    kicad
  ];

  nativeBuildInputs = [
    versioneer
  ];

  pythonImportsCheck = [
    "pcbnewTransition"
  ];

  meta = with lib; {
    description = "Library that allows you to support both, KiCad 5, 6 and 7 in your plugins";
    homepage = "https://github.com/yaqwsx/pcbnewTransition";
    changelog = "https://github.com/yaqwsx/pcbnewTransition/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ jfly matusf ];
  };
}
