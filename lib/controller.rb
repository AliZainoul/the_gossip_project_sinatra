require 'gossip'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new("#{params["gossip_author"]}","#{params["gossip_content"]}").save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {gossips: Gossip.find(params["id"]), id: params["id"]}
  end

  get '/gossips/:id/edit/' do # Edition page of the gossip
    gossip = Gossip.find(params[:id])
    erb :edit, locals: {id: params[:id], gossip: gossip}
  end

  post '/gossips/:id/edit/' do # Send the edition
    gossip = Gossip.find(params[:id])
    gossip.update(params['gossip_author'], params['gossip_content'],params[:id])
    redirect '/'
  end

end
