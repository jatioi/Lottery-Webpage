class Client::Me::LotteriesController < ApplicationController
  before_action :authenticate_client_user!
  def index
    @lotteries = current_client_user.tickets.includes(:item)
                                    .order(created_at: :desc)

  end
end
