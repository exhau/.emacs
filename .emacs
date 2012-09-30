(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Okular") (output-html "xdg-open"))))
 '(inhibit-startup-screen t)
 '(preview-auto-cache-preamble nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key [f1] 'hs-toggle-hiding)
(global-set-key [f7] 'compile)
(setq default-frame-alist
'((height . 34) (width . 75) (menu-bar-lines . 20) (tool-bar-lines . 10))) 

(setq indent-tabs-mode t)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96)) 
;; 回车缩进
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;; 显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; 显示列号
(setq column-number-mode t)
;;光标显示为一竖线
(setq-default cursor-type 'bar)

(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
	 (goto-char (point-max))
     (eval-print-last-sexp))))

(el-get 'sync)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)
;; 用xetex引擎而不是默认的引擎（xetex对中文字体的支持好）
(setq TeX-engine 'xetex)
;; 产生pdf而不是dvi
(setq TeX-PDF-mode t)
;;latex中换行自动缩进
(add-hook 'LaTeX-mode-hook (lambda()
        (define-key LaTeX-mode-map "\C-m" 'reindent-then-newline-and-indent)
))
;;reftex目录自动查看
(add-hook 'latex-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)

(add-to-list 'load-path
              "~/.emacs.d/el-get/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;;最好直接修改yasnippet.el(defcustom yas-trigger-key 
;;(setq yas-trigger-key "<C-tab>")

(add-to-list 'load-path "/home/yoh/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/yoh/.emacs.d/auto-complete/ac-dict")
;;(ac-set-trigger-key "TAB") ;
(ac-config-default)

(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of {{{latex-mode}}}
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources))
)
(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

;; (require 'auto-complete-clang)  
;; (setq ac-clang-auto-save t)  
;; ;;(setq ac-auto-start nil)  
;; (setq ac-quick-help-delay 0.5)  
;; ;; (ac-set-trigger-key "TAB")  
;; ;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
;; (defun my-ac-config ()  
;;   (setq ac-clang-flags  
;;         (mapcar(lambda (item)(concat "-I" item))  
;;                (split-string  
;;                 "  
;;  /usr/include/c++/4.6
;;  /usr/include/c++/4.6/x86_64-linux-gnu/.
;;  /usr/include/c++/4.6/backward
;;  /usr/lib/gcc/x86_64-linux-gnu/4.6/include
;;  /usr/local/include
;;  /usr/lib/gcc/x86_64-linux-gnu/4.6/include-fixed
;;  /usr/include/x86_64-linux-gnu
;;  /usr/include 
;; ")))  
;;   (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
;;   (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
;;   ;;(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
;;   (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
;;   (add-hook 'css-mode-hook 'ac-css-mode-setup)  
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
;;   (global-auto-complete-mode t))  
;; (defun my-ac-cc-mode-setup ()  
;;   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources))
;;   ;;(setq ac-auto-start nil)
;;   )  
;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)  
;; ;; ac-source-gtags  
;; (my-ac-config) 

(require 'auto-complete-clang-async)
(defun ac-cc-mode-setup ()
  (setq clang-complete-executable "~/.emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (launch-completion-proc)
)
(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(my-ac-config)


;;加载php-mode
(add-to-list 'load-path "~/.emacs.d/el-get/php-mode")
(require 'php-mode)
;;根据文件扩展名自动php-mode
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
;;开发项目时，php源文件使用其他扩展名
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))

;;这些模式代码折叠
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'ess-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'sh-mode-hook 'hs-minor-mode)


;;GDB调试快捷键
;;(require 'gdb-ui)
(defun gud-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  (kill-process (get-buffer-process gud-comint-buffer))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
             '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 10))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
             '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 10))
  ;;(kill-buffer "*gud-test*")
  (delete-window (get-buffer-window "*gud-test*"))
  (kill-buffer "*compilation*")
  (kill-buffer "*gud-test*")
  ;;(delete-window (get-buffer-window "*compilation*"))
  ;;(kill-buffer-and-window)
)
(defun gud-and-max ()
  (interactive)
  (gdb (gud-query-cmdline 'gdb))
  (my-maximized))
(setq gdb-many-windows t)
;;(global-set-key [f5] 'gdb-or-gud-go)
;;(global-set-key [S-f5] '(lambda () (interactive) (gud-call "quit" nil)))
(global-set-key [f5] 'gud-and-max)
(global-set-key [C-f5] 'gud-run)
(global-set-key [S-f5] 'gud-kill)
(global-set-key [f8] 'gud-print)
(global-set-key [C-f8] 'gud-pstar)
(global-set-key [f9] 'gud-break)
(global-set-key [C-f9] 'gud-remove)
(global-set-key [f10] 'gud-next)
(global-set-key [C-f10] 'gud-until)
(global-set-key [S-f10] 'gud-jump)
(global-set-key [f11] 'gud-step)
(global-set-key [C-f11] 'gud-finish)
