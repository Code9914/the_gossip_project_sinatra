require 'csv'

class Gossip
  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    gossips = []
    CSV.foreach("./db/gossip.csv") do |row|
      gossips << { author: row[0], content: row[1] }
    end
    gossips
  end

  def self.find(id)
    gossips = CSV.read("./db/gossip.csv")
    return nil if id <= 0 || id > gossips.size
    gossips[id - 1]
  end
end