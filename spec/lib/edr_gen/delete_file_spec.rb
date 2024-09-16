require "spec_helper"

RSpec.describe DeleteFile do
  let(:delete_file) { DeleteFile.new(["/tmp/test.txt"]) }

  describe "#call" do
    before do
      allow(delete_file).to receive(:execute_process)
      allow(delete_file)
    end

    context "when filepath is not provided" do
      it "aborts the program" do
        expect { DeleteFile.new([]).call }.to raise_error(SystemExit)
      end
    end

    context "when successful" do
      before { allow(File).to receive(:exist?).with("/tmp/test.txt").and_return(true) }

      it "deletes a file" do
        delete_file.call
        expect(delete_file).to receive(:execute_process)
        expect { delete_file.call }.to output(/File deleted: \/tmp\/test.txt/).to_stdout
      end
    end
  end
end