require "spec_helper"

RSpec.describe CreateFile do
  let(:create_file) { CreateFile.new(["/tmp/test.txt"]) }

  describe "#call" do
    before { allow(create_file).to receive(:execute_process) }

    context "when filepath is not provided" do
      it "aborts the program" do
        expect { CreateFile.new([]) }.to raise_error(SystemExit)
      end
    end

    context "when successful" do
      after { File.delete("/tmp/test.txt") if File.exist?("/tmp/test.txt") }

      it "creates a file" do
        create_file.call
        expect(create_file).to receive(:execute_process)
        expect { create_file.call }.to output(/File created: \/tmp\/test.txt/).to_stdout
      end
    end
  end
end
