class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.2/yeoul_0.5.2_darwin_arm64.tar.gz"
      sha256 "77bb8a5ffbcc23272bec78f2592672cb9c9a636739161bb6c7443611eb523d4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.2/yeoul_0.5.2_darwin_amd64.tar.gz"
      sha256 "ce6cc7122a8532472a59f2e17cda4dfd2114079b1be8d6206ccf758c1682882f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.2/yeoul_0.5.2_linux_arm64.tar.gz"
      sha256 "996446baf8aee5abb86c07848bae63318c7ddb7a4146a3009bf6eb819c872f2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.2/yeoul_0.5.2_linux_amd64.tar.gz"
      sha256 "02b1b5cbb46289d9cc86714c305b3fda48befce94506aae7d6a9e529a1e65617"
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
