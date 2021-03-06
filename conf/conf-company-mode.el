(require 'company)
(require 'company-posframe)



(with-eval-after-load 'company
  ;; 调整默认backends
  (setq-default company-backends
                `(company-elisp
                  (company-files company-dabbrev company-keywords company-yasnippet)
                company-nxml
                company-css
                company-clang
                company-xcode
                company-cmake
                company-eclim
                company-semantic
                company-capf
                (
                 ;; company-dabbrev-code
                 company-gtags
                 company-etags



                 )
                ;; company-oddmuse ;
                ;; company-bbdb
                ))

   (setq completion-ignore-case t)      ;company-capf匹配时不区分大小写

   ;; 'all 的意思是像 dabbrev-expand 那样搜索所有 buffer 的内容, 而不仅仅是和当前模式相同的buffer里面去搜索.
  (setq-default company-dabbrev-code-other-buffers 'all)
  ;; company-dabbrev-char-regexp 默认的正则表达式是 \sw , 意味着只能匹配单词才能补全, 我重新定制成 [\.0-9a-z-_’/] , 增加搜寻的范围
  (setq-default company-dabbrev-char-regexp "[\\.0-9a-z-_'/]") ;adjust regexp make `company-dabbrev' search words like `dabbrev-expand'
  (setq-default company-idle-delay 0.3)
  (setq company-echo-delay 0)
  (setq company-tooltip-minimum-width 20)
  (setq company-search-regexp-function 'company-search-flex-regexp)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case nil)
  (setq company-dabbrev-other-buffers t)
  (setq company-dabbrev-time-limit 0.5)

  (setq-default company-minimum-prefix-length 2)
  (add-to-list 'company-begin-commands  'backward-delete-char-untabify)
  (add-to-list 'company-begin-commands  'backward-kill-word)
  (setq company-require-match nil)      ;不为nil的话，则如果输入的内容导致无匹配的选项，则不允许此输入
  ;; (define-key company-mode-map (kbd "C-i") 'company-other-backend) ;iterm map to C-i
  ;; (define-key company-mode-map (kbd "C-[ [ 1 h") (key-binding (kbd "C-i"))) ;iterm map to C-i
  (define-key company-active-map (kbd "C-e") #'company-other-backend)
  (define-key company-active-map (kbd "C-s") #'company-filter-candidates)
  (define-key company-active-map (kbd "M-s") #'company-search-candidates)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map [tab] 'vmacs-company-complete-common-or-selection)
  (define-key company-active-map (kbd "TAB") 'vmacs-company-complete-common-or-selection)
  ;; (define-key company-active-map [return]  'vmacs-company-complete-common-or-selection)
  (define-key company-active-map (kbd "C-j")  'company-complete-selection)
  (define-key company-active-map [(meta tab)] 'company-complete-common)
  (define-key company-active-map (kbd "<C-m>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-[ [ 1 m")  'company-complete-selection)
  ;; (define-key company-active-map  (kbd "<return>") nil)
  ;; (define-key company-active-map  (kbd "RET") nil)

  ;; (define-key company-mode-map (kbd "C-:") 'helm-company)
  ;; (define-key company-active-map (kbd "C-:") 'helm-company)
  )
(make-variable-buffer-local 'company-backends)
;; make evil repeat . work with company

(when (fboundp 'evil-declare-change-repeat)
  (mapc #'evil-declare-change-repeat
        '(vmacs-company-complete-common-or-selection)))

(global-company-mode 1)
(company-posframe-mode 1)
;; (add-hook 'after-init-hook (lambda() (global-company-mode 1)))

(defun vmacs-company-complete-common-or-selection()
  (interactive)
  (call-interactively 'company-complete-common)
  (setq this-command 'company-complete-common)
  (when (equal company-prefix company-common)
  (setq this-command 'company-complete-selection)
    (call-interactively 'company-complete-selection)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 扶持使用数字选candidate
(setq company-show-numbers t)
(let ((map company-active-map))
  (mapc
   (lambda (x)
     (define-key map (format "%d" x) 'vmacs-company-number))
   (number-sequence 0 9)))

(defun vmacs-company-number ()
  "Forward to `company-complete-number'.

Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
      (company-complete-number (string-to-number k)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'conf-company-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-company-mode.el ends here.
