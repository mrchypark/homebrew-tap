class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.11.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.2/yeoul_0.11.2_darwin_arm64.tar.gz"
      sha256 "3591484767cd6fdd93ab278da840b48589565849c2447142deb5ea5e07378d3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.2/yeoul_0.11.2_darwin_amd64.tar.gz"
      sha256 "d8e8a66d8aa9a63d05083e7a24377b3a597fde95c2e521446f08c319ea622964"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.2/yeoul_0.11.2_linux_arm64.tar.gz"
      sha256 "db66b25df2bf771ac37d2ca8d3f8a7960b551c526f074d561edf316a5eeb3842"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.2/yeoul_0.11.2_linux_amd64.tar.gz"
      sha256 "78f6c1043c6e9ce980e9f02a8fc383d01fbec73a8e44a315ca7f71a1d5db3c81"
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
