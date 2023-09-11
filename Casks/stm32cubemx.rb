cask "stm32cubemx" do
  module Utils
    def self.cubemx_app_path
      "/Applications/STMicroelectronics/STM32CubeMX.app"
    end

    def self.usr_local_bin_file
      "/usr/local/bin/stm32cubemx"
    end

    def self.cubemx_script_file
      "#{cubemx_app_path}/Contents/MacOs/stm32cubemx.sh"
    end
  end

  version "6.2.0"
  sha256 :no_check

  url "https://www.dropbox.com/s/oega5zar68w8b0p/en.stm32cubemx_v6.2.0.zip?dl=1", header: "", data: nil,
      verified: "dropbox.com/s/oega5zar68w8b0p"
  name "STM32CubeMX"
  desc "STM32Cube initialization code generator"
  homepage "https://www.st.com/en/development-tools/stm32cubemx.html"

  auto_updates false
  depends_on cask: "AdoptOpenJDK/openjdk/adoptopenjdk15"

  installer script: {
    executable:   "/Library/Java/JavaVirtualMachines/adoptopenjdk-15.jdk/Contents/Home/bin/java",
    args:         ["-jar", "#{staged_path}/SetupSTM32CubeMX-6.2.0-RC3.app/Contents/MacOs/SetupSTM32CubeMX-6_2_0"],
    must_succeed: true,
  }

  postflight do
    ohai "Creating command line invocation script"
    File.open(Utils.cubemx_script_file, "w") do |f|
      f << "\#\!/usr/bin/env bash\n"
      f << "/Library/Java/JavaVirtualMachines/adoptopenjdk-15.jdk/Contents/Home/bin/java "
      f << "-jar "
      f << "/Applications/STMicroelectronics/STM32CubeMX.app/Contents/MacOS/STM32CubeMX $@\n"
      f.close
    end

    ohai "Symlinking command line invocation script to /usr/local/bin"
    FileUtils.chmod 0755, Utils.cubemx_script_file
    FileUtils.ln_sf Utils.cubemx_script_file, Utils.usr_local_bin_file

    ohai "Fixing STM32CubeMX.app finder opening issue"
    FileUtils.ln_sf "#{staged_path}/jre", "/Applications/STMicroelectronics/STM32CubeMX.app/Contents/MacOs/jre"
  end

  uninstall_preflight do
    FileUtils.rm Utils.usr_local_bin_file, force: true
  end

  uninstall script: {
    executable:   "/Library/Java/JavaVirtualMachines/adoptopenjdk-15.jdk/Contents/Home/bin/java",
    args:         ["-jar", "#{Utils.cubemx_app_path}/Contents/Resources/Uninstaller/uninstaller.jar"],
    must_succeed: false,
  }

  caveats "This cask depends on OpenJDK 15 and does **not** work with OpenJDK 16.\n" \
          "To use, first install OpenJDK 15:\n" \
          "  $ brew install --cask AdoptOpenJDK/openjdk/adoptopenjdk15\n" \
          "The STM32CubeMX.app might not work when trying to open it from the Finder.\n" \
          "If it's the case, launch the app from the terminal by running:\n" \
          "  $ stm32cubemx\n" \
          "Or with '-i' option for the interactive mode:\n" \
          "  $ stm32cubemx -i\n" \
end
