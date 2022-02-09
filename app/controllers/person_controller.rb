class PersonController < ApplicationController

  require "csv"

  def index
    @persons = Person.all.includes(:locations, :affiliations)
  end

  def create
    # Person.import(params.permit(:csv))

    CSV.foreach(params[:csv].path, headers: true, header_converters: :symbol) do |row|
      person_attributes = row.to_h.except(:location, :affiliations)
      person = Person.create!(person_attributes)

      location_names = row[:location]&.split(",")
      if location_names.present?
        location_names.each do |location_name|
          person.locations << Location.create(name: location_name.titleize)
        end
      end

      affiliations_names = row[:affiliations]&.split(",")
      if affiliations_names.present?
        affiliations_names.each do |affiliation_name|
          person.affiliations << Affiliation.create(name: affiliation_name.titleize)
        end
      end
    end

    redirect_to root
  end

end
