class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(secure_params)
    if @contact.valid?
# email = params[:contact][:email]
# body = params[:contact][:comments]
# # Plug variables into Contact Mailer
# # email method and send email
# ContactMailer.contact_email(email, body).deliver
      name = params[:contact][:name]
      email = params[:contact][:email]
      content = params[:contact][:content]
      UserMailer.contact_email(name, email, content).deliver_now
      flash[:notice] = "Message sent from #{@contact.name}."
      redirect_to root_path
    else
      # render :new
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  private
  
  def secure_params
    params.require(:contact).permit(:name, :email, :content)
  end
end