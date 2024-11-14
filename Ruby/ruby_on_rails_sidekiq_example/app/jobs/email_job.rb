
class EmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Logic to send email to the user
    UserMailer.welcome_email(user).deliver_now
  end
end
