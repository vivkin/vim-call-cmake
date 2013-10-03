vim-call-cmake
==============

Create out of source build dir, call cmake and set makeprg variable

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/vivkin/vim-call-cmake.git

(Thanks Tim Pope for pathogen.vim and this copy-pasted part of useless README)

## Usage

Set current directory which contains root CMakeLists.txt and run `:CMake` with any number of arguments.
Variable `g:cmake_build_dir` holds name of build directory (`build/` by default).
Also avaliable shortcuts for debug `:CMakeDebug` and release `:CMakeRelease` builds.

## License

See `help license`
