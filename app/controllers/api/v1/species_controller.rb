# frozen_string_literal: true

class SpeciesController < ApplicationController
  before_action :set_species, only: %i[show edit update destroy]

  # GET /species or /species.json
  # def index
  #   @species = Specie.all
  # end

  def map
    @species = Specie.all
  end

  # GET /species/1 or /species/1.json
  def show; end

  # GET /species/new
  def new
    @species = Specie.new
  end

  # GET /species/1/edit
  def edit; end

  # POST /species or /species.json
  def create
    @species = Specie.new(species_params)

    respond_to do |format|
      if @species.save
        format.html { redirect_to species_url(@species), notice: 'Specie was successfully created.' }
        format.json { render :show, status: :created, location: @species }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @species.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /species/1 or /species/1.json
  def update
    respond_to do |format|
      if @species.update(species_params)
        format.html { redirect_to species_url(@species), notice: 'Specie was successfully updated.' }
        format.json { render :show, status: :ok, location: @species }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @species.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /species/1 or /species/1.json
  def destroy
    @species.destroy

    respond_to do |format|
      format.html { redirect_to species_url, notice: 'Specie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_species
    @species = Specie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def species_params
    params.require(:species).permit(:scientific_name, :scientific_name_id, :kingdom, :phylum, :specie_class, :order,
                                    :family, :genus, :scientific_name_authorship, :fid)
  end
end
