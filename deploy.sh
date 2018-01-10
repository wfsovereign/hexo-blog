#!/usr/bin/env bash

function prepareBuild {
    cp _config.content.yml _config.yml
}

function getDeployString () {
    deployType=$1
    repo=$2
    branch=$3

    deployString="deploy: \\n
        type: ${deployType} \\n
        repo: ${repo} "
    branchLength=${#branch}

    if [ $branchLength -gt  0 ]
    then
        deployString="$deployString \\n
       	branch: $branch"
    fi

     echo $deployString
}

function build4git {
    prepareBuild
     echo "deploy: \\n
  type: git \\n
  repository: git@github.com:wfsovereign/wfsovereign.github.io.git \\n
  branch: master" >> _config.yml
  hexo d -g
  rm ./_config.yml
    echo "deploy done"
}

function build4heroku {
    prepareBuild
    echo "deploy: \\n
  type: heroku \\n
  repository: https://git.heroku.com/wfsovereign-blog.git" >> _config.yml
  hexo d -g
  rm ./_config.yml
  echo "deploy done"
}


echo "env ------"
echo $1

case $1 in
	git)
		build4git
		;;
    heroku)
        build4heroku
    ;;
	*)
	    echo "no match"
		exit -1
esac
