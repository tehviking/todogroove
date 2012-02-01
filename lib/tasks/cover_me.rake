namespace :cover_me do

  task :report do
    require 'cover_me'
    CoverMe.complete!
  end

  task :all => %w{ rake:spec rake:cucumber report }
  task :spec => %w{ rake:spec report }
  task :cucumber => %w{ rake:cucumber report }

# task :test do
#   Rake::Task['cover_me:report'].invoke
# end

# task :spec do
#   Rake::Task['cover_me:report'].invoke
# end

end

