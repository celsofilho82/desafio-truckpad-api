class Driver < ApplicationRecord
  # Criando nested association com o model truck
  belongs_to :truck, optional: true
  has_many :trips

  def as_json(options={})
    super(
      except: [:created_at, :updated_at, :truck_id],
      include: {
        truck: { only: [:id, :description] },
        trips: { 
          except: [:created_at, :updated_at, :origin_id, :destination_id],
          include: {
            origin: { except: [:created_at, :updated_at] },
            destination: { except: [:created_at, :updated_at]}
          }            
        }
      }
    )
  end
  
end
