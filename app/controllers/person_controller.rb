class PersonController < ApplicationController

  require "csv"

  def index
    # Need to add filtering on SQL level, and order by same request
    # Paginate with .will_paginate
    @persons = Person.all.includes(:locations, :affiliations)
  end

  def create
    # Refactor CSV import into model/interactor if time permits
    # For example: Person.import(params.permit(:csv))
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
      # binding.break if row[:name].include?("Boba Fett")
      if affiliations_names.present? # skip any without affiliation
        affiliations_names.each do |affiliation_name|
          person.affiliations << Affiliation.create(name: affiliation_name.titleize)
        end
      end
    end

    redirect_to root_path
  end

  def nuke
    Person.delete_all
    Location.delete_all
    Affiliation.delete_all

    redirect_to root_path
  end

end
