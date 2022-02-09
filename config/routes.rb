Rails.application.routes.draw do

  root to: redirect("/person")

  resources :person, only: [:index, :create] do
    collection do
      post :nuke
    end
  end

end
