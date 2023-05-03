source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem 'dotenv-rails', groups: [:development, :test]

gem "bootsnap", require: false
gem "config", "~> 4.1"
gem "mailgun-ruby", "~> 1.2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "twilio-ruby", "~> 5.77"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end
