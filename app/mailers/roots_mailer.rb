class RootsMailer < ActionMailer::Base

  default_url_options[:host] = "boosterconf.no"
  FROM_EMAIL = 'Booster 2013 <kontakt@boosterconf.no>'
  SUBJECT_PREFIX = "[Booster 2013]"


  def registration_confirmation(user)
    @name = user.name
    @email = user.email
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} registered")
  end

  def manual_registration_confirmation(user)
    @name = user.name
    @email = user.email
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} registered")
  end

  def manual_registration_notification(user, user_url)
    @name = user.name
    @email = user.email
    @description = user.registration.description
    @user_url = user_url
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} registered with manual payment method")
  end

  def speaker_registration_confirmation(user)
    @name = user.name
    @email = user.email
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} registered")
  end

  def speaker_registration_notification(user, user_url)
    @name = user.name
    @email = user.email
    @user_url = user_url
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} registered as speaker")
  end

  def password_reset_instructions(user)
    subject "#{SUBJECT_PREFIX} How to change your password"
    recipients user.email
    from FROM_EMAIL
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)

  end

  def free_registration_confirmation(user)
    @name = user.name
    @email = user.email
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} free ticket request")
  end

  def free_registration_notification(user, user_url)
    @name = user.name
    @email = user.email
    @description = user.registration.description
    @user_url = user_url
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} registered as #{user.registration.description}")
  end

  def free_registration_completion(user)
    @name = user.name
    @email = user.email
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} User #{user.email} free ticket confirmation")
  end

  def payment_confirmation(registration)
    @name = registration.user.email
    @payment_text = registration.description
    @amount = registration.price
    mail(:to => registration.user.email, :subject => "#{SUBJECT_PREFIX} Payment receipt for #{registration.user.email}")
  end

  def talk_confirmation(talk, talk_url)
    @speaker = talk.speaker_name
    @email = talk_speaker_email
    @talk = talk.title
    @talk_url = talk_url
    mail(:to => talk.users.map(&:email), :subject => "#{SUBJECT_PREFIX} Confirmation on submission #{talk.title}")
  end

  def comment_notification(comment, comment_url)
    @speaker = comment.talk.speaker_name
    @talk = comment.talk.title
    @comment_url = comment_url
    mail(:to => coment.talk.users.map(&:email), :subject => "#{SUBJECT_PREFIX} Comment for #{comment.talk.title}")
  end

  def talk_acceptance_confirmation(talk, speaker, current_user_url)
    @talk = talk
    @speaker = speaker
    @current_user_url = current_user_url
    mail(:to => speaker.email, :subject => "#{SUBJECT_PREFIX} Your submission \"#{talk.title}\" has been accepted")
  end

  def talk_refusation_confirmation(talk, speaker, current_user_url)
    @talk = talk
    @speaker = speaker
    @current_user_url = current_user_url
    mail(:to => speaker.email, :subject => "#{SUBJECT_PREFIX} Your submission \"#{talk.title}\" has not been accepted")
  end

  def upload_slides_notification(talk, edit_talk_url, new_password_reset_url)
    @talk = talk.title
    @speaker_email = talk.speaker_email
    @speaker = talk.speaker_name
    @edit_talk_url = edit_talk_url
    @new_password_reset_url = new_password_reset_url
    mail(:to => talk.users.map(&:email),
          :cc => FROM_EMAIL,
          :subject => "You may now upload the slides for your lightning talk at the Booster conference website")
  end

  def update_dinner_attendance_status(name, email, attending_dinner_url, not_attending_dinner_url, lost_password_url)
    @name = name
    @attending_dinner_url = attending_dinner_url
    @not_attending_dinner_url = not_attending_dinner_url
    @lost_password_url = lost_password_url
    mail(:to => email, :subject => "Please confirm your status regarding the conference dinner")
  end

  def welcome_email(user, tutorial_registration_url)
    @user = user
    @tutorial_registration_url = tutorial_registration_url
    mail(:to => user.email, :subject => "Welcome to Booster 2013 at Scandic Hotel Bergen City, Wednesday March 13.")
  end

  def promo_email(user)
    @user = user
    mail(:to => user.email, :subject => "[Booster] Bergen Coding Dojo har startet opp!")
  end

  def error_mail(title, body)
    @body = body
    mail(:to => "kontakt@boosterconf.no", :subject => title)
  end

  def feedback_email(talk, group)
    @talk = talk
    @group = group
    mail(:to => talk.users.map(&:email), :subject => "Feedback on your presentation at Booster 2013")
  end

  def talk_feedback_email(talk_feedback)
    @talk_feedback = talk_feedback
    mail(:to => talk_feedback.talk.users.map(&:email), :subject => "Feedback on your presentation at Booster 2013")
  end

  def hotel_program_email(user)
    @user = user
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} Hotel booking and program")
  end

  def tutorial_registration(user, lost_password_url)
    @user = user
    @lost_password_url = lost_password_url
    mail(:to => user.email, :subject => "#{SUBJECT_PREFIX} Tutorial registration opens Friday May 20 09:00 AM")
  end

  def speakers_dinner_email(user)
    @user = user
    mail(:to => user.email, :cc => FROM_EMAIL,
         :subject => "#{SUBJECT_PREFIX} Information about the speaker's dinner")
	end

	def initial_sponsor_mail(sponsor)
    @name = sponsor.contact_person
    @sender = sponsor.user.name
    @sponsor = sponsor
    mail(:to => sponsor.email, :from => "#{sponsor.user.name} <#{sponsor.user.email}>",
        :cc => FROM_EMAIL, :bcc => sponsor.user.email,
        :subject => "Bli sponsor for Booster 2013")
  end

  def reminder_to_earlier_participants_email(user)
    @name = user.name
    mail(:to => user.email, :subject => "Remember to sign up for Booster 2013 before the Early Bird deadline!")
  end

  def reminder_to_earlier_speakers_email(user)
    @name  = user.name
    mail(:to => user.email, :subject => "Share your knowledge at Booster 2013!")
  end
end