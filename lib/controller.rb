require 'gossip'
require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base

  # Route pour afficher la page d'accueil
  get '/' do
    @gossips = Gossip.all # Récupère tous les potins à partir du fichier CSV
    erb :index # Rend la vue `index.erb` avec les potins
  end

  # Route pour afficher le formulaire de création d'un nouveau potin
  get '/gossips/new/' do
    erb :new_gossip # Rend la vue `new_gossip.erb` contenant le formulaire
  end

  # Route pour gérer la soumission du formulaire de création d'un potin
  post '/gossips/new/' do
    # Crée un nouveau potin avec les données du formulaire (auteur et contenu)
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/' # Redirige l'utilisateur vers la page d'accueil après sauvegarde
  end

  # Route dynamique pour afficher un potin spécifique par son ID
  get '/gossips/:id' do
    @gossip = Gossip.find(params[:id].to_i) # Cherche le potin avec l'ID donné
    if @gossip.nil? # Si le potin n'est pas trouvé
      status 404 # Répond avec un statut HTTP 404 (non trouvé)
      return "Potin introuvable.." # Affiche un message d'erreur simple
    end
    erb :show # Rend la vue `show.erb` pour afficher le potin trouvé
  end
end