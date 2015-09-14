require 'html_parser'

RSpec.describe HtmlParser do
  describe 'url' do
    context 'relative' do
      let(:url)      { 'localhost.ru' }
      let(:relative) { HtmlParser.send(:relative?, url) }

      it { expect(relative).to be true}
    end

    context 'not relative' do
      let(:url)      { 'http://localhost.ru' }
      let(:relative) { HtmlParser.send(:relative?, url) }

      it { expect(relative).to be false}
    end

    context 'absolute for relative' do
      let(:url)      { 'localhost.ru' }
      let(:relative) { HtmlParser.send(:absolute_url, url) }

      it { expect(relative).to eq("http://#{url}")}
    end

    context 'bad url request' do
      let(:url)     { 'google.google' }

      it { expect{ HtmlParser.send(:url_request, url) }.to raise_exception(HtmlParser::BadUrl) }
    end
  end

  describe 'html' do
    context 'img paths' do
      let(:html) do
        "<html><body><a href='http://localhost.ru'>ololo</a>
         <img src='http://localhost.ru/img.jpg'></body></html>"
      end
      let(:parsed_html) { HtmlParser.send(:parsed_html, html) }
      let(:image_paths) { HtmlParser.send(:page_image_paths, parsed_html) }

      it { expect(image_paths).to match_array(['http://localhost.ru/img.jpg']) }
    end

    context 'img urls' do
      let(:url)       { 'locahost.ru' }
      let(:img1)      { "/img1.jpg" }
      let(:img2)      { "http://#{url}/img2.jpg" }
      let(:img_paths) { [img1, img2] }
      let(:img_urls)  { HtmlParser.send(:get_page_image_urls, img_paths, url) }

      it { expect(img_urls).to match_array(["http://#{url}#{img1}", img2]) }
    end
  end
end
