class PersonController < ApplicationController

  require "csv"

  helper_method :sort_column, :sort_direction

  def index
    @persons = \
      Person.all
        .includes(:locations, :affiliations)
        .order(sort_column + ' ' + sort_direction)
        .where("
          first_name LIKE :query OR
          species LIKE :query OR
          gender LIKE :query OR
          weapon LIKE :query OR
          vehicle LIKE :query",
          query: "%#{params[:query]}%"
        )
        .paginate(page: params[:page], per_page: 10)
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

  private

    def sort_column
      Person.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
