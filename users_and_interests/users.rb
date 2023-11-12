require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def count_interests(user_hash)
    count = 0
    user_hash.each do |username, info_hash|
      count += info_hash[:interests].count
    end
    count
  end
end

not_found do
  
end

get "/" do
  erb :home
end

get "/:username" do
  @username_from_link = params[:username]

  erb :user
end