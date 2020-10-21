library(tercen)
library(dplyr)
library(scran)
library(igraph)

options("tercen.workflowId" = "f6d7883d26d906b1a8c4a3800d0616d4")
options("tercen.stepId"     = "cf9376a1-ea5d-44b5-92a2-3e7338e4948a")

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

output_frame <- tibble(.ci = 0:(length(clusters)-1),
                       cluster = as.numeric(clusters))

ctx$addNamespace(output_frame) %>%
  ctx$save()

