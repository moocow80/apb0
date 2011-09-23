namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:first_name => "Admin",
                 :last_name => "0",
                 :email => "admin@apb.org",
                 :password => "000000",
                 :password_confirmation => "000000")
    admin.toggle!(:admin)
    
    admin = User.create!(:first_name => "Jimmy",
                 :last_name => "Kung",
                 :email => "jimmy.kung@apb.org",
                 :password => "000000",
                 :password_confirmation => "000000")
    admin.toggle!(:admin)
    
    example_user = User.create!(:first_name => "Example",
                 :last_name => "User",
                 :email => "example.user@apb.org",
                 :password => "111111",
                 :password_confirmation => "111111")

    99.times do |n|
      first_name  = "FirstN#{n+1}" 
      last_name = "LastN#{n+1}"
      email = "user#{n+1}@apb.org"
      password  = "111111"
      User.create!(:first_name => first_name,
                   :last_name => last_name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    10.times do |m|
        User.all(:limit => 3).each do |user|
            user.microposts.create!(:content => "blah blah blah...#{m+1}")
        end
    end

  end
end

