class OffersController < ApplicationController
  before_action :set_offer, only: %i[ show update destroy ]

  # GET /offers
  def index
    @offers = Offer.order("offers.id desc").joins(offer_items: [{variant: :item}]).select(select_collection_params)

    if params[:scope] == Offer::DISCOUNT
      @offers = @offers.discount_offers.group_by(&:name)
      render 'discount'
    elsif params[:scope] == Offer::FREE
      @offers = @offers.free_offers.group_by(&:name)
      render 'free'
    else
      @offers = @offers.group_by(&:name)
    end
  end

  # GET /offers/1
  def show
    render json: @offer
  end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      render json: @offer, status: :created, location: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      render json: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def offer_params
      params.require(:offer).permit(:name, :offer_type, :discount_percentage, offer_items_attributes:[:variant_id, :free])
    end

    def select_collection_params
      "
        offers.id as offer_id,
        offers.name,
        offers.offer_type,
        offers.discount_percentage,
        items.name as item_name,
        variants.quantity,
        variants.price,
        offer_items.free
      "
    end
end
