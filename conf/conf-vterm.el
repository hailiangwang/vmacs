;; brew install libvterm
;; https://github.com/akermu/emacs-libvterm
;; mkdir -p build
;; cd build
;; cmake -DEMACS_SOURCE=~/repos/emacs ..
;; make
(setq-default vterm-keymap-exceptions '("C-x" "C-u" "C-g" "C-h" "M-x" "M-o" "C-v" "M-v" "C-c"))
(require 'vterm)
(define-key vterm-mode-map (kbd "s-t")   #'vterm)
(define-key vterm-mode-map (kbd "C-c C-c")   #'(lambda()(interactive) (vterm-send-key "c" nil nil t)))

(defun vmacs-vterm-hook()
  )
(add-hook 'vterm-mode-hook 'vmacs-vterm-hook)

(provide 'conf-vterm)
