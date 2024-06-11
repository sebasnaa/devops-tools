#!/bin/bash

# Variables
REPO_NAME="just-for-test"

REPO_URL="https://github.com/sabreu-stemdo/$REPO_NAME"
BRANCH="dev"
COMMIT_MESSAGE="add CODEOWNERS"

git clone $REPO_URL

cd $REPO_NAME


git checkout $BRANCH

cd ..
cp -r .github $REPO_NAME
cd $REPO_NAME


git add .

git commit -m "$COMMIT_MESSAGE"

git push origin $BRANCH


