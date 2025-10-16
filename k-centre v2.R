library(ggplot2)

# 1. Coordonnées des points
coords <- data.frame(
  Point = 1:20,
  x = c(47,17,43,50,8,28,6,28,22,15,7,13,6,3,40,3,43,41,17,10),
  y = c(5,30,5,42,38,24,3,48,34,22,27,45,46,35,26,39,19,42,12,17)
)

# 2. Fonction k-center pour 2 centres minimisant le rayon maximal
find_two_centers_minmax <- function(coords) {
  n <- nrow(coords)
  best_cost <- Inf
  best_centers <- c(NA, NA)
  
  for (i in 1:(n-1)) {
    for (j in (i+1):n) {
      dist_i <- sqrt((coords$x - coords$x[i])^2 + (coords$y - coords$y[i])^2)
      dist_j <- sqrt((coords$x - coords$x[j])^2 + (coords$y - coords$y[j])^2)
      min_dist <- pmin(dist_i, dist_j)
      cost <- max(min_dist)  # distance maximale pour ce couple
      if (cost < best_cost) {
        best_cost <- cost
        best_centers <- c(i, j)
      }
    }
  }
  
  # Attribution des points au centre le plus proche
  dist_c1 <- sqrt((coords$x - coords$x[best_centers[1]])^2 + (coords$y - coords$y[best_centers[1]])^2)
  dist_c2 <- sqrt((coords$x - coords$x[best_centers[2]])^2 + (coords$y - coords$y[best_centers[2]])^2)
  cluster_assign <- ifelse(dist_c1 <= dist_c2, 1, 2)
  
  coords$Centre <- best_centers[cluster_assign]
  coords$Cluster <- factor(cluster_assign)
  
  # Coordonnées des centres choisis
  centres_coords <- coords[coords$Point %in% best_centers, c("Point","x","y")]
  
  list(
    centers_index = best_centers,
    centers_coords = centres_coords,
    max_distance = best_cost,
    coords = coords
  )
}

# 3. Application
result <- find_two_centers_minmax(coords)

cat("Indices des centres choisis :", result$centers_index, "\n")
cat("Coordonnées des centres choisis :\n")
print(result$centers_coords)
cat("Distance maximale minimale :", result$max_distance, "\n\n")
print(result$coords)

# 4. Visualisation
lines_df <- data.frame(
  x = result$coords$x,
  y = result$coords$y,
  xend = sapply(result$coords$Centre, function(c) result$coords$x[result$coords$Point==c]),
  yend = sapply(result$coords$Centre, function(c) result$coords$y[result$coords$Point==c])
)

centres_coords <- result$coords[result$coords$Point %in% result$centers_index, ]

p <- ggplot() +
  geom_segment(data = lines_df, aes(x=x, y=y, xend=xend, yend=yend),
               color="grey70", linewidth=0.8) +
  geom_point(data=result$coords, aes(x=x, y=y, color=Cluster), size=4) +
  geom_point(data=centres_coords, aes(x=x, y=y), color="red", size=6) +
  geom_text(data=result$coords, aes(x=x, y=y, label=Point), vjust=-1.2, size=3.5) +
  geom_text(data=centres_coords, aes(x=x, y=y, label=paste0("Centre ", Point)),
            color="red", vjust=1.5, fontface="bold") +
  labs(title="Deux centres minimisant le trajet maximal",
       x="X", y="Y") +
  theme_minimal() +
  scale_color_manual(values=c("1"="blue","2"="green")) +
  theme(legend.position="none")

print(p)
