
if ENV['TARGET'].nil? || ENV['USER'].nil? || ENV['NODE'].nil?
  puts "Please specify target 'TARGET=<remote_host>', e.g. 'TARGET=10.0.0.3'\n" if ENV['TARGET'].nil?
  puts "Please specify user 'USER=<user>', e.g. 'USER=root'\n" if ENV['USER'].nil?
  puts "Please specify node 'NODE=<node>', e.g. 'NODE=default'\n" if ENV['NODE'].nil?
  puts ""
  exit
end

role :target, "#{ENV['USER']}@#{ENV['TARGET']}"
set :stage, :production

cwd = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
capbash_dir = '/var/capbash'

namespace :capbash do

  desc "Deploy to your server"
  task :deploy do
    invoke 'capbash:install_rsync'
    invoke 'capbash:sync'
    invoke 'capbash:install_node'
  end

  desc "Install Cookbook Repository from cwd"
  task :install_rsync do
    on roles(:target), in: :sequence, wait: 1 do
      execute 'aptitude install -y rsync' unless test("which rsync")
      execute "mkdir -m 0775 -p #{capbash_dir}" if test("[ ! -e #{capbash_dir} ]")
    end
  end

  desc "Re-install Cookbook Repository from cwd"
  task :sync do
    run_locally do
      execute "rsync -avz --delete -e \"ssh -p22\" \"#{cwd}/\" \"#{ENV['USER']}@#{ENV["TARGET"]}:#{capbash_dir}\" --exclude \".svn\" --exclude \".git\""
    end
  end

  task :install_node do
    on roles(:target), in: :sequence, wait: 1 do
      execute "cd #{capbash_dir} && ./nodes/#{ENV['NODE']}"
    end
  end

  desc "Remove all traces of capbash"
  task :cleanup do
    on roles(:target), in: :sequence, wait: 1 do
      execute "rm -rf #{capbash_dir}"
    end
  end

end
