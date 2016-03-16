# screenrecord

Outil de _Screen Recording_ pour le BreizhCamp et autres meetup
à installer sur un disque USB branché sur le PC de présentation
utilise ffmpeg/vlc pour faire une capture a faible débit et faible utilisation CPU


## Objectifs

* capture propre de la présentation telle qu'elle apparaît sur l'écran de projection (aka: '_pas de webcam qui filme l'écran_')
* aussi peu intrusif que possible sur la machine du présentateur
* simple, plug'n play - nous enchaînons 10 confs pendant 3 jours sur 4 salles, hors de question de perdre 15 minutes en setup vidéo à chaque fois.
* libre et gratuit


## How To

* Connecter le disque USB au PC du présentateur, connecté au vidéo-projecteur
* Lancer `record`


## Setup des disques USB

* faire un git clone 


NB: le script `build.sh` permet de récupérer les binaires statiques utilisés pour la capture, il n'est pas nécessaire autrement que pour maintenir ce repository.