;; brew install libvterm
;; https://github.com/akermu/emacs-libvterm
;; mkdir -p build
;; cd build
;; cmake -DEMACS_SOURCE=~/repos/emacs ..
;; make
(require 'vterm)

(defun vmacs-vterm-hook()
  )
(add-hook 'vterm-mode-hook 'vmacs-vterm-hook)

(provide 'conf-vterm)
