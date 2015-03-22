Schedulator::Application.routes.draw do

  # Landing page
  root     'events#index'
  get      '/events'                    => 'events#index', as: :events

  # Creating an event
  get      '/events/new'                => 'events#new', as: :new_event
  post     '/events'                    => 'events#create'

  # Participating in an event
  constraints(short_hashid: /\w{6}/) do
    get      '/events/:short_hashid'        => 'events#show', as: :event
    post     '/events/:short_hashid/vote'   => 'events#vote', as: :vote_event
  end

  # Administrating an event
  constraints(long_hashid: /\w{20}/) do
    get      '/events/:long_hashid'         => 'events#edit', as: :edit_event
    put      '/events/:long_hashid'         => 'events#update'
    patch    '/events/:long_hashid'         => 'events#update'
    delete   '/events/:long_hashid'         => 'events#destroy'
  end

end
