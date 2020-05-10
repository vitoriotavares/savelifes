class Address < ApplicationRecord
  belongs_to :neighborhood
  
  def full_address
    "#{self.address}, #{self.number}, #{self.neighborhood.name} - CEP:#{self.zip_code}"
  end
end
