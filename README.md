# SNN Graph-based clustering operator

##### Description
`SNNGraph-based clustering operator` performs clustering on single-cell RNA-seq data and returns the cluster assigned to each cell. It should be used on a reduced-dimensionality version of the scRNA-seq data (the first 25 principal components, for example).

##### Usage

Input projection|.
---|---
`x-axis`        | character, cell ID
`row names`     | character, principal component name
`y-axis`        | numeric, principal component value



| Input parameters | Description                                                                              |
| -----------------| ---------------------------------------------------------------------------------------- |
| `k`          | Numeric, number of nearest neighbors to consider during graph construction (default = 5)             |
| `edge_weighting`  | "rank" or "number", specifying the type of weighting scheme to use for shared neighbors in graph construction (default = "rank") |
| `clustering_method` | "Walktrap" or "Louvain", algorithm to find clusters inside graph    |

Output relations|.
---|---
`cluster`       | numeric, cluster to which a cell has been assigned 

##### Details
The operator uses the QC worklfow described in the corresponding chapter of the ["Orchestrating Single-Cell Analysis"](https://osca.bioconductor.org/clustering.html) book. For this it uses the _scran_ BioConductor package.

#### References
Amezquita, et. al. ["Orchestrating single-cell analysis with BioConductor"](https://www.nature.com/articles/s41592-019-0654-x), Nature Methods (2019)

##### See Also

#### Examples

