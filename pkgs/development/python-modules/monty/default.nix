{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, msgpack
, pytestCheckHook
, numpy
, pandas
, pydantic
, pymongo
, ruamel-yaml
, tqdm
}:

buildPythonPackage rec {
  pname = "monty";
  version = "2022.1.12.1";
  disabled = pythonOlder "3.5"; # uses type annotations

  src = fetchFromGitHub {
    owner = "materialsvirtuallab";
    repo = pname;
    rev = "v${version}";
    sha256 = "11bp3zkmqffc6rqw93qfk8d905mzc10nqbjmvj2bay8h197q0dg2";
  };

  postPatch = ''
    substituteInPlace tests/test_os.py \
      --replace 'self.assertEqual("/usr/bin/find", which("/usr/bin/find"))' '#'
  '';

  propagatedBuildInputs = [
    ruamel-yaml
    tqdm
    msgpack
  ];

  checkInputs = [
    pytestCheckHook
    numpy
    pandas
    pydantic
    pymongo
  ];

  meta = with lib; {
    description = "Serves as a complement to the Python standard library by providing a suite of tools to solve many common problems";
    longDescription = "
      Monty implements supplementary useful functions for Python that are not part of the
      standard library. Examples include useful utilities like transparent support for zipped files, useful design
      patterns such as singleton and cached_class, and many more.
    ";
    homepage = "https://github.com/materialsvirtuallab/monty";
    license = licenses.mit;
    maintainers = with maintainers; [ psyanticy ];
  };
}
