class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.5.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.5/yeoul_0.5.5_darwin_arm64.tar.gz"
      sha256 "1f9f9dc47e6e0fb41b629b38228bb4eaac90e3bb70ed42edbd7b230efdb4f3d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.5/yeoul_0.5.5_darwin_amd64.tar.gz"
      sha256 "0658c0b11f5589a4277e628632a6839daff6ccf15a71239b1e2ef172e9567895"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.5/yeoul_0.5.5_linux_arm64.tar.gz"
      sha256 "cf360da29c603bfaea36a37bdacab2b5ef77667df1e0771c02b186bf9f3781c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.5/yeoul_0.5.5_linux_amd64.tar.gz"
      sha256 "ce833cc3a10034ef896abfa7b21e74ef433888edaf43f9992e141319064fa137"
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
