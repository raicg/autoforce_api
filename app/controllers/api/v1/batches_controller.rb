class Api::V1::BatchesController < ApiController
  def close_orders
    render json: { status: t(:all_orders_closed) },
           status: :ok if Batch.find(permited_params[:id]).close_orders
  end

  def send_orders
    render json: { status: t(:all_orders_sent) },
           status: :ok if Batch.find(permited_params[:id]).send_orders(permited_params[:delivery_service])
  end

  private

  def permited_params
    params.permit(:id, :delivery_service)
  end
end
