namespace :auth do
  desc "Set the application password (stores BCrypt digest in credentials)"
  task set_password: :environment do
    require "bcrypt"

    print "We need to set a password for authentication in your dev environment. Do so now. 'password' is fine.\n"
    print "New password: "
    system "stty -echo"
    password = $stdin.gets.chomp
    system "stty echo"
    puts

    digest = BCrypt::Password.create(password).to_s
    raw = Rails.application.credentials.read rescue ""
    config = YAML.safe_load(raw) || {}
    config["password_digest"] = digest
    Rails.application.credentials.write(config.to_yaml)

    puts "Password set."
  end
end
