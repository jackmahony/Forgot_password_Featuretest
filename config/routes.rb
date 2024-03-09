Rails.application.routes.draw do
  get "/registration", to: "registrations#new", as: :sign_up
  post "/registration", to: "registrations#create", as: :registration
  delete "/sign_out", to: "sessions#destroy", as: :sign_out
  get "/sign_in", to: "sessions#new", as: :sign_in
  post "/sign_in", to: "sessions#create", as: :sign_in_create

  # Routes to new page for user to enter email
  get "/reset_password", to: "passwords#change", as: :reset_password
  # Posts form data to mailer which triggers the create email action
  post "/reset_password_email", to: "passwords#create", as: :reset_password_email
  # Redirects user after form submission to confirmation screen
  get '/password_reset_confirmation', to: 'passwords#confirmation', as: :password_reset_confirmation
  # Redirects user after clicking "reset password" in mailer
  get "/reset_password_edit", to: "passwords#edit", as: :reset_password_edit

  patch "/reset_password_update", to: "passwords#update", as: :reset_password_update

  get "home", to: "site#index", as: :home
  root "sessions#new"
end
