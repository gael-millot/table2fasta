
| Usage | Requirement |
| :--- | :--- |
| [![R](https://img.shields.io/badge/code-R-blue?style=plastic)](https://cran.r-project.org/) | [![Dependencies: R Version](https://img.shields.io/badge/R-v4.3.1-blue?style=plastic)](https://cran.r-project.org/bin/) |
| [![License: GPL-3.0](https://img.shields.io/badge/licence-GPL%20(%3E%3D3)-green?style=plastic)](https://www.gnu.org/licenses) | |

<br /><br />
## TABLE OF CONTENTS

   - [AIM](#aim)
   - [CONTENT](#content)
   - [INPUT](#input)
   - [HOW TO RUN](#how-to-run)
   - [OUTPUT](#output)
   - [VERSIONS](#versions)
   - [LICENCE](#licence)
   - [CITATION](#citation)
   - [CREDITS](#credits)
   - [ACKNOWLEDGEMENTS](#Acknowledgements)
   - [WHAT'S NEW IN](#what's-new-in)

<br /><br />
## AIM

- Create fasta files from nucleotide or amino acid sequences present in a table file (.xlsx, .csv, .tsv and .txt).
- Return "single" (each sequence in a different fasta file) or "multi" (all the sequences in a single fasta file) fasta files.
- Return all the sequences of the input file into a single "All" folder.
- Fasta files can also be gathered in additional folders according to categorical informations present in the table file.


<br /><br />
## CONTENT
<br />

| File | Description |
| :--- | :--- |
| **table2fasta.R** | File to run. |
| **Licence.txt** | Licence of the release. |

Dataset and results are available at https://zenodo.org/records/10844886.

<br /><br />
## INPUT
<br />

| Required files |
| :--- |
| A .xlsx, .csv, .tsv or .txt file that must contain:<br /><ul><li>A "name" column.<br /></li><li>One or several "sequences" columns.<br /></li><li>One or several "categorical" columns (optional). |

<br />

Description of the dataset available in Zenodo:
<br />

| File | Description |
| :--- | :--- |
| **ig_sequences.xlsx** | .xlsx file used by default in the *table2fasta.R* file (in the *Parameters that need to be set by the user* section). Click [here](https://zenodo.org/records/10844886/files/ig_sequences.xlsx) to download and see it. |


<br /><br />
## HOW TO RUN

### 1. Prerequisite

Installation of:<br />
[R](https://pbil.univ-lyon1.fr/CRAN/)<br />


### 2. Local running (personal computer)

- Download the *table2fasta.R* file ([here](https://github.com/gael-millot/table2fasta/archive/refs/heads/master.zip) for the last version. Otherwise, check the previous versions [here](https://github.com/gael-millot/table2fasta/tags)).
- Open it.
- Complete the *Parameters that need to be set by the user* section.
- Save the modifications.
- Open a R session.
- Source the *table2fasta.R* file to run it. Example: `source("C:/Users/gmillot/Desktop/table2fasta.R")`


<br /><br />
## OUTPUT
<br />

| table2fasta_<UNIQUE_ID> folder | Description |
| :--- | :--- |
| **table2fasta.log** | Log file, notably indicating the parameter settings used. |
| **All** | Folder containing the fasta files of all the sequences present in the table file. The number of fasta files varies according to the setting of the `Seq` and `file.kind` parameters. |
| | Additional folders are present if the `categ` parameter setting has been filled. |


Click [here](https://zenodo.org/records/10844886/files/example_of_results.zip) to get examples of results, obtained with the dataset from the [Input](#input) section. The *table2fasta_1710949947* folder results from the `file.kind` parameter set to `"single"`, and *table2fasta_1710949980* from  `file.kind` set to `"multi"`.

<br /><br />
## VERSIONS


The different releases are tagged [here](https://github.com/gael-millot/table2fasta/tags).

<br /><br />
## LICENCE


This package of scripts can be redistributed and/or modified under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
Distributed in the hope that it will be useful, but without any warranty; without even the implied warranty of merchandability or fitness for a particular purpose.
See the GNU General Public License for more details at https://www.gnu.org/licenses or in the Licence.txt attached file.

<br /><br />
## CITATION


Not yet published.


<br /><br />
## CREDITS


[Gael A. Millot](https://github.com/gael-millot), Hub, Institut Pasteur, Paris, France

<br /><br />
## ACKNOWLEDGEMENTS


The developers & maintainers of the mentioned softwares and packages, including:

- [R](https://www.r-project.org/)
- [Git](https://git-scm.com/)
- [Github](https://github.com/)
- [Gitlab](https://about.gitlab.com/)


<br /><br />
## WHAT'S NEW IN

### v3.0

- Now accept .txt, .csv and .tsv extension, in addtion to .xlsx.


### v2.1

- A test line removed.


### v2.0

- Problem of NA not removed when categ parameter is used.


### v1.3

- Better log report.


### v1.2

- New Zenodo repository.


### v1.1

- README file improved.


### v1.0
 Everything.



