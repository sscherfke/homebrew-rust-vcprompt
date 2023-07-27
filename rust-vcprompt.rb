class RustVcprompt < Formula
  desc "Informative version control prompt for your shell"
  homepage "https://github.com/sscherfke/rust-vcprompt"
  url "https://github.com/sscherfke/rust-vcprompt/archive/refs/tags/1.0.1.tar.gz"
  sha256 "48384586fb11011da93cdcd51a693580f73bf9bfe2f358ad32f2c92e64262289"
  head "https://github.com/sscherfke/rust-vcprompt.git"

  depends_on "rust" => :build
  conflicts_with "vcprompt", :because => "rust-vcprompt also ships a vcprompt binary"

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/vcprompt" => "vcprompt"
  end

  test do
    mkdir "repo" do
      system "git", "init"
      ENV.keys.grep(/^VCP_[A-Z]+/).each { |k| ENV.delete(k) }
      assert_equal " ±\x01\x1b[34mmain\x01\x1b[22;39m|\x01\x1b[33m↻1\x01\x1b[22;39m\n", shell_output("#{bin}/rust-vcprompt")
    end
  end
end
