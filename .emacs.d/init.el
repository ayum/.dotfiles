(setq delete-old-versions t)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq sentence-end-double-space nil)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(setq scroll-preserve-screen-position t)
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)
(setq read-file-name-completion-ignore-case t)
(setq set-mark-command-repeat-pop t)
(setq-default fill-column 88)
(setopt use-short-answers t)

;; They are disabled by default
(put 'delete-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-auto-revert-mode t)
(electric-pair-mode 1)
(delete-selection-mode 1)

;; Save windows and buffers on exit and restore them on start
(desktop-save-mode 1)
(add-hook 'server-after-make-frame-hook
  (lambda () (desktop-read)))

;; Use treesitter for c/c++ modes
(setq major-mode-remap-alist
 '((c-mode . c-ts-mode)
   (c++-mode . c++-ts-mode)
   (c-or-c++-mode . c-or-c++-ts-mode)))

;; Do not show help text on start
(defun display-startup-echo-area-message ()
  (message ""))

;; Dark mode, comment if using theme
(when (display-graphic-p)
  ;; Drop changes from early-init
  (setq default-frame-alist nil)
  ;; Just to invert
  (set-background-color "white")
  (invert-face 'default))
(set-variable 'frame-background-mode 'dark)

;; If you want it
;; (add-to-list 'default-frame-alist '(font . "SourceCodePro" ))
;; (set-face-attribute 'default t :font "SourceCodePro" )

;; Uncomment if using theme, but remember to comment dark mode settings before
;;(use-package spacemacs-theme
;;  :ensure t
;;  :demand t
;;  :config
;;  (load-theme 'spacemacs-dark t))

;;(use-package zenburn-theme
;;  :ensure t
;;  :config
;;  (load-theme 'zenburn t))

(defun ayum/delete-other-window ()
  (interactive)
  (other-window 1)
  (delete-window))

;;(with-eval-after-load 'cc-mode (define-key c-mode-base-map (kbd "/") #'swiper))
;;(with-eval-after-load 'c-ts-mode  (define-key c-ts-base-mode-map (kbd "/") #'swiper))
;;(global-set-key (kbd "C-o") 'pop-to-mark-command)

(define-key mode-specific-map (kbd "/")         'swiper)
(define-key mode-specific-map (kbd "'")         'multi-vterm)
(define-key mode-specific-map (kbd "<right>")   'windmove-right)
(define-key mode-specific-map (kbd "<left>")    'windmove-left)
(define-key mode-specific-map (kbd "<up>")      'windmove-up)
(define-key mode-specific-map (kbd "<down>")    'windmove-down)
(define-key mode-specific-map (kbd "l")         'windmove-right)
(define-key mode-specific-map (kbd "h")         'windmove-left)
(define-key mode-specific-map (kbd "k")         'windmove-up)
(define-key mode-specific-map (kbd "j")         'windmove-down)
(define-key mode-specific-map (kbd "b")         'counsel-switch-buffer)
(define-key mode-specific-map (kbd "w <right>") 'windmove-swap-states-right)
(define-key mode-specific-map (kbd "w <left>")  'windmove-swap-states-left)
(define-key mode-specific-map (kbd "w <up>")    'windmove-swap-states-up)
(define-key mode-specific-map (kbd "w <down>")  'windmove-swap-states-down)
(define-key mode-specific-map (kbd "wl")        'windmove-swap-states-right)
(define-key mode-specific-map (kbd "wh")        'windmove-swap-states-left)
(define-key mode-specific-map (kbd "wk")        'windmove-swap-states-up)
(define-key mode-specific-map (kbd "wj")        'windmove-swap-states-down)
(define-key mode-specific-map (kbd "wo")        'ayum/delete-other-window)
(define-key mode-specific-map (kbd "tn")        'display-line-numbers-mode)
(define-key mode-specific-map (kbd "th")        'hide-mode-line-mode)
(define-key mode-specific-map (kbd "tm")        'meow-normal-mode)
(define-key mode-specific-map (kbd "tt")        'treemacs)
(define-key mode-specific-map (kbd "tr")        'display-fill-column-indicator-mode)
(define-key mode-specific-map (kbd "tw")        'whitespace-mode)
(define-key mode-specific-map (kbd "ts")        'smartparens-strict-mode)
(define-key mode-specific-map (kbd "f")         'select-frame-by-name)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
			 ("gnu"       . "http://elpa.gnu.org/packages/")
			 ("melpa"     . "https://melpa.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package which-key
  :ensure t
  :demand t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-idle-delay 0.01)
  :config
  (which-key-mode))

(defun ayum/meow-line-expand-backward (n)
  "Like `meow-line-expand', but backward by default."
  (interactive "p")
  (meow-line-expand (* -1 n)))

(defun ayum/forward-line-30 (n)
  "Go 30 lines down."
  (interactive "p")
  (let ((m (forward-line (* 30 n))))
    (let ((k (- (* 30 n) m)))
      (if (> 0 n) (scroll-up-line k)
        (scroll-down-line (* -1 k))))))

(defun ayum/backward-line-30 (n)
  "Go 30 lines up."
  (interactive "p")
  (ayum/forward-line-30 (* -1 n)))

(use-package hide-mode-line
  :ensure t
  :commands hide-mode-line-mode)
;;Uncomment to hide by default
;;(global-hide-mode-line-mode t)

;; For pretty icons in treemacs
;;(use-package nerd-icons
;;  :ensure t
;;  :custom
;;  (nerd-icons-font-family "Symbols Nerd Font Mono"))
;;(use-package treemacs-nerd-icons
;;  :ensure t
;;  :after nerd-icons
;;  :config
;;  (treemacs-load-theme "nerd-icons"))
(use-package treemacs
  :ensure t
  :after treemacs-nerd-icons
  :config
  (progn
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always))
  :bind
  (:map treemacs-mode-map
   ("/" . counsel-fzf)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
(use-package vterm
  :ensure t
  :init
  (setq vterm-kill-buffer-on-exit t))
(use-package multi-vterm
  :ensure t
  :config
  (setq multi-vterm-program "bash"))

(use-package ivy
  :ensure t)
(use-package smex
  :ensure t)
(use-package counsel
  :ensure t
  :after (smex ivy)
  :bind (("M-x" . counsel-M-x))
  :config
  (ivy-configure 'counsel-mark-ring
    :sort-fn #'ignore))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.01
        company-minimum-prefix-length 10
        company-global-modes nil)
  :bind (("M-/" . company-complete)))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package eglot
  :hook ((c++-mode c-mode)
         . eglot-ensure)
  :config
;; I see many do this, but i dont know if i need this
;;  (setq eglot-ignored-server-capabilites
;;        '(:documentHighlightProvider ;;no highlight on hover
;;          :inlayHintProvider ;; no argument signatures
;;          ))
  (with-eval-after-load 'eglot
    (add-to-list
      'eglot-server-programs
      '((c-mode c++-mode)
        . ("clangd"
           "-j=4"
           "-background-index"
           "--header-insertion=never"
           "--header-insertion-decorators=0"
           "-log=error"
           "--enable-config"
           "--all-scopes-completion"
           "--completion-style=detailed")))))
