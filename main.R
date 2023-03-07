suppressPackageStartupMessages(expr = {
  library(dbscan)
  library(tidyr)
  library(dplyr)
  library(tercen)
})

ctx = tercenCtx()
x <- ctx$as.matrix() %>% t()

k <- ctx$op.value("k", as.double, 2)
snn_eps <- ctx$op.value("snn_eps", as.double, 4)
snn_minPts <- ctx$op.value("snn_minPts", as.double, 16)

# Run KNN: find neighbours
knn <- kNN(
  x,
  k = k,
  query = NULL,
  sort = TRUE,
  search = "kdtree",
  bucketSize = 10,
  splitRule = "suggest",
  approx = 0
)

# Run SNN: clustering
clst <- sNNclust(
  knn,
  k = k,
  eps = snn_eps,
  minPts = snn_minPts
)

clst$cluster <- as.double(clst$cluster + 1)
tibble(
  cluster_number = clst$cluster,
  cluster_id = sprintf(paste0("c%0", max(nchar(as.character(clst$cluster))), "d"), clst$cluster)
) %>% 
  mutate(.ci = seq_len(nrow(.)) - 1L) %>%
  ctx$addNamespace() %>%
  ctx$save()
