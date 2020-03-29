namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts "Recriando o database"
    
    %x(rails db:drop db:create db:migrate)
    
    puts "Database recriado com sucesso!!!"
    
    puts "Cadastrando os tipos de caminhões"
    
    trucks = ["Caminhão 3/4", "Caminhão Toco", "Caminhão Truck", "Carreta Simples", "Carreta Eixo Extendido"]
    trucks.each { |truck| Truck.create!(description: truck) }
    puts "Caminhões cadastrados com sucesso"

    puts "Cadastrando Motoristas"
    
    20.times do |i|
      params = {
        name: Faker::Name.name, 
        gender: Faker::Gender.short_binary_type, 
        has_truck: Faker::Boolean.boolean,
        cnh_type: "C",
        age: Faker::Date.birthday(min_age: 20, max_age: 55) 
        }
      driver = Driver.new(params)
      driver.truck = Truck.all.sample if driver.has_truck
      driver.save!
    end
    
    puts "Motoristas cadastrados com sucesso!!!"
    
    puts "Cadastrando Cidades"
    
    cities = %w(Guarulhos Campinas Osasco Sorocaba Mauá Santos Diadema Jundiaí Piracicaba Carapicuíba Taubaté Araras Botucatu Cubatão Valinhos Barretos Paulínia Ubatuba Bebedouro Itupeva)
    cities.each { |city| Location.create!(city: city, state: "São Paulo") }
    
    puts "Cidades cadastradas com sucesso"
    
    puts "Cadastrando viagems"
    40.times do |i|
      params = {
        origin: Location.all.sample,
        destination: Location.all.sample,
        truck_loaded: Faker::Boolean.boolean
      }
      trip = Trip.new(params)
      trip.truck_loaded ? trip.has_load_back = Faker::Boolean.boolean : trip.has_load_back = true
      trip.driver = Driver.all.sample
      trip.driver.has_truck ? trip.truck = trip.driver.truck : trip.truck = Truck.all.sample
      trip.save!  
    end   
    
    puts "Viagems cadastradas com sucesso!!!"

  end

end
