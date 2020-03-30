class Api::V1::TripsController < Api::V1::ApiController
  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /trips
  def index
    # GET /trips?truck_loaded={true | False}&period={YYYY-MM-DD:YYYY-MM-DD}
    if params[:truck_loaded] && params[:period] 
      start_date = params[:period].split(":")[0]
      end_date = params[:period].split(":")[1]
      @trips = Trip.where( "created_at BETWEEN ? AND ? ", start_date, end_date)
    elsif params[:list] # GET /trips?list={destination | origin}
      @trips = []
      elements = Trip.all
      elements.each do |element|
        @trips << element.send(params[:list])
      end   
    else
      @trips = Trip.all
    end
    render json: @trips, except: [:created_at, :updated_at]
  end

  # GET /trips/1
  def show
    render json: @trip
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      render json: @trip, status: :created, location: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_params
      params.require(:trip).permit(:origin, :destination, :truck_loaded, :has_load_back, :driver_id)
    end
end
