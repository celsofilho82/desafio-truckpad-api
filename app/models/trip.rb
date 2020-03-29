class Trip < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :truck, optional: true
  belongs_to :origin, class_name: 'Location'
  belongs_to :destination, class_name: 'Location'
  accepts_nested_attributes_for :origin
  accepts_nested_attributes_for :destination

  def as_json(options={})
    super(
      except: [:created_at, :updated_at, :origin_id, :destination_id],
      include: {
        origin: { except: [:created_at, :updated_at] },
        destination: { except: [:created_at, :updated_at] }
      }
    )
    
  end

end
