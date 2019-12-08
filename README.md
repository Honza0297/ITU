[CZ]

Projekt do predmětu ITU - Aplikace pro spravu ukolu metodou GTD
Autori: 
* Jan Beran (xberan43)
* Daniel Bubenicek (xbuben05)
* Jan Carba (xcarba00)

Poznamky:
* Doporucujeme spoustet na systemu Windows, podporovany jsou ovsem i linuxove systemy (zde se ovsem mohou vyskytnout problemy s Andorid Studiem)
* Krome autorskych souboru (ve slozce lib/) jsou odevzdany i soubory potrebne pro spravne otevreni v Android Studiu. Zprovozneni aplikace jen s pomoci zdrojovych kodu by bylo mnohem slozitejsi (neexistuje jednoduchy zpusob jak vytvorit projekt z jiz existujicich souboru) a nemohly by zde byt popsany vsechny potencialni problemy, ktere by mohly vzniknout. 

# Postup zprovozneni
* Stahnete si Android Studio a plugin Flutter (Skvele je to popsano na oficialnich strankach Flutteru, zde bych pouze kopiroval jejich postup: https://flutter.dev/docs/get-started/install)
* V Android Studiu otevrete slozku s odevzdanymi soubory pres moznost "File -> Open project"
* Mozna se vam v horni casti obrazovky zobrazi modry pruh s pozadavkem na instalaci "Flutter SDK". Ucinte tak.
* Kliknete na soubor pubspec.yaml a stahnete vsechny potrebne balicky (vpravo nahore tlacitko "Get packages", muze se lehce lisit vzhledem k systemu a verzi)
* Pokud jste si behem instalace nevytvorili virtualni zarizeni, ucinnte tak kliknutim na ikonu "AVD Manager" vpravo nahore. Zde si pote nakonfigurujte vlastni zarizeni (podrobny postup v pripade problemu je k dispozici napriklad zde: https://developer.android.com/studio/run/managing-avds)
* Spustte projekt kliknutim na tlacitko "Run" nebo klavesovou zkratkou "Shift+F10".


####################################################################################
[EN]

Project for ITU, FIT BUT Brno

Authors: Jan Beran, Daniel Bubeníček, Jan Carba (see the file headers for more specific info)

Notes:
* We recommend to use Windows, however, linux systems are also supported (some problems with Android Studio may occur)
* There are attached all files needed to open the whole solution as an Android Studio project, not only the source codes. The reason is that there is no option to "Make a project from existing files" in Android Studio. Source code files can be found in lib/ folder

# How to get things working:
* Download Android Studio and install Flutter plugin (There is great tutorial by FLutter: https://flutter.dev/docs/get-started/install)
* Open the folder with attached files by clicking "File -> Open project"
* Maybe, You will need to install Flutter SDK - blue bar will apper on the top part of the screen.
* Click on pubspec.yaml file and download all neccessary packages (yellow bar will appear in the top part of the screen. Click on "Packages Get" or similar - in may vary in different versions and systems)
* If you did not created your virtual device, do it now (you can use this tutorial: https://developer.android.com/studio/run/managing-avds)
* Run the project by clicking "Run" or "Shift + F10"

## Using git repository (easy and fast):
* Download Android Studio and install Flutter plugin (There is great tutorial by FLutter: https://flutter.dev/docs/get-started/install)
* Clone git repository: https://github.com/Honza0297/ITU.git
* Open it as a project in Android Studio
* Click on pubspec.yaml, In the top of the screeen, yellow bar shows up. Click on "Packages get" or similar (may be slightly different in various sstems and versions). 
* If you do not have any, make your virtual device: click on "AVD Manager" icon (close to "Run, Debug, Stop" buttons), create and run your virtual device
* Then just Run the project
