

function build4git {
    cp _.config.content.yml _config.yml
    echo "deploy: \\n
  type: git \\n
  repository: git@github.com:wfsovereign/wfsovereign.github.io.git \\n
  branch: master" >> _config.yml
  hexo d -g
  rm ./_config.yml
  echo "deploy done"
}

function build4heroku {
    cp _.config.content.yml _config.yml
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
