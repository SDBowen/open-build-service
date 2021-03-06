class Webui::SubscriptionsController < Webui::WebuiController
  before_action :require_admin

  def index
    @subscriptions_form = subscriptions_form

    # TODO: Remove the statement after migration is finished
    switch_to_webui2
  end

  def update
    subscriptions_form.update!(params[:subscriptions])
    flash[:success] = 'Notifications settings updated'
  rescue ActiveRecord::RecordInvalid
    flash[:error] = 'Notifications settings could not be updated due to an error'
  ensure
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js { render 'webui2/webui/subscriptions/update' }
    end
  end

  private

  def subscriptions_form
    EventSubscription::Form.new
  end
end
