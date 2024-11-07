 # Random variables

This repository contains implementations and report for classwork, of the
discipline GA030 - Statistics, given at LNCC, about random variables and it
properties as related to the central limit theorem and the law of large
numbers.

The data and supporting material can be found at:

> https://lncc.br/~mrborges/

# Folders

.
├── docs
├── notebooks
├── pyproject.toml
├── README.md
├── report
└── uv.lock

3 directories, 3 files

- docs: Contains documents that support the classwork
- notebooks: Contains the implementation notebook on pdf and ipynb
- report: Contains the report in typst, figures, and final pdf.

The other files are metadata on the python configuration and this README.md.

# Reproducibility instructions

To reproduce this build you can use the Python management tool `uv`. Install it using your
favorite method:

> https://github.com/astral-sh/uv?tab=readme-ov-file#installation

Clone this repo:

`git clone https://github.com/jpssrocha/random_variables_GA30-Statistics.git`

Enter the folder and run:

```bash
$uv venv
$uv sync --locked
```

To start jupyter run: `uv run jupyter lab`
