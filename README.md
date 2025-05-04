
<h1 align="center"> Système de Gestion de Clinique </h1>

![image](https://github.com/user-attachments/assets/e5e93118-bee7-481d-9dab-b8ae51371473)


## 📌 Contexte

    Le projet Gestion de Clinique vise à développer une application pour simplifier les interactions entre médecins et patients, en automatisant le suivi des consultations et la gestion des dossiers médicaux et administratifs. La solution centralisera les données des médecins (spécialités, disponibilités), des patients (historique, prescriptions) et des consultations (diagnostics, dates), optimisant ainsi l'organisation des soins.

## 🛠️ Problématique
   Actuellement, la clinique utilise des systèmes manuels (dossiers papier, fichiers Excel) pour gérer :

Enregistrer, modifier ou supprimer une consultation,

Gérer les disponibilités des médecins, 

Stocker les historiques médicaux des patients, 

Les dossiers patients,

  Cela entraîne :

✅ Des erreurs humaines (doublons, perte de données).

✅ Une perte de temps dans la recherche d'informations.

✅ Une difficulté à générer des rapports et des statistiques (nombre de consultations par médecin/spécialité, suivi des patients).


## 🎯 Objectifs

  L'application aura pour but de :

✔ Numériser la gestion des patients (création, modification, consultation).

✔ Sécuriser les données (accès par rôles : administrateur, médecin).

✔ Générer des statistiques (fréquentation, revenus, diagnostics fréquents).

## 📚 Explication rapide des packages

config : Fichier de configuration Hibernate (connexion DB)

dao : Accès aux données (CRUD) via Hibernate

entities : Tes classes @Entity (Patient, Médecin, Consultation, User)

util : Classe utilitaire (HibernateUtil)

test : Scripts pour créer des objets de test


## 📊 Diagramme de Classe

![image](https://github.com/user-attachments/assets/0883da4c-258b-44cf-be2b-130fea7eff8c)


## 🗂️ Modèle conceptuel de la base généré

![image](https://github.com/user-attachments/assets/126d87f9-2869-457e-9e4d-27c0f7718aa3)


## 🖥️ Exécution des tests dans la console

![image](https://github.com/user-attachments/assets/25a0a4c0-08bb-4c9d-9aac-7acfd72ac7a1)


![image](https://github.com/user-attachments/assets/14abad52-8859-42ca-b6b1-3440458f53de)


![image](https://github.com/user-attachments/assets/62a105cd-cfa0-4254-867f-bc822f52d9f7)


![image](https://github.com/user-attachments/assets/84f5dbb6-19f8-4847-af30-f27a959eea63)


![image](https://github.com/user-attachments/assets/026323ca-6dcd-4d44-91c4-4d4430f11a57)


![image](https://github.com/user-attachments/assets/3c6fc168-5306-481c-9268-7d9dda7deff5)


![image](https://github.com/user-attachments/assets/67a1eade-8607-4034-b641-f2eb1d88e0fd)


## 🎥 Démonstration

https://github.com/user-attachments/assets/3a3a3baa-a2b0-47ec-ba7a-62b6f17587dc

