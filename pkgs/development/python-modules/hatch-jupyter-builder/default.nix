{ lib
, buildPythonPackage
, fetchFromGitHub
, hatchling
, pytest-mock
, pytestCheckHook
, tomli
, twine
}:

buildPythonPackage rec {
  pname = "hatch-jupyter-builder";
  version = "0.8.3";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "jupyterlab";
    repo = "hatch-jupyter-builder";
    rev = "refs/tags/v${version}";
    hash = "sha256-UywhFJ8d1+lSFOF5ECsknDeQuO7ppckdy5IqAT14ius=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  nativeCheckInputs = [
    pytest-mock
    pytestCheckHook
    tomli
    twine
  ];

  disabledTests = [
    # tests pip install, which unsuprisingly fails
    "test_hatch_build"
  ];

  meta = with lib; {
    changelog = "https://github.com/jupyterlab/hatch-jupyter-builder/releases/tag/v${version}";
    description = "hatch plugin to help build Jupyter packages";
    mainProgram = "hatch-jupyter-builder";
    homepage = "https://github.com/jupyterlab/hatch-jupyter-builder";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
