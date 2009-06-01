namespace :radiant do
  namespace :extensions do
    namespace :no_peeking do
      
      desc "Runs the migration of the No Peeking extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          NoPeekingExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          NoPeekingExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the No Peeking to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[NoPeekingExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(NoPeekingExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
