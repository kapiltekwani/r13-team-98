class UserMailer < ActionMailer::Base
  default :from => 'notify@beetweenfriends.com' 
  
  def notification(email)
    @email = email
    mail(to: email, subject: "Cheers someone of your friend answerd about you at Beetween Friends.")
  end
end
