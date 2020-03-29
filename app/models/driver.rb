class Driver < ApplicationRecord
  # Criando nested association com o model truck
  belongs_to :truck, optional: true
  accepts_nested_attributes_for :truck, update_only: true

  has_many :trips
  validates :name, :cnh_type, presence: true

  def as_json(options={})
    super(
      except: [:created_at, :updated_at, :truck_id],
      include: {
        truck: { only: [:id, :description] }
      }
    )
  end
  

end
