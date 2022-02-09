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
      person = Person.new(person_attributes)

      affiliation_names = row[:affiliations]&.split(",")
      next if affiliation_names.blank?

      person.save

      affiliation_names.each do |affiliation_name|
        person.affiliations << Affiliation.create(name: affiliation_name.titleize)
      end

      location_names = row[:location]&.split(",")
      next if location_names.blank?

      location_names.each do |location_name|
        person.locations << Location.create(name: location_name.titleize)
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
