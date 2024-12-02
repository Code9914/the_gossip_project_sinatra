require 'gossip'
require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    @gossips = Gossip.all
    erb :index
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    @gossip = Gossip.find(params[:id].to_i)
    if @gossip.nil?
      status 404
      return "Potin introuvable.."
    end
    erb :show
  end
end