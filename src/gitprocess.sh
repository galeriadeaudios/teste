#!/bin/bash

set -e
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

########################################################
function clone(){
	
	if [ "${ignore_certificate}" = "yes" ]; then
		nocert="GIT_SSL_NO_VERIFY=true"
	fi
	
	first_link="${clone_link%gitlab*}"
	last_link="${clone_link#https://}"
	if [ -d "${clone_dir}" ]; then
		echo "ok"
	else
		mkdir -p "${clone_dir}"
	fi

	if [ "${username}" = "" -o "${email}" = "" ]; then
		echo "[ERRO] insira o nome de usuario e email no template"
		exit 1
	else
		eval cd "${clone_dir}"

		if [ "${ignore_certificate}" = "yes" ]; then
			eval "${nocert} git clone ${first_link}${username}:${password}@${last_link}"
	 	elif [ "${ignore_certificate}" = "no" ]; then
			eval "git clone ${first_link}${username}:${password}@${last_link}"
		fi
		cd "${project_name}"
		eval "git config --global --add safe.directory ."
		if [ "${create_branch}" = "yes" ]; then
			local checkout='git checkout -b "${branch}" "${destination_branch}"'
			eval "${checkout}"
		elif [ "${create_branch}" = "no" ]; then
			local checkout='git checkout "${branch}"'
			eval "${checkout}"
		fi
		echo "Clonando em: ${clone_dir}/${project_name}" 
	fi

}

function template(){
	nano "${PARENT_PATH}"/template.sh
}

function push(){

	cd "${clone_dir}/${project_name}"
	if [ "${ignore_certificate}" = "yes" ]; then
		${nocert} git push --set-upstream ${remote} ${branch}
	elif [ "${ignore_certificate}" = "no" ]; then
		git push --set-upstream ${remote} ${branch}
	fi

}

function all(){

echo -e "\nInformations:\n\nproject: ${project_name}\nbranch: ${branch}\nigone_certificate: ${ignore_certificate}\ngit status: ${status}\ngit add: ${add}\nadd certificate: ${add_certificate}\nremote: ${remote}\nsafe dir: ${safe_dir}\nautentication: ${autentication}\n\nConfirm the informations? [yes/no]"
read informations
if [ "${informations}" = "yes" ]; then

	if [ -d "${clone_dir}" ]; then
		echo "diretorio existe"
	else
		mkdir -p "${clone_dir}"
	fi

	cd "${clone_dir}/${project_name}"
	
	if [ "${ignore_certificate}" = "yes" ]; then
		nocert="GIT_SSL_NO_VERIFY=true"
	fi

	if [ "${status}" = "yes" ]; then
		git status
	fi

	if [ "${add}" = "yes" ]; then
		git add .
	fi

	if [ "${status}" = "yes" ]; then
		git status
	fi

	if [ "${commit}" = "yes" ]; then
		if [ "${ignore_certificate}" = "yes" ]; then
			eval "${nocert} git commit -m \"${text_commit}\""
		elif [ "${ignore_certificate}" = "no" ]; then
			eval "git commit -m \"${text_commit}\""
		fi
	fi

	if [ "${push}" = "yes" ]; then
		if [ "${ignore_certificate}" = "yes" ]; then
			eval "${nocert} git push --set-upstream ${remote} ${branch}"
		elif [ "${ignore_certificate}" = "no" ]; then
			eval "git push --set-upstream ${remote} ${branch}"
		fi
	fi
else
	echo "saindo..."
	exit 1
fi
}

function dgtcertificate(){
	eval "curl https://icp.digitro.com.br/pki/pub/cacert/cacert.crt > /etc/ssl/certs/digitro-cacert.crt"
	eval "git config --global http.sslCAInfo /etc/ssl/certs/digitro-cacert.crt"
}

function autentication(){
	git config --global user.name \"${username}\"
	git config --global user.email \"${email}\"
}

function safedir(){
	git config --global --add safe.directory \""${clone_dir}"/"${project_name}"\"
}

function pull(){
	if [ "${ignore_certificate}" = "yes" ]; then
		eval "${nocert} git pull ${remote} ${branch}"
	elif [ "${ignore_certificate}" = "no" ]; then
		eval "git pull ${remote} ${branch}"
	fi
}

function list(){
	for f in "${projects_list[@]}"; do
		projectfolder="${f##*"${gitgroup}/"}"
		projectfolder="${gitgroup}/${projectfolder%/*}"
		projectname="${f##*/}"
		projectname="${projectname%.*}"

		echo "--> ${projectfolder} - ${projectname}"

		cd "${gitfolder}" || exit
		mkdir -p "${projectfolder}"
		cd "${projectfolder}" || exit
		# rm -Rf "${projectname}"
		cd "${projectname}" || { git clone "${f%%gitlab.*}<USUARIO>:<SENHA>@${f##*//}"; cd "${projectname}" || exit; }
		git pull
		git checkout develop
		# git checkout -b develop main
		# cp -r "${gitfolder}/new_bkp/${projectname}/src" .
		# cp "${gitfolder}/${projectfolder}/pfg-digitro-ip09-f2.4.13/"* .
		# cp "${gitfolder}/${projectfolder}/pfg-digitro-ip09-f2.4.13/.gitlab-ci.yml" .
		# sed -i "s/pfg-digitro-ip09-f2.4.13/${projectname}/" README.md
		# git add .
		# git commit -a -m "Ajustes README."
		# git push --set-upstream origin develop
		# git push	
	done
}

function help(){
	echo ""
	echo " gitprocess <param>"
	echo " -t      ---->      template"
	echo " -c      ---->      git clone"
	echo " -all    ---->      git add/commit/push"
	echo " -push   ---->      git push"
	echo " -pull   ---->      git pull"
	echo " -d      ---->      add Dígitro certificate"
	echo " -a      ---->      autentication (git config --global user.name...)"
	echo " -s      ---->      safe dir (add safe.directory)"
	echo " -h      ---->      help"
}


main() {
	PARAM="$1"
	source "${PARENT_PATH}/template.sh"
	project_name=$(echo "$clone_link" | sed 's/.*\/\([^\/]*\)\.git$/\1/')
	if [ "${PARAM}" = "-h" ]; then
		help
	elif [ "${PARAM}" = "-c" ]; then
		clone
	elif [ "${PARAM}" = "-t" ]; then
		template
	elif [ "${PARAM}" = "-all" ]; then
		all
	elif [ "${PARAM}" = "-push" ]; then
		push
	elif [ "${PARAM}" = "-pull" ]; then
		pull
	elif [ "${PARAM}" = "-d" ]; then
		dgtcertificate
	elif [ "${PARAM}" = "-a" ]; then
		autentication
	elif [ "${PARAM}" = "-s" ]; then
		safedir
	else
		help
	fi

}

main "${@}"
