class VenuesController < ApplicationController

  def index
    @venue = Venue.all
    venues = @venue.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    @venue = Venue.all
    
    matching_venues = @venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
    @venue = Venue.new
    
  
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save

    redirect_to("/venues/#{@venue.id}")
  end
  
  def update
    the_id = params.fetch("the_id")

    venue = Venue.where({ :id => the_id }).at(0)
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save
    
    redirect_to("/venues/#{venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
