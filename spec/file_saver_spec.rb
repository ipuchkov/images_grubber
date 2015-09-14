require 'file_saver'

RSpec.describe FileSaver do
  describe 'file' do
    context 'create file' do
      let(:data) { 'data' }
      let(:name) { '/tmp/test_file.txt' }
      let(:file) { FileSaver.new.write(name, data) }

      it do
        file

        expect(File.exist?(name)).to be true
        File.delete(name)
      end
    end
  end
end
