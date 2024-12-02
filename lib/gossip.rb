require 'csv'

class Gossip
  attr_reader :author, :content # Permet de lire les attributs `author` et `content`

  # Initialise un potin avec un auteur et un contenu
  def initialize(author, content)
    @author = author  # Stocke l'auteur du potin
    @content = content # Stocke le contenu du potin
  end

  # Enregistre un potin dans le fichier CSV
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv| # Ouvre le fichier CSV en mode ajout ("ab")
      csv << [author, content] # Ajoute une ligne avec l'auteur et le contenu
    end
  end

  # Récupère tous les potins enregistrés dans le fichier CSV
  def self.all
    gossips = [] # Initialise une liste vide pour stocker les potins
    CSV.foreach("./db/gossip.csv") do |row| # Parcourt chaque ligne du fichier CSV
      gossips << { author: row[0], content: row[1] } # Ajoute un potin sous forme de hash
    end
    gossips # Retourne la liste des potins
  end

  # Trouve un potin spécifique par son ID
  def self.find(id)
    gossips = CSV.read("./db/gossip.csv") # Lit tout le fichier CSV et stocke les lignes dans un tableau
    return nil if id <= 0 || id > gossips.size # Vérifie si l'ID est invalide (en dehors de la plage existante)
    gossips[id - 1] # Retourne le potin correspondant (les indices commencent à 0, donc on soustrait 1)
  end
end