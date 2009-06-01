# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NoPeekingExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/no_peeking"
  
  # define_routes do |map|
  #   map.connect 'admin/no_peeking/:action', :controller => 'admin/no_peeking'
  # end
  
  def activate
    # admin.tabs.add "No Peeking", "/admin/no_peeking", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "No Peeking"
  end
  
end