require "spec_helper"

RSpec.describe ModifyFile do
  let(:modify_file) { ModifyFile.new(["/tmp/test.txt"]) }

  describe "#call" do
    before { allow(modify_file).to receive(:execute_process) }

    context "when filepath is not provided" do
      it "aborts the program" do
        expect { ModifyFile.new([]).call }.to raise_error(SystemExit)
      end
    end

    context "when successful" do
      before { allow(File).to receive(:exist?).with("/tmp/test.txt").and_return(true) }

      it "modifies a file" do
        modify_file.call
        expect(modify_file).to receive(:execute_process)
        expect { modify_file.call }.to output(/File modified: \/tmp\/test.txt/).to_stdout
      end
    end
  end
end