# Utiliser l'image de base contenant Flutter et Dart
FROM ghcr.io/cirruslabs/flutter:3.16.5

# Créer et définir le répertoire de travail
WORKDIR /app

# Copier le fichier pubspec.yaml et le fichier pubspec.lock pour résoudre les dépendances avant de copier le reste du code
COPY pubspec.yaml pubspec.lock ./

# Installer les dépendances du projet
RUN flutter pub get

# Copier le reste du code dans le conteneur
COPY . .

# Build de l'application Flutter en mode release
RUN flutter build web

# Configuration pour exécuter l'application en utilisant un serveur web simple (par exemple, nginx)
FROM nginx:alpine

# Copier le contenu du build Flutter dans le répertoire du serveur web
COPY --from=0 /app/build/web /usr/share/nginx/html

# Exposer le port 80 (par défaut pour HTTP)
EXPOSE 80

# Commande pour démarrer le serveur nginx
CMD ["nginx", "-g", "daemon off;"]
