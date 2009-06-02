# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class NoPeekingExtension < Radiant::Extension
  version "0.1"
  description "Redirecting deep links when needed."
  url "http://github.com/sfamiliar/no_peeking/tree/master/"
    
  def activate
    SiteController.send :include, NoPeeking::SiteControllerExtensions
    if admin.respond_to? :page
      admin.page.edit.add :parts_bottom, "no_peeking_enabled", :before => "edit_timestamp"
    end
  end
  
  def deactivate
  end
  
end