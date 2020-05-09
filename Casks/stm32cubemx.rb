cask 'stm32cubemx' do
  version '5.6.1'
  sha256 'ff3ed237790529b2134f2254789220d7def05669857d5e0e1e60d387c17ab4bb'

  url "https://dl.bintray.com/osx-cross/casks-stm32/en.stm32cubemx_v#{version}.zip"
  name 'STM32CubeMX'
  homepage 'https://www.st.com/en/development-tools/stm32cubemx.html'

  auto_updates false

  installer script: {
    executable: 'java',
    args:       ['-jar', "#{staged_path}/SetupSTM32CubeMX-#{version}.exe"],
    must_succeed: true
  }

  postflight do
    usr_local_bin_file = "/usr/local/bin/stm32cubemx"
    cubemx_app_file = "#{appdir}/STMicroelectronics/STM32CubeMX.app/Contents/MacOs/stm32cubemx.sh"

    File.open(cubemx_app_file, "w") { |f|
      f.write("#!/usr/bin/env bash\njava -jar #{appdir}/STMicroelectronics/STM32CubeMX.app/Contents/MacOs/STM32CubeMX $@\n")
      f.close
    }

    FileUtils.chmod 0755, cubemx_app_file
    FileUtils.ln_sf cubemx_app_file, usr_local_bin_file
  end

  uninstall script: {
    executable: 'java',
    args:       ['-jar', '/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources/Uninstaller/uninstaller.jar'],
    must_succeed: true
  }

  uninstall_preflight do
    binary_file = "/usr/local/bin/stm32cubemx"
    FileUtils.rm binary_file, force: true
  end

  caveats do
    depends_on_java
  end
end
