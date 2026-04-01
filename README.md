# Task 2 - Local Office Communication System

## Objectif
Mise en place d'une infrastructure de communication locale incluant un serveur mail, un partage de fichiers par rôles et une imprimante réseau[cite: 4, 6].

## Réalisations Techniques
### 1. Serveur Mail (hMailServer) 
- Domaine local : `office.local`.
- 5 Comptes utilisateurs : direction, h, 	ech, compta, stagiaire[cite: 8].
- Alias : contact@office.local redirige vers h@office.local[cite: 10].
- Liste de diffusion : ll@office.local inclut tous les membres[cite: 10].
- Limite de taille : 10 Mo par message[cite: 10].

### 2. Partage de Fichiers (SMB) [cite: 11]
- **Public** : Accès total pour "Tout le monde".
- **Direction_Only** : Restreint au groupe local Direction_Group[cite: 14].
- **RH_Only** : Restreint au groupe local RH_Group[cite: 14].

### 3. Imprimante Partagée [cite: 12]
- Imprimante virtuelle Imprimante_Bureau partagée sur le réseau local via le pilote Generic Text[cite: 13].

## Validation
Les tests d'envoi SMTP ont été validés via PowerShell (Send-MailMessage) et les logs hMailServer confirment la mise en file d'attente des messages[cite: 9, 16].
