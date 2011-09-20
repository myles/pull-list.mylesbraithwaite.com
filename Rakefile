require 'rake/clean'

task :default => :server

desc 'Star server with --auto'
task :server do
	jekyll('--server --auto')
end

task :clean do
	CLEAN.include('_site/**')
	rmtree CLEAN
end

desc 'Build site with Jekyll'
task :build => :clean do
	sh 'rm -fr _site/*'
	jekyll('')
end

desc "Deploy"
task :deploy => :build do
	s3cmd "s3://pull-list.mylesbraithwaite.com"
end

def s3cmd(location)
	sh "s3cmd sync --acl-public --delete-removed _site/ #{location}/"
end

def rsync(location)
	sh "rsync -rtzh --progress --delete _site/ #{location}/"
end

def jekyll(opts='')
	sh 'jekyll ' + opts
end