import pathlib


def read_fixture(filename: str):
  path = pathlib.Path(__file__).parent.resolve()
  with open(path / filename) as f:
    lines = f.readlines
