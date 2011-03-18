ClassAppNew::Application.routes.draw do
  match 'courses' => "courses#index"
end
