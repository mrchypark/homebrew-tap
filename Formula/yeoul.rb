class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.4.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.1/yeoul_0.4.1_darwin_arm64.tar.gz"
      sha256 "138b94504315d944a18b6fea98a7f4993ad63c5fd59acfa5944bcad602681a84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.1/yeoul_0.4.1_darwin_amd64.tar.gz"
      sha256 "6045e3d95b1a47ec2a8c4cfb09c9ea27538f68702a22cc277d6735d2b2238d1d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.1/yeoul_0.4.1_linux_arm64.tar.gz"
      sha256 "e1554982aca3b5605ab42c05ad8f9d9e6c6472e9075f489808ec55bdb9633b11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.1/yeoul_0.4.1_linux_amd64.tar.gz"
      sha256 "d6553456090006c8ba502b613f71bd92acaec30cbefdaa4f9f33e56bb1e9d217"
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
