require 'celluloid/current'
require_relative 'html_parser'
require_relative 'file_saver'

module ImgGrub
  class BadDir < StandardError
  end

  class << self
    def grub_images(url, path)
      images_urls = HtmlParser.page_image_urls_for(url)
      prepare_dir(path)

      save_images(path, images_urls)
    end

    private

    def save_images(path, images_urls)
      pool = FileSaver.pool

      images_urls.each do |url|
        file_name = file_name_for(path, url)

        pool.save(file_name, url)
      end
    end

    def file_name_for(path, url)
      [path, '/', File.basename(url)].join
    end

    def prepare_dir(path)
      begin
        if Dir.exist?(path)
          if File.writable?(path)
            nil
          else
            raise 'Can`t write to this directory'
          end
        else
          Dir.mkdir(path)
        end
      rescue Exception => e
        raise BadDir.new("Bad dir: #{path}, reason => #{e.message}")
      end
    end
  end
end
