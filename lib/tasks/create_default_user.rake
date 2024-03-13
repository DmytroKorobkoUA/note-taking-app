# frozen_string_literal: true

namespace :users do
  desc "Create default user if not exists"
  task create_default: :environment do
    if User.exists?(username: 'admin')
      puts "Default user 'admin' already exists."
    else
      User.create!(
        username: 'admin',
        email: 'admin@user.com',
        password: 'StrongPassword!',
        password_confirmation: 'StrongPassword!'
      )
      puts "Default user 'admin' created successfully."
    end
  end
end
