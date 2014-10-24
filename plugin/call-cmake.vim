" Vim global plugin for call cmake
" Maintainer:	Ivan Vashchaev <vivkin@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_call_cmake")
	finish
endif
let g:loaded_call_cmake = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:cmake_build_dir")
	let g:cmake_build_dir = 'build'
endif

if !exists("g:cmake_build_args")
	let g:cmake_build_args = '-j ' . system('getconf _NPROCESSORS_ONLN')
endif

function! s:CMake(build_dir, ...)
	if filereadable("CMakeLists.txt")
        let build_dir = fnameescape(a:build_dir)
		execute '!(mkdir -p ' . build_dir . ' && cd ' . build_dir . ' && cmake ' . join(a:000) . ' ' .  getcwd() . ')'
		if v:shell_error == 0
			let &makeprg = 'cmake --build ' . build_dir . ' -- ' . g:cmake_build_args
		endif
	else
		echoerr 'CMakeLists.txt not found'
	endif
endfunction

if !exists(":CMake")
	command! -nargs=* CMake call s:CMake(g:cmake_build_dir, <f-args>)
	command! -nargs=* CMakeDebug call s:CMake(g:cmake_build_dir . '-debug', '-DCMAKE_BUILD_TYPE=Debug', <f-args>)
	command! -nargs=* CMakeRelease call s:CMake(g:cmake_build_dir . '-release', '-DCMAKE_BUILD_TYPE=Release', <f-args>)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
