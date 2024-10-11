#!/bin/sh

# Backend setup
printf "\e[1;35mSETUP: BACKEND\e[0m\n"
source backend.sh
source backendAuth.sh
source backendEnv.sh

printf "\e[1;35m                \e[0m\n"
printf "\e[1;35m----------------\e[0m\n"
printf "\e[1;35m                \e[0m\n"

# Frontend setup
printf "\e[1;35mSETUP: FRONTEND\e[0m\n"
source frontend.sh
source frontendAuth.sh
source frontendEnv.sh

printf "\e[1;35m                \e[0m\n"
printf "\e[1;35m----------------\e[0m\n"
printf "\e[1;35m                \e[0m\n"
printf "\e[1;35m SETUP COMPLETE \e[0m\n"
printf "\e[1;35m                \e[0m\n"
printf "\e[1;35m----------------\e[0m\n"
printf "\e[1;35m                \e[0m\n"
