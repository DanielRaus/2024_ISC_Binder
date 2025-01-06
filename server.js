const express = require("express");
const app = express();
const { Client } = require('pg');
const mysql = require('mysql');

const db = new Client({
  host: "localhost",
  user: "postgres",
  password: "myverysecretpassword",
  database: "books",
  port: 5432,
});

db.connect((err) => {
  if (err) {
    console.error("Erreur de connection à la DB", err);
    process.exit(1);
  }
  console.log("Connexion réussie à la DB");
})

// Middleware pour parser les données du corps de la requête
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Définir une route par défaut
app.get("/", (req, res) => {
  res.send("Hello, World! Le serveur Express.js fonctionne.");
});

// Route GET pour la page /login
app.get("/login", (req, res) => {
  console.log("Requête reçue pour /login");

  const query = 'SELECT * FROM authors'; // Votre requête SQL

  // Exécution de la requête SQL
  db.query(query, (err, results) => {
    if (err) {
      console.error("Erreur lors de l'exécution de la requête :", err.message);
      return res.status(500).send("Erreur serveur.");
    }

    console.log("Résultats reçus de la base de données :", results);
    res.json(results); // Envoi des résultats comme réponse JSON
  });
});

// Démarrer le serveur
const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${PORT}`);
});