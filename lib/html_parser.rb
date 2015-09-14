require 'open-uri'
require 'nokogiri'

module HtmlParser
  class BadUrl < StandardError
  end

  class << self
    def page_image_urls_for(url)
      req = url_request(url)
      html = parsed_html(req)
      image_paths = page_image_paths(html)

      get_page_image_urls(image_paths, url)
    end

    private

    def get_page_image_urls(image_paths, url)
      image_paths.inject([]) do |arr, img_url|
        if relative?(img_url)
          arr << "#{absolute_url(url)}#{img_url}"
        else
          arr << img_url
        end
      end
    end

    def page_image_paths(parsed_html)
      parsed_html.search('//img').map { |el| el['src'] }.compact
    end

    def parsed_html(html_file)
      Nokogiri::HTML(html_file)
    end

    def url_request(url)
      uri = absolute_url(url)
      begin
        open(uri)
      rescue
        raise BadUrl.new("Bad url: #{url}")
      end
    end

    def absolute_url(url)
      relative?(url) ? "http://#{url}" : url
    end

    def relative?(url)
      URI.parse(url).scheme.nil?
    end
  end
end
