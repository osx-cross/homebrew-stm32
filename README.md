# STM32 Casks & Formulae

## About

This is a ***[non-official](#note-to-sts-teams)*** tap for STM32 softwares and tools:

- [x] [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)
- [x] [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
- [ ] [STM32CubeProg](https://www.st.com/en/development-tools/stm32cubeprog.html)
- [ ] [STMicroelectronics/OpenOCD](https://github.com/STMicroelectronics/OpenOCD)

## How to use

It's as simple as...

```bash
# tap the repository
$ brew tap osx-cross/stm32

# install the cask or formula you want
$ brew cask install {formula}

# for example
$ brew cask install stm32cubemx
```

Casks available:

- `stm32cubeide`
- `stm32cubemx` (app & command line)

## Caveats

- `stm32cubeide` only supports [64-bit OS versions](https://www.st.com/resource/en/user_manual/dm00603964-stm32cubeide-installation-guide-stmicroelectronics.pdf), so macOS Mojave & Catalina
- `stm32cubemx` needs to launch the installer (and uninstaller), the process is not automatic because of [this](https://community.st.com/s/question/0D50X0000BXlh6qSQB/problem-loading-stm32cubemx-on-mac)
- `stm32cubemx` needs OpenJDK 8 / Java Run Time Environment 1.8 - it seems to work with OpenJDK 13

## Note to ST's teams

ST doesn't make it easy for users to download software without creating an account. Liberty has been taken to host the software on Dropbox and Bintray. If this violates anything, please open an issue and it will be removed.

## License

### ST

ST's work under [ST's License Agreement](https://www.st.com/resource/en/license_agreement/dm00218346.pdf)

### Casks & Formulae

```txt
Copyright 2020 osx-cross (http://github.com/osx-cross)

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
