class Appointment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :appointment_date, type: String
  field :status, type: String

  belongs_to :patient
end
