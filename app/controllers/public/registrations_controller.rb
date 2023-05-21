class Public::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      resource.nickname = sign_up_params[:nickname]
      resource.save
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation])
  end

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
