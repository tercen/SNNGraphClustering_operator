library(tercen)
library(dplyr)
library(scran)
library(igraph)

options("tercen.workflowId" = "f6d7883d26d906b1a8c4a3800d0616d4")
options("tercen.stepId"     = "1d5b9f2e-760b-40a0-a53e-3d831a939da8")

getOption("tercen.workflowId")
getOption("tercen.stepId")

ctx <- tercenCtx()

pca_matrix <- ctx$as.matrix()

snngraph <- buildSNNGraph(pca_matrix,
                          k = k,
                          type = edge_weighting)

if (clustering_method == "Walktrap") {
  clusters <- cluster_walktrap(snngraph)$membership
} else if (clustering_method == "Louvain") {
  clusters <- cluster_louvain(g)$membership
}
