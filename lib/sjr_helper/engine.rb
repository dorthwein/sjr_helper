module SjrHelper
  class Engine < ::Rails::Engine
    initializer "setup for rails" do
      ActionView::Base.send(:include, SjrHelper::Helpers)
      ActionController::Base.send(:include, SjrHelper::ControllerExtension)
    end
  end
end
