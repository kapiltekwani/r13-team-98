class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "pramod@joshsoftware.com", "pratik@joshsoftware.com"
  end
end
