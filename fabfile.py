from fabric.decorators import task
from fabric.contrib.project import rsync_project
from fabric.api import abort, cd, env, get, hide, hosts, local, prompt, \
	put, require, roles, run, runs_once, settings, show, sudo, warn

@task
def server():
	jekyll('--server --auto')

def clean():
	local('rm -fr _site/*')

@task
def build():
	clean()
	jekyll('')

@task
def deploy():
	build()
	s3cmd("s3://pull-list.mylesbraithwaite.com")
	rsync_project(remote_dir="/srv/www/com_mylesbraithwaite_pull-list/html",
		local_dir="./_site/", delete=True)

def jekyll(opts=''):
	local('jekyll ' + opts)

def s3cmd(location):
	local("s3cmd sync --acl-public --delete-removed _site/ %s/" % location)