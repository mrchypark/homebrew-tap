class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.12.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.12.0/yeoul_0.12.0_darwin_arm64.tar.gz"
      sha256 "4e91d0ef733faca0ef52c9e3022a2d89328e787bdab4ae7846fa3e2606b2065d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.12.0/yeoul_0.12.0_darwin_amd64.tar.gz"
      sha256 "c8171eb2987b6e2591736ba23d2718e54376483f662e7bf6159fa174209f47d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.12.0/yeoul_0.12.0_linux_arm64.tar.gz"
      sha256 "e36ec4201077ed40f7f9fceb906a5fd5c7b4b19f8bddaa186ce2ecd4c42164c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.12.0/yeoul_0.12.0_linux_amd64.tar.gz"
      sha256 "d7419efcaa8ebe2c54b81be0364ad72e2b7601814e21a7269805be1ca9149770"
    end
  end

  def install
    libexec.install Dir["*"]

    runtime_env = {}
    if OS.mac?
      runtime_env["DYLD_LIBRARY_PATH"] = libexec/"lib"
    elsif OS.linux?
      runtime_env["LD_LIBRARY_PATH"] = libexec/"lib"
    end

    (bin/"yeoul").write_env_script libexec/"bin/yeoul", runtime_env
    (bin/"yeould").write_env_script libexec/"bin/yeould", runtime_env
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/yeoul help")
  end
end
