class Departments::Appointments::AppointmentsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @appointment = @patient.appointments.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @appointment = @patient.appointments.new(appointment_params)

    if @appointment.save
      redirect_to patient_path(@patient), notice: 'Appointment created successfully.'
    else
      render :new
    end
  end

  private

  def appointment_params
    params.require(:departments_appointment).permit(:appointment_date, :status)
  end
end
