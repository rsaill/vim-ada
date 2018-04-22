## Vim Scripts for Ada Programming

### Features

  * Automatic indentation.
  * Completion based on local identifiers and tags with `<C-Space>`.
  * Completion using [adaquery](https://github.com/rsaill/adaquery) with `<C-u>`.
  * [Tagbar](https://github.com/majutsushi/tagbar) integration. Use `<F8>` to toggle the bar.
  * [Syntastic](https://github.com/scrooloose/syntastic) integration:
    * Check syntax using gcc with `<F3>`.
    * Compile current file using gprbuild with `<F4>` (For this you need to adapt the script [adacheckfile](https://github.com/rsaill/vim-ada/blob/master/scripts/adacheckfile) to your needs).
    * Check coding rules using adacontrol with `<F5>` (For this you need to adapt the script [adacontrol](https://github.com/rsaill/vim-ada/blob/master/scripts/adacontrol) to your needs).
  * Project navigation:
    * Jump to spec/body with `<F1>`.
    * Jump to definition using [adaquery](https://github.com/rsaill/adaquery) with `<C-[>`.
    * Preview definition using [adaquery](https://github.com/rsaill/adaquery) with `<C-p>`.
  * [NERDCommenter](https://github.com/scrooloose/nerdcommenter) integration. Use `<F2>` to (un)comment a line.

**Remarks:**
  * For tag-based features, you need to index your files with [universal ctags](https://github.com/universal-ctags) first.
  * For adaquery-based features, you need to index your files with [adaquery](https://github.com/rsaill/adaquery) first.
