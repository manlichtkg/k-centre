Excellent 💪 Voici un **README clair, bien structuré et esthétique** que tu peux inclure dans ton projet R (par exemple dans un fichier `README.md`).
Il explique le but, la méthode, le code et la visualisation.

---

# 📘 Optimisation du choix de deux centres minimisant la distance maximale des points

## 🧭 Objectif du projet

Ce projet implémente **la méthode du 2-centres (2-center problem)**, dont l’objectif est de déterminer **deux points centraux** parmi un ensemble de coordonnées (x, y) de sorte que **le trajet maximal de tout point vers son centre soit le plus petit possible**.

En d’autres termes :

> On cherche les deux centres qui couvrent l’ensemble des points en minimisant la plus grande distance d’un point à son centre.

---

## 🧮 Méthodologie

Le script en R :

1. Lit les coordonnées des points (x, y).
2. Calcule toutes les combinaisons possibles de deux centres parmi les points.
3. Pour chaque paire de centres :

   * Calcule la distance de chaque point aux deux centres.
   * Associe chaque point à son centre le plus proche.
   * Évalue la **distance maximale** parmi toutes les distances vers les centres.
4. Sélectionne la paire de centres pour laquelle cette **distance maximale** est **minimale** (critère min–max).
5. Affiche :

   * Les indices et coordonnées des centres retenus.
   * La distance maximale minimale obtenue.
   * Une visualisation graphique des points et des centres.

---

## 📊 Visualisation

Le graphique généré montre :

* 🔴 Les **centres optimaux**, affichés en rouge avec leurs étiquettes.
* 🔵🟢 Les **points appartenant à chaque cluster**, colorés selon leur centre.
* Les **segments gris** reliant chaque point à son centre le plus proche.
* Chaque point est **numéroté de 0 à 19** pour une identification rapide.

Exemple d’aperçu :

```
Deux centres minimisant le trajet maximal (points numérotés de 0 à 19)
```

---

## 💻 Exécution du script

### 1️⃣ Prérequis

Assurez-vous d’avoir installé **R** et le package suivant :

```r
install.packages("ggplot2")
```

### 2️⃣ Lancer le code

Placez le fichier `.R` dans votre répertoire de travail, puis exécutez :

```r
source("deux_centres_minimax.R")
```

Le script affichera :

* Les coordonnées des deux centres optimaux
* Le tableau des points et de leurs affectations
* La visualisation graphique interactive

---

## 📈 Exemple de sortie (console)

```
Indices des centres choisis : 7 17
Coordonnées des centres choisis :
  Point  x  y
7    7 28 48
17  17 43 19
Distance maximale minimale : 29.15476
```

---

## 🧩 Structure du projet

```
📁 Projet_2_Centres/
│
├── deux_centres_minimax.R     # Code principal R
├── README.md                  # Présent fichier
├── data.xlsx (optionnel)      # Données sources (si utilisées)
└── output/
    ├── graphique_centres.png  # Export du graphique
    └── resultats.txt          # Résumé des centres trouvés
```

---

## 🔬 Concepts clés

* **Problème des k-centres** : variante du clustering visant à minimiser la distance maximale à un centre.
* **Distance euclidienne** : mesure utilisée pour évaluer la proximité entre points.
* **Optimisation combinatoire** : exploration exhaustive des couples de centres possibles.

---

## 🧠 Auteurs et crédits

**Auteur :** Mannlich TANKENG
**Langage :** R
**Version :** 1.0
**Dernière mise à jour :** Octobre 2025
