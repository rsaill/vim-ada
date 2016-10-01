# Some scripts for ada programing in vim

## Mappings:

 * \<F1\>: Jump to spec/body
 * \<F2\>: Comment/Uncomment line (requires [NERDCommenter](https://github.com/scrooloose/nerdcommenter)).
 * \<F3\>: Check syntax with gcc (requires [Syntastic](https://github.com/scrooloose/syntastic)).
 * (TODO) \<F4\>: Compile file with gprbuild (requires [Syntastic](https://github.com/scrooloose/syntastic)).
 * (TODO) \<F5\>: Check file with AdaControl (requires [Syntastic](https://github.com/scrooloose/syntastic)).
 * \<F8\>: Toggle Tagbar (requires [Tagbar](https://github.com/majutsushi/tagbar)). (*)
 * \<C-Space\>: Autocompletion based on identifiers in the current file and tags. (*)
 * (TODO) \<C-u\>: Completion based on package name (can be kind on slow). Also this mapping can be used to automatically prefix an identifier with the name of the package in which it is declared.

(*) To produce tag files for ada use [universal ctags](https://github.com/universal-ctags).
