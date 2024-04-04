# ANSSI-Seb

### 1- Installer l'environnement virtuel

se place dans le dossier Ansible pour créer l'environnement virtuel 

    cd Ansible

    sudo apt install python3.10-venv

    python3 -m venv .venv

### 2- Entrer dans l'environnement virtuel

    source .venv/bin/activate

### 3- Installation d'Ansible  

    pip3 install ansible
ou

    python3 -m pip install ansible

### 4- Chargement du rôle ANSSI-RECOM pour Ansible 

    ansible-galaxy install -r requirements.yml --force -p roles/ 

Vérifier le fichier main.yml dans le dossier /roles/anssi-recom/tasks et modifier la ligne suivant le niveau de criticité choisi   

### 5- Déploiement via Terraform

se déplacer dans le dossier Terraform

__BACKEND__

    cd ../Terraform/backend

    terraform init

    terraform apply

__VM RedHat__

    cd ../anssi

    terraform init

    terraform apply


Terraform lance un playbook Ansible qui 
   - met à jour les dépots de la VM, 
   - installe OpenSCAP,
   - corrige les vulnérabilités avec le rôle ANSSI-RECOM téléchargé précédemment 

La connexion ssh est donnée par un output terraform


### 6- Evaluation avec OpenSCAP

se déplacer dans le dossier Ansible

    cd ../../Ansible

Pour faire une évaluation :

__Il faut modifier la variable "oscap_level" dans le fichier run_scap.yml afin de choisir le niveau d'évaluation__

    ansible-playbook run_scap.yml -i inventaire.ini

Un rapport est généré dans le dossier /oscap-reports

Suite ça, il est possible de créer un playbook avec toutes les vulnérabilités :

__Il faut modifier la variable "oscap_level" dans le fichier remediation_create_playbook.yml afin de choisir le niveau d'évaluation__

    ansible-playbook remediation_create_playbook.yml -i inventaire.ini

Un playbook est généré dans le dossier /oscap-reports



Pour info, quelques commandes 

- pour lister les profils sur la VM oscap

    oscap info "/usr/share/xml/scap/ssg/content/ssg-rhel8-xccdf.xml"

- pour lancer un ping via Ansible

    ansible -i inventaire.ini -m ping appli
