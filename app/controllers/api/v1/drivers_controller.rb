class Api::V1::DriversController < Api::V1::ApiController
  before_action :set_driver, only: [:show, :update, :destroy]

  # GET /drivers
  def index
    if params[:has_load_back] # /GET /drivers?has_load_back={true | false}
      @drivers = Driver.joins(
        "INNER JOIN trips ON trips.driver_id = drivers.id 
        WHERE trips.has_load_back = #{params[:has_load_back]}")
    elsif params[:has_truck] # /GET /drivers?has_truck={true | false}
      @drivers = Driver.where("has_truck == #{params[:has_truck]}")
    else
      @drivers = Driver.all  
    end
    
    render json: @drivers
  
  end

  # GET /drivers/1
  def show
    render json: @driver
  end

  # POST /drivers
  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      render json: @driver, status: :created 
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drivers/1
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drivers/1
  def destroy
    @driver.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_params
      params.require(:driver).permit(:name, :gender, :has_truck, :cnh_type, :truck_id, :birthdate)
    end
end
