{ lib
, fetchFromGitHub
, python3
}:

let
  python = python3.override {
    packageOverrides = self: super: {
      anyio = super.anyio.overridePythonAttrs (_prev: rec {
        version = "3.7.1";
        src = fetchFromGitHub {
          owner = "agronholm";
          repo = "anyio";
          rev = "refs/tags/${version}";
          hash = "sha256-9/pAcVTzw9v57E5l4d8zNyBJM+QNGEuLKrQ0WUBW5xw=";
        };
      });
      httpcore = super.httpcore.overridePythonAttrs (_prev: rec {
        # Due to deprecation warnings from trio
        doCheck = false;
      });
    };
  };
in python.pkgs.buildPythonApplication rec {
  pname = "prefect";
  version = "2.14.16";

  src = fetchFromGitHub {
    owner = "PrefectHQ";
    repo = pname;
    rev = "${version}";
    hash = "sha256-DCyCk/gB+dTz8wOOgqbXoSgwHhXEa+DANOcCqsJcgxg=";
  };

  propagatedBuildInputs = with python.pkgs; [
    aiosqlite
    alembic
    apprise
    asyncpg
    anyio
    asgi-lifespan
    cachetools
    click
    cloudpickle
    coolname
    croniter
    cryptography
    dateparser
    docker
    fsspec
    graphviz
    griffe
    httpcore
    httpx
    importlib-metadata
    jinja2
    jsonpatch
    jsonschema
    kubernetes
    orjson
    packaging
    pathspec
    pendulum
    pydantic
    python-dateutil
    python-slugify
    pyyaml
    pytz
    readchar
    rich
    ruamel-yaml
    sniffio
    starlette
    sqlalchemy
    toml
    typer
    typing-extensions
    ujson
    uvicorn
    websockets
  ]++ uvicorn.optional-dependencies.standard;

  # Checks are uing pip
  doCheck = false;

  meta = with lib; {
    homepage = "https://PrefectHQ/prefect";
    description = "Platform for building, observing, and triaging workflows";
    platforms = platforms.all;
    license = licenses.asl20;
    maintainers = with maintainers; [ bzizou ];
  };
}
