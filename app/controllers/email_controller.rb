class EmailController < ApplicationController
    def index
        @emails = Email.all
    end

    def show
        @email = Email.find(params[:id])
        @email.update(read: true)
        respond_to do |format|
            format.html {}
            format.js { }
        end
    end
    
    def create
        @emails = Email.new(object: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars)
        
        if @email.save
          flash[:notice] = "Email received"
        else 
          flash[:notice] = " Please try again"
        end
        respond_to do |format|
        format.html{redirect_to root_path}
        format.js{}
      end
    end


    def destroy
        @email.destroy
        respond_to do |format|
          format.html { redirect_to email_url, notice: 'Email was successfully destroyed.' }
          format.json { head :no_content }
      end
    end
      
    private

    def set_email
        @email = Email.find(params[:id])
    end
      
    def email_params
        params.require(:email).permit(:object, :body, :user_id)
    end
end
