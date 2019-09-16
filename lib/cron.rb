require 'json'
require 'fileutils'
class Cron
    def save_messages
        FileUtils.mkdir_p "crons/"  unless File.exists?("crons/")
    end
    def self.create_cron(cron)
        puts
    end
end