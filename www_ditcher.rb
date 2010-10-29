class WWWDitcher
  
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if url_contains_www?(env)
      ditch_www_and_redirect(env)
    else
      @app.call(env)
    end
    
  end
  
private

  def url_contains_www?(env)
    env['REQUEST_URI'].include?("//www.")
  end
  
  def ditch_www_and_redirect(env)    
    without_www = env['REQUEST_URI'].gsub('//www.', '//')
    [301, { "Location" => without_www }, ""]
  end
  
end
