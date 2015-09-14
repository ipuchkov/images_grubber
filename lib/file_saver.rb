require 'celluloid/current'
require 'open-uri'

class FileSaver
  include Celluloid

  def save(name, url)
    data = get(url)

    write(name, data) if data
  end

  def write(name, data)
    File.open(name, 'w') { |f| f.write(data); f.close }
  end

  def get(url)
    begin
      open(url)
    rescue
    end
  end
end
