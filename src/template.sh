#!/bin/bash


######## DIRECTORY CONFIG
local clone_link="https://gitlab.digitro.com.br/ARQ/together.git"
local clone_dir="/home/digitro/Desenvolvimento"
local new_branch="0"                        #1/0
local destination_branch="develop"          #only new_branch=1
local branch="develop"
local remote="origin"
local gitgroup="jonathadf-projects"

######## AUTENTICATION
local email=""
local username=""
local password=""

######## COMANDS
local status="1" 				            #1/0
local add="1" 				                #1/0
local commit="1" 				            #1/0
local text_commit="teste" 			        #only commit=1
local push="1" 				                #1/0

####### CONFIG
local ignore_certificate="1" 		        #1/0


projects_list=(
    https://gitlab.digitro.com.br/jonathadf-projects/cicd/templates.git

    https://gitlab.digitro.com.br/jonathadf-projects/projects/repos/digitro-repos.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/repos/repos.git

    https://gitlab.digitro.com.br/jonathadf-projects/hellowords/bello.git
    https://gitlab.digitro.com.br/jonathadf-projects/hellowords/cello.git
    https://gitlab.digitro.com.br/jonathadf-projects/hellowords/pello.git

    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-digitro-ip09-f2.4.13.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x1sg-f2.4.8.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x1sp-f2.4.5.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x2cp-f2.12.0.7275.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x2p-f2.14.0.7386.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x3sg-f2.4.8.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x3u-f2.0.2.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x4g-f2.12.0.7275.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x4u-f2.4.4.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x6-f2.0.2.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x7c-f2.4.2.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-fanvil-x7-f2.4.2.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-intelbras-ata200-f74.19.10.28.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-intelbras-gw208o-f74.81.10.26.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-intelbras-gw232s-f74.81.10.26.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-intelbras-v3501-f2.2.20.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-khomp-umg300-2gsm-2gsm-2gsm-f3.0.40.0.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-khomp-umg300-30e1-2gsm-2gsm-f3.0.40.0.git
    https://gitlab.digitro.com.br/jonathadf-projects/projects/pfg/pfg-khomp-umgserver-30e1-f3.0.40.0.git

    https://gitlab.digitro.com.br/jonathadf-projects/projects/jasterisk.git
	https://gitlab.digitro.com.br/jonathadf-projects/dependencies/iksemel.git
	https://gitlab.digitro.com.br/jonathadf-projects/dependencies/speex.git
	https://gitlab.digitro.com.br/jonathadf-projects/dependencies/speexdsp.git
	https://gitlab.digitro.com.br/jonathadf-projects/dependencies/uw-imap.git
)
