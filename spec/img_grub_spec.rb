require 'img_grub'

RSpec.describe ImgGrub do
  describe 'path' do
    context 'cant write' do
      let(:path) { '/System' }

      it do
        expect { ImgGrub.send(:prepare_dir, path) }.to raise_exception(ImgGrub::BadDir)
      end
    end

    context 'file name' do
      let(:path) { '/tmp' }
      let(:url)  { 'http://localhost.ru/img.jpg' }

      it { expect(ImgGrub.send(:file_name_for, path, url)).to eq("/tmp/img.jpg") }
    end
  end
end
