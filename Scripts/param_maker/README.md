# param_maker

![GitHub stars](https://img.shields.io/github/stars/amins-m/Hunt)
![GitHub forks](https://img.shields.io/github/forks/amins-m/Hunt)
![GitHub issues](https://img.shields.io/github/issues/amins-m/Hunt)
![GitHub license](https://img.shields.io/github/license/amins-m/Hunt)

## Description
param_maker is a tool for making parameters based on URLs and testing them on the target 

## Table of Contents
- [SettingUp](#SettingUp)
- [Usage](#usage)
- [Contact](#contact)

## SettingUp
```sh
#Change to the project directory
cd param_maker
#Make the file executable 
chmod +x param_maker.sh
#Making file available every time
nano ~/.zshrc
#Add the following line to the bottom of the ~/.zshrc file 
source [your path to script]/param_maker.sh
#save the file and exit(ctrl+x -> y -> Enter)
#run the following command in your terminal
source ~/.zshrc  #or source ~/.bashrc  (if you are using bashrc)
```

## Usage
```sh
cat site.com.urls | param_maker
```

## Contact
Maintainer: [aminsm](https://github.com/amins-m)  


