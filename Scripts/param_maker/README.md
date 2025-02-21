# param_maker

![GitHub stars](https://img.shields.io/github/stars/amins-m/Hunt)
![GitHub forks](https://img.shields.io/github/forks/amins-m/Hunt)
![GitHub issues](https://img.shields.io/github/issues/amins-m/Hunt)
![GitHub license](https://img.shields.io/github/license/amins-m/Hunt)

## Description
param_maker is a tool for making parametrs based on urls and testing them on target 

## Table of Contents
- [Installation](#SettingUp)
- [Usage](#usage)
- [Contact](#contact)

## SettingUp
```sh
#Change to the project directory
cd param_maker
#Make the file executable 
chmod +x param_maker.sh
#Making file avalable every time
nano ~/.zshrc
#Add the following line to the pottom of the ~/.zshrc file 
source [path to your script]/param_maker.sh
#save the file and exit(ctrl+x -> y -> Enter)
#run the following command in your terminal
source ~/.zshrc  #or source ~/.bashrc  (if you are using bashrc)
```

## Usage
```sh
cat site.com.urls | param_maker
```

## Contact
Maintainer: [Your Name](https://github.com/amins-m)  


