class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.5.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.4/yeoul_0.5.4_darwin_arm64.tar.gz"
      sha256 "5cc09e615a61a7623ab634aac45d8495bb6a08f02466d3c0b681ad792918b633"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.4/yeoul_0.5.4_darwin_amd64.tar.gz"
      sha256 "ebfb91399054c38f15ef6056a9ec6251a63e851809e01a193f1aa1ac72cc8ede"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.4/yeoul_0.5.4_linux_arm64.tar.gz"
      sha256 "1ba32b339f8b058d1604454c595176c5f8b9e0cfdacde7fab9c2bc268d1c0f86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.4/yeoul_0.5.4_linux_amd64.tar.gz"
      sha256 "7f401b1671a0faf5e67953de12cebaa6d480ee057f348ba33208e8e6f56c6fbb"
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
