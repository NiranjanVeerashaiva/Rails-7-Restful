class Admission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :admission_date, type: String
  field :status, type: String

  belongs_to :patient
end
