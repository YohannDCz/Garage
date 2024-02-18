# Garage V. Parrot app

Dans ce projet écrit en Flutter et supplémenté par la library BLoC pour la gestion d'états, nous allons tout d'abord vous infiquer la marche à suivre pour l'éxecution en local.

## Getting Started

Les ressources du projet sont:

- [Le site web du projet](https://yohanndcz.github.io/GarageWeb/)
- [Le design du projet sur FlutterFlow](https://app.flutterflow.io/project/sujet-garage-cv7cee)
- [Le repository GitHub du projet](https://github.com/YohannDCz/Garage)
- [Le projet sur Trello](https://trello.com/b/pUwHk38q/sujetgarage)
- [La gestionnaire base de donnée](https://supabase.com/)


Les étapes de lancement du projet:

1. Télecharger ce repository.
2. Connectez-vous sur Supabase. (Je peut vous donner accès à ma BDD si jamais).
3. Créez un nouveau projet.
4. Dans la console SQL à gauche entrer un a un les éléments de la base de donnée du dossier database/, en commençant par le contenu du fichier 0-shema.sql.
5. Dans Supabase allez dans paramètres puis API, selectionner vorte Projet URL et votre Annon Key et remplacer les dans la fonction main() du fichier main.dart: Supabase.initialize(url: "<VOTRE-URL>", anonKey:  "<VOTRE-ANNON-KEY>");

Le bqckend est prêt ! Vous n'avez plus qu'à passer sur votre IDE !

1. Suivez le guide d'installation de Flutter à [cette adresse](https://docs.flutter.dev/get-started/install).
2. Run `flutter doctor` pour voir si tout est prêt
3. Après cela selectionnez l'appareil sur lequel vous voulez émuler l'application (actuellement un émulateur android, un émulateur iOS ou Chrome vu que l'appli n'a été téstée que sur ces plaformes).
4. Aller sur le fichier main et lancer l'émulateur en cliquant sur la flèche en haut à gauche (sur VS code en tout cas) ou lancer `flutter clean` puis `flutter run` dans la console du terminal (tout IDE).
5. Attendez 2 minutes.
6. C'est prêt ! Maintenant vous pouvez savourer une application bien fluide.
(7.) Si vous voulez accéder au mode administrateur, vous n’avez qu’à rentrer “sujet_garage” dans la clef administrateur lors de l’inscription. Cela créera un profile utilisateur-administrateur.