{ lib
, adb-shell
, aiofiles
, buildPythonPackage
, fetchFromGitHub
, mock
, pure-python-adb
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "androidtv";
  version = "0.0.63";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "JeffLIrion";
    repo = "python-androidtv";
    rev = "v${version}";
    hash = "sha256-Peg/agAb1lUBUBK1OkYVovE4pzM8iaQHVaSk/hr1plw=";
  };

  propagatedBuildInputs = [
    adb-shell
    aiofiles
    pure-python-adb
  ];

  checkInputs = [
    mock
    pytestCheckHook
  ];

  disabledTests = [
    # Requires git but fails anyway
    "test_no_underscores"
  ];

  pythonImportsCheck = [
    "androidtv"
  ];

  meta = with lib; {
    description = "Communicate with an Android TV or Fire TV device via ADB over a network";
    homepage = "https://github.com/JeffLIrion/python-androidtv/";
    license = licenses.mit;
    maintainers = with maintainers; [ jamiemagee ];
  };
}
