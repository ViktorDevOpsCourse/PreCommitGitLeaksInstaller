#!/bin/bash

VERSION="v8.18.1"
TMP_FOLDER=gitleaks_tmp
FOLDER="gitleaks-8.18.1"
ARCHIVE="$FOLDER.zip"
REPO_URL="https://github.com//gitleaks/gitleaks/archive/refs/tags/$VERSION.zip"

install_GitLeaks(){

  curl -sSLJO "$REPO_URL"

  unzip -q $ARCHIVE \
  && cd $FOLDER && make build

  if mkdir -p "../../bin"; then
    if [ -f "./gitleaks" ]; then
       mv "./gitleaks" "../../bin/"
      echo "Success installed: gitleaks"
    else
      echo "Some error occurred while gitleaks installing"
    fi
  else
    echo "Error create a bin folder"
  fi

  cd ../ || exit
}

install_PreCommit(){
  git clone https://github.com/ViktorDevOpsCourse/preCommitGitLeaksInstaller.git
  cd ./preCommitGitLeaksInstaller && go build -o pre-commit ./cli
  if [ -f "../../.git/hooks/pre-commit" ]; then
      echo "You already using pre-commit hook"
      echo "Do you want overwrite it [yes|no]: "
      read -r adjustment
      if [[ "$adjustment" == "yes" ]]; then
          move_PreCommit
      else
        cd ../ || exit
      fi
  else
      move_PreCommit
  fi

}

move_PreCommit(){
  mv "./pre-commit" "../../.git/hooks/"
  cd ../ || exit
}

cleanUp() {
  cd ../ || exit
  rm -rf $TMP_FOLDER
}

if mkdir -p $TMP_FOLDER; then
  echo "tmp folder success created"
  cd "./$TMP_FOLDER" || exit
else
  echo "Failed create $TMP_FOLDER folder"
fi

echo "install gitleaks"
install_GitLeaks

echo "install pre-commit"
install_PreCommit

git config hooks.gitleaks true

echo "clean up"
cleanUp


