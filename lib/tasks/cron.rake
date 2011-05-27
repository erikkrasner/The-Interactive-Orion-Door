desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.day % 7 == 0 # run weekly
    `../../utils/door_scraper.rb`
  end
end