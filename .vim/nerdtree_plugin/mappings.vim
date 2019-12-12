if exists("g:loaded_nerdtree_custom_maps")
  finish
endif
let g:loaded_nerdtree_custom_maps = 1

call NERDTreeAddKeyMap({
      \ 'key': 'ds',
      \ 'callback': 'NERDTreeDirectorySearchHandler',
      \ 'quickhelpText': 'search in dir by RegExp',
      \ 'scope': 'DirNode' })

call NERDTreeAddKeyMap({
      \ 'key': 'dw',
      \ 'callback': 'NERDTreeDirectorySearchWordHandler',
      \ 'quickhelpText': 'search in dir for word',
      \ 'scope': 'DirNode' })

function! NERDTreeDirectorySearchHandler(dirnode)
  let path = fnamemodify(a:dirnode.path.str(), ':.')
  let query = input('RegExp: ')
  execute 'CtrlSF -R ' . '"' . query . '"' . path
endfunction

function! NERDTreeDirectorySearchWordHandler(dirnode)
  let path = fnamemodify(a:dirnode.path.str(), ':.')
  let query = input('Word: ')
  execute 'CtrlSF -I -W ' . '"' . query . '"' . path
endfunction
