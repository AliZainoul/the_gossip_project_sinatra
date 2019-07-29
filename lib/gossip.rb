require 'csv'

class Gossip
  attr_accessor :author, :content
  def initialize(gossip_author,gossip_content)
    @author = gossip_author.to_s
    @content = gossip_content.to_s
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << ["#{@author}", "\s #{@content}"]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    id = id.to_i
    return self.all[id]
  end

  def update(author, content, id) # Update after an edition of a gossip
      id = id.to_i
      @author = author
      @content = content
      new_file = CSV.read("./db/gossip.csv")
      new_file[id] = [@author, @content]
      CSV.open("./db/gossip.csv", "w") do |csv|
        new_file.each do |line|
          csv << line
        end
      end
  end
end
