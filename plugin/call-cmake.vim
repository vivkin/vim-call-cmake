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
	let g:cmake_build_dir = 'build/'
endif

if !exists("g:cmake_build_args")
	let g:cmake_build_args = '-j 4'
endif

function! s:CMake(build_dir, ...)
	if filereadable("CMakeLists.txt")
		if !isdirectory(a:build_dir)
			if !mkdir(a:build_dir)
				return
			endif
		endif
		execute '!(cd ' . fnameescape(a:build_dir) . ' && cmake ' . join(a:000) . ' ..)'
		if v:shell_error == 0
			let g:cmake_build_dir = a:build_dir
			let &makeprg = 'cmake --build ' . g:cmake_build_dir . ' -- ' . g:cmake_build_args
		endif
	else
		echoerr 'CMakeLists.txt not found'
	endif
endfunction

function! s:CMakeHelp(command)
	execute 'vnew'
	execute 'read !cmake --help-command ' . a:command
	set nomodified
	set readonly
endfunction

if !exists(":CMake")
	command! -nargs=* CMake call s:CMake(g:cmake_build_dir, <f-args>)
	command! -nargs=* CMakeDebug call s:CMake('debug/', '-DCMAKE_BUILD_TYPE=Debug', <f-args>)
	command! -nargs=* CMakeRelease call s:CMake('release/', '-DCMAKE_BUILD_TYPE=Release', <f-args>)
	command! -nargs=1 CMakeHelp call s:CMakeHelp(<f-args>)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
