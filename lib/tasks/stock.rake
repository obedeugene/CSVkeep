namespace :stock do
  desc "Import CSV"
  task :import, [:filename] => :environment do    

 require	'csv'

  CSV.foreach(filename, headers: true) do |row|
    stock = find_by_id(row["id"]) || new
    stock.attributes = row.to_hash.slice(*accessible_attributes)
    stock.save!
    end
   end
 end  
 
  desc "Export to JSON"
  task :export => :environment do    

  require 'csv'
  require 'json'

    CSV.generate do |csv|
      data = Array.new
      data << column_names
      Stock.all.each do |stock|
        data << stock.attributes.values_at(*column_names)   
        puts JSON.pretty_generate(data)
   end
   end  
  end
end
