class Patient
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fullname, type: String
  field :age, type: Integer
  field :phone_number, type: String

  has_many :appointments, class_name: 'Departments::Appointment'
  has_many :admissions, class_name: 'Departments::Admission'

end
