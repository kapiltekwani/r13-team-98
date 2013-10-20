class UserMailer < ActionMailer::Base
  default :from => 'notify@beetweenfriends.com' 
  
  def notification(email)
    @email = email
    mail(to: email, subject: "Cheers!!! one of your friends answered about you at 'Between You and me'")
  end
end
