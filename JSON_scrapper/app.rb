require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'
require 'json'

email_hash = GetEmails.new("http://annuaire-des-mairies.com/val-d-oise.html").create_list

File.open("db/email.json","w") do |f|
  f.write(email_hash.to_json)
end