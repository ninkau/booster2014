module Api
  class SponsorsController < ApplicationController

    respond_to :json

    before_filter :find_sponsor, only: [:email]

    def email
      if @sponsor.is_ready_for_email?
        BoosterMailer.initial_sponsor_mail(@sponsor).deliver
        @sponsor.status = 'contacted'
        @sponsor.last_contacted_at = Time.now.to_datetime
        if @sponsor.save
          event = Event.new(:user => current_user, :sponsor => @sponsor, :comment => "Email sent")
          event.save

          respond_with @sponsor
        else

          head :internal_server_error
        end
      else
        head :bad_request
      end
    end

    private
    def find_sponsor
      @sponsor = Sponsor.find(params[:sponsor_id])
    end
  end
end