desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.day % 7 == 0 and Time.now.hour == 6 # run weekly
  end
end