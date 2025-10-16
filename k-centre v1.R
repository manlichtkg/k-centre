library(ggplot2)

# -----------------------------------------------------
# Conversion en matrice si nécessaire
# -----------------------------------------------------
D <- as.matrix(votre_fichier)

# Vérification que la matrice est carrée
if (nrow(D) != ncol(D)) stop("La matrice de distances doit être carrée !")

# -----------------------------------------------------
# Fonction pour trouver les deux centres
# -----------------------------------------------------
find_two_centers <- function(D, seed = 123) {
  set.seed(seed)
  n <- nrow(D)
  best_cost <- Inf
  best_centers <- c(NA, NA)
  
  for (i in 1:(n-1)) {
    for (j in (i+1):n) {
      d_min <- pmin(D[, i], D[, j])
      cost <- sum(d_min)
      if (cost < best_cost) {
        best_cost <- cost
        best_centers <- c(i, j)
      }
    }
  }
  
  cluster_assign <- apply(D[, best_centers], 1, which.min)
  
  return(list(
    centers = best_centers,
    total_distance = best_cost,
    cluster = cluster_assign
  ))
}

# -----------------------------------------------------
# Application sur la matrice
# -----------------------------------------------------
result <- find_two_centers(D)

cat("Centres choisis :", result$centers, "\n\n")

# -----------------------------------------------------
# Création d'une dataframe pour visualisation
# -----------------------------------------------------
n <- nrow(D)
set.seed(123)

# Générer des coordonnées pour visualiser les points
coords <- data.frame(
  Point = 1:n,
  x = runif(n, 0, 10),
  y = runif(n, 0, 10),
  Cluster = factor(result$cluster)
)

# Ajouter une colonne indiquant le centre assigné à chaque point
coords$Centre <- result$centers[result$cluster]

# Coordonnées des centres
centres_coords <- coords[coords$Point %in% result$centers, ]
centres_coords$Cluster <- "Centre"

# -----------------------------------------------------
# Visualisation avec ggplot2
# -----------------------------------------------------
# 1. Tracer les lignes point -> centre
lines_df <- data.frame(
  x = coords$x,
  y = coords$y,
  xend = coords$x[match(coords$Centre, coords$Point)],
  yend = coords$y[match(coords$Centre, coords$Point)]
)

ggplot() +
  # lignes reliant chaque point à son centre
  geom_segment(data = lines_df, aes(x = x, y = y, xend = xend, yend = yend),
               color = "grey70") +
  # points normaux
  geom_point(data = coords, aes(x = x, y = y, color = Cluster), size = 3) +
  # centres en rouge plus grands
  geom_point(data = centres_coords, aes(x = x, y = y), color = "red", size = 6) +
  geom_text(data = coords, aes(x = x, y = y, label = Point), vjust = -1) +
  labs(title = "Visualisation des points et des 2 centres",
       x = "Coordonnée X", y = "Coordonnée Y") +
  theme_minimal() +
  scale_color_manual(values = c("1"="blue","2"="green","Centre"="red"))
