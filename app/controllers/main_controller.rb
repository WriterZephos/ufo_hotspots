class MainController < ApplicationController

  def index
    file = File.read("#{Rails.root}/README.md")
    options = {
        filter_html:     true,
        hard_wrap:       true, 
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true
      }
  
    extensions = {
        autolink:           true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    render html: markdown.render(file).html_safe
  end

end
