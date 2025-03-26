class Departments::AdmissionsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @admission = @patient.admissions.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @admission = @patient.admissions.new(admission_params)

    if @admission.save
      redirect_to patient_path(@patient), notice: 'Admission created successfully.'
    else
      render :new
    end
  end

  private

  def admission_params
    params.require(:departments_admission).permit(:admission_date, :status)
  end
end
