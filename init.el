(setq-default
 user-full-name "纪秀峰"                ;记得改成你的名字
 user-login-name "jixiufeng"
 user-mail-address "jixiuf@gmail.com")
(setq load-prefer-newer t)              ;当el文件比elc文件新的时候,则加载el,即尽量Load最新文件文件

;; 测试的时候 配置文件放在 ~/vmacs/内，用下面的命令能加载~/vmacs内的配置
;;  emacs -nw  -q --load ~/vmacs/init.el
(when (file-exists-p "~/vmacs/") (setq user-emacs-directory "~/vmacs/"))  ;default .emacs.d

;; custom-set-variables custom-set-faces 相关配置存放在custom-file指定的文件内
(setq custom-file (concat user-emacs-directory "conf/custom-file.el"))
(load custom-file t t )



;;  第三方package相关配置
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir) (package-refresh-contents))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; ~/.emacs.d/conf/目录加到load-path中
(add-to-list 'load-path (concat user-emacs-directory "conf/"))

(require 'conf-auto-compile)          ;自动编译elisp文件,以加快elisp的加载速度
(require 'conf-package)                 ;make sure package are installed

;; 如果你想重新编译，去掉这行前面的注释重新启动
;; (async-byte-recompile-directory user-emacs-directory)
;; 或者如果在linux 或mac 或 windows上有make rm等一系列命令
;; 可以在本目录下运行以下命令
;; make compile

(require 'conf-lazy-load)               ;autoload相关，加快emacs启动速度

(require 'conf-evil)
(require 'conf-evil-clipboard)
;; mac 上处理evil-mode 与中文输入法
(require 'conf-evil-visual)       ;跟选中区域相关的配置
(require 'conf-evil-window)       ;窗口
(require 'conf-evil-symbol)       ;对symbol 的操作

(with-eval-after-load 'dired (require 'conf-dired)) ;emacs文件浏览器，directory 管理理
(require 'conf-boring-buffer)
(when (member system-type '(gnu/linux darwin)) (require 'conf-sudo))

(require 'conf-scroll)                  ;scroll screen C-v M-v
(when (eq system-type 'darwin) (require 'conf-evil-input-method))


(eval-after-load 'ibuffer '(require 'conf-ibuffer)) ;绑定在space l 上，用于列出当前打开的哪些文件
(require 'conf-bm)              ; 可视化书签功能与跳转功能
(require 'conf-helm)            ;
;; mac 或linux上启用sudo ，用于切换成root或别的用户来编辑当前文件或目录

(when (eq system-type 'darwin) (require 'conf-macos))



;; 一般性的配置在conf/conf-common.el中
(require 'conf-common)
(require 'conf-org)
(with-eval-after-load 'eshell (require 'conf-eshell)) ;

(require 'conf-version-control)         ;版本管理
(require 'conf-company-mode)            ;补全
(require 'conf-yasnippet)               ;模版系统
(require 'conf-yas-auto-insert)         ;利用yasnipet模版,在新建文件时,自动在文件中插入相应的模版

(require 'conf-compile)
(require 'conf-tags)       ;对symbol 的操作
(with-eval-after-load 'magit (require 'conf-magit))
(with-eval-after-load 'go-mode (require 'conf-program-golang))
(with-eval-after-load 'python (require 'conf-program-python))
(with-eval-after-load 'cc-mode (require 'conf-program-objc))
(with-eval-after-load 'protobuf-mode (require 'conf-program-protobuf))


(when (eq system-type 'darwin) (require 'conf-iterm2)) ;iterm2特有的配置

;; Local Variables:
;; coding: utf-8
;; no-byte-compile:t
;; End:

;;; init.el ends here.
