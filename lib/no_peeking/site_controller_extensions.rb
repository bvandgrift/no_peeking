module NoPeeking::SiteControllerExtensions
  def self.included(base)
    base.class_eval do
      alias_method_chain :show_uncached_page, :peeking
    end
  end
  
  private
    def show_uncached_page_with_peeking(url)
      @page = find_page(url)
      
      unless @page.nil?
        request_host = request.env['HTTP_HOST'].gsub(/:[\d]*$/, '') #trim off #s at the end.
        request.env['HTTP_REFERER'] =~ /^(http:\/\/)?([a-zA-Z.]*)(:[\d]*)?.*/ #grab the referring host
        request_referrer = $2
        if @page.no_peeking? && request_host != request_referrer
          redirect_to "/" and return
        end
        process_page(@page)
        @cache.cache_response(url, response) if request.get? and live? and @page.cache? and !@page.no_peeking?
        @performed_render = true
      else
        render :template => 'site/not_found', :status => 404
      end
    rescue Page::MissingRootPageError
      redirect_to welcome_url
    end
end