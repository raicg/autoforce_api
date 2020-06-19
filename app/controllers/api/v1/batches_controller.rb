class Api::V1::BatchesController < ApiController
  def close_orders
    if batch = Batch.find_by(id: permited_params[:id])
      batch.close_orders
      render json: { message: t(:all_orders_closed), status: :ok }
    else
      render json: { message: t(:batch_not_found, scope: 'errors.messages'), status: :not_found } 
    end
  end

  def send_orders
    unless permited_params[:delivery_service].nil?
      if batch = Batch.find_by(id: permited_params[:id])
        batch.send_orders(permited_params[:delivery_service])
        render json: { message: t(:all_orders_sent), status: :ok }
      else
        render json: { message: t(:batch_not_found, scope: 'errors.messages'), status: :not_found }
      end
    else
      render json: { message: t(:must_send_delivery_service_variable_as_parameter, scope: 'errors.messages'), status: :bad_request }
    end
  end

  private

  def permited_params
    params.permit(:id, :delivery_service)
  end
end
