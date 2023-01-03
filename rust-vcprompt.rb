class RustVcprompt < Formula
  desc "Informative version control prompt for your shell"
  homepage "https://github.com/sscherfke/rust-vcprompt"
  url "https://github.com/sscherfke/rust-vcprompt/archive/1.0.0.tar.gz"
  sha256 "17afaaef3dcd4fd150f3fbc16a6d653a280ce09350c36d332b215a4756537354"
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
      assert_equal " ±\e[34mmaster\e[00m|\e[32m\e[01m✔\e[00m\n", shell_output("#{bin}/rust-vcprompt")
    end
  end
end
