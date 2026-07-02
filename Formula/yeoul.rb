class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.1/yeoul_0.2.1_darwin_arm64.tar.gz"
      sha256 "d3ba06fd9a719c59903993d18cfc7338350e8c15fad26003fc2f40b5e9700130"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.1/yeoul_0.2.1_darwin_amd64.tar.gz"
      sha256 "5e905a23cbfe4c2ad762778489ee0413a0cd8faf5b3d30afc05ca8b293669461"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.1/yeoul_0.2.1_linux_arm64.tar.gz"
      sha256 "50d72f34bf3912c8d8649edc18a34146a6c24ee128e7ff60da7430d9adecef4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.1/yeoul_0.2.1_linux_amd64.tar.gz"
      sha256 "f4e0a4938d808940afde957296be56862c488cdfa542382e3b372c2159139f7f"
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
