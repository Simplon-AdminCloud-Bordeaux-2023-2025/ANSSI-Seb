# ANSSI-Seb

sudo apt install python3.10-venv
python3 -m venv .venv

### 3- Lancement d'Ansible 
dans un premier temps, il faut se déplacer dans le dossier **ansible** avant de lancer les commandes ci-dessous
>cd ansible

Se placer dans un environnement virtuel pour installer **Ansible** et tous les modules si nécessaire

    virtualenv b1e3
_________
    source b1e3/bin/activate

  #### *Si Ansible n'est pas installé :*

  Vérifier d'abord la version de python et
  installer ensuite **Ansible** avec la commande ci-après :

    pip3 install ansible
    
Quand **Ansible** est installé, on lance les playbooks pour les configurations suivantes :

>Installation de la VM Bastion

    ansible-playbook install-appli.yml -i inventaire.ini

ansible-galaxy install -r requirements.yml --force -p roles/

ansible -i inventaire.ini -m ping appli




sudo yum -y install openscap-scanner

sudo yum -y install scap-security-guide

oscap info "/usr/share/xml/scap/ssg/content/ssg-rhel8-xccdf.xml"

oscap info --profile xccdf_org.ssgproject.content_profile_anssi_bp28_minimal /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml

oscap xccdf eval --profile PROFILE_ID --results-arf ARF_FILE --report REPORT_FILE SOURCE_DATA_STREAM_FILE

oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_anssi_bp28_intermediary --results-arf results.xml --report report.html /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml

oscap xccdf remediate --results remediation-results.xml results.xml