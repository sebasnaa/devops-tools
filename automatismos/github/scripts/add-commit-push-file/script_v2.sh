#!/bin/bash

# Variables
REPO_URL="https://github.com/tu_usuario/tu_repositorio.git"
CLONE_DIR="nombre_del_directorio_clonado"
COMMIT_MESSAGE="Tu mensaje de commit"

# Clonar el repositorio
git clone $REPO_URL $CLONE_DIR

# Moverse al directorio del repositorio clonado
cd $CLONE_DIR 

# Obtener la lista de ramas
BRANCHES=$(gh repo view --json refs --jq '.refs | map(select(.name | startswith("refs/heads/")) | .name | ltrimstr("refs/heads/"))')

# Convertir la lista de ramas en un array de bash
BRANCH_ARRAY=($(echo $BRANCHES | jq -r '.[]'))

# Iterar sobre cada rama
for BRANCH in "${BRANCH_ARRAY[@]}"; do
  echo "Procesando rama: $BRANCH"
  
  # Cambiar a la rama
  git checkout $BRANCH
  
  # Volver al directorio principal y copiar la carpeta .github
  cd ..
  cp -r .github $CLONE_DIR
  cd $CLONE_DIR
  
  # Agregar los cambios
  git add .
  
  # Realizar el commit
  git commit -m "$COMMIT_MESSAGE"
  
  # Hacer push a la rama
  git push origin $BRANCH
done

echo "Script completado."
