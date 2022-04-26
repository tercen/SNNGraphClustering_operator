library(tercen)
library(dplyr)
library(scran)
library(igraph)

ctx <- tercenCtx()

k <- as.integer(ctx$op.value('k'))
edge_weighting <- as.character(ctx$op.value('edge_weighting'))
clustering_method <- as.character(ctx$op.value('clustering_method'))

pca_matrix <- ctx$as.matrix()

snngraph <- buildSNNGraph(pca_matrix,
                          k = k,
                          type = edge_weighting)

if (clustering_method == "Walktrap") {
  clusters <- cluster_walktrap(snngraph)$membership
} else if (clustering_method == "Louvain") {
  clusters <- cluster_louvain(g)$membership
}


clusters <- sprintf(paste0("c%0", max(nchar(as.character(clusters))), "d"), clusters)

output_frame <- tibble(.ci = 0:(length(clusters) - 1),
                       cluster_id = clusters)

ctx$addNamespace(output_frame) %>%
  ctx$save()
