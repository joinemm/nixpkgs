{
  lib,
  fetchFromGitHub,
  coreutils,
  curl,
  gnugrep,
  gnused,
  gzip,
  nix,
  python,
  # python libs
  colorlog,
  graphviz,
  numpy,
  packageurl-python,
  pandas,
  requests,
  reuse,
  tabulate,
  packaging,
  beautifulsoup4,
  pyrate-limiter,
  requests-ratelimiter,
  requests-cache,
  typing-extensions,
  dataproperty,
  mbstrdecoder,
  pathvalidate,
  tabledata,
  typepy,
}:
python.pkgs.buildPythonApplication rec {
  pname = "sbomnix";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "tiiuae";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-MLkAUzgBxjd0aPDC0KqmG9P94rZ+m4OO4M7k/ITC7TQ=";
  };

  makeWrapperArgs = [
    "--prefix PATH : ${lib.makeBinPath [coreutils curl gnugrep gnused gzip graphviz nix]}"
  ];

  # https://github.com/thombashi/df-diskcache
  # not available in nixpkgs
  dfdiskcache = python.pkgs.buildPythonPackage rec {
    version = "0.0.2";
    pname = "df-diskcache";
    format = "setuptools";

    src = fetchFromGitHub {
      owner = "thombashi";
      repo = "df-diskcache";
      rev = "v${version}";
      hash = "sha256-s+sqEPXw6tbEz9mnG+qeUSF6BmDssYhaDYOmraFaRbw=";
    };

    propagatedBuildInputs = [
      simplesqlite
      pandas
      typing-extensions
    ];

    pythonImportsCheck = ["dfdiskcache"];
    doCheck = false;
  };

  # Required due to dfdiskcache
  # not available in nixpkgs
  simplesqlite = python.pkgs.buildPythonPackage rec {
    version = "1.5.2";
    pname = "SimpleSQLite";
    format = "setuptools";

    src = fetchFromGitHub {
      owner = "thombashi";
      repo = "SimpleSQLite";
      rev = "v${version}";
      hash = "sha256-Yr17T0/EwVaOjG+mzdxopivj0fuvQdZdX1bFj8vq0MM=";
    };

    propagatedBuildInputs = [
      sqliteschema
      dataproperty
      mbstrdecoder
      pathvalidate
      tabledata
      typepy
    ];

    pythonImportsCheck = ["simplesqlite"];
    doCheck = false;
  };

  # Required due to dfdiskcache
  # not available in nixpkgs
  sqliteschema = python.pkgs.buildPythonPackage rec {
    version = "1.4.0";
    pname = "sqliteschema";
    format = "setuptools";

    src = fetchFromGitHub {
      owner = "thombashi";
      repo = "sqliteschema";
      rev = "v${version}";
      hash = "sha256-IzHdYBnh6udVsanWTPSsX4p4PG934YCdzs9Ow/NW86E=";
    };

    propagatedBuildInputs = [
      mbstrdecoder
      tabledata
      typepy
    ];

    pythonImportsCheck = ["sqliteschema"];
    doCheck = false;
  };

  propagatedBuildInputs = [
    beautifulsoup4
    colorlog
    graphviz
    numpy
    packageurl-python
    packaging
    pandas
    pyrate-limiter
    requests
    requests-cache
    requests-ratelimiter
    reuse
    tabulate
    dfdiskcache
  ];

  pythonImportsCheck = ["sbomnix"];

  meta = with lib; {
    description = "Generate SBOMs for nix targets";
    homepage = "https://github.com/tiiuae/sbomnix";
    license = with licenses; [asl20 bsd3 cc-by-30];
    maintainers = with maintainers; [henrirosten jk joinemm];
  };
}
