(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(package-selected-packages
   (quote
    (xterm-color apache-mode json-mode markdown-toc markdown-preview-mode markdown-mode+ autodisass-java-bytecode discover-my-major multi-term monokai-theme helm company-web company-try-hard company-shell company-restclient company-quickhelp company-lua company-emoji company-dict company-ansible company smart-mode-line-powerline-theme auto-package-update use-package)))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "#00ff00"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Begin file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)

;; Add MELPA repository
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Add Marmalade repository
;;(add-to-list 'package-archives
;;    '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Check and install missing packages if needed
(setq use-package-always-ensure t)

;; Checks for package update
(use-package auto-package-update
  :config
  (auto-package-update-maybe)
  (setq auto-package-update-delete-old-versions t))

;; Nice mode line, with nice theme
(use-package smart-mode-line-powerline-theme
  :config (setq sml/theme 'powerline))
(use-package smart-mode-line
  :config (sml/setup))

;; Code completion
(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t))

;; Additional completion packages
(use-package company-ansible)
(use-package company-dict)
(use-package company-emoji)
(use-package company-lua)
(use-package company-quickhelp)
(use-package company-restclient)
(use-package company-shell)
(use-package company-try-hard)
(use-package company-web)

;; Helm for minibuffer completion
(use-package helm
  :config (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("M-<f5>" . helm-find-files)
         ("C-c w" . helm-wikipedia-suggest)))

;; Use custom theme
(use-package monokai-theme
  :config (load-theme 'monokai t))

;; Multi terminal emulation
(use-package multi-term
  :config (setq term-default-bg-color "#000000")
  (setq term-default-fg-color "#00ff00")
  (setq multi-term-program "/bin/fish")
  (add-hook 'term-mode-hook 'toggle-truncate-lines)
  :bind ("<f5>" . multi-term))

;; Displays key binding for current mode
(use-package discover-my-major
  :bind (("C-h C-m" . discover-my-major)
         ("C-h M-m" . discover-my-mode)))

;; Org mode
(use-package org
  :bind (("\C-cl" . org-store-link)
         ("\C-cl" . org-agenda)
         ("M-<f5>" . helm-find-files))
  :config (setq org-log-done t))

;; Nice package to automatically disassemble java .class files
(use-package autodisass-java-bytecode)

;; Other useful modes
(use-package markdown-mode+)
(use-package markdown-preview-mode)
(use-package markdown-toc)
(use-package json-mode)

;; flyspell-popup flyspell-correct-helm
;; flymake-shell flymake-sass flymake-json flymake-jslint flymake-gjshint flymake-css
;; flycheck-pos-tip flycheck-package flycheck-color-mode-line flycheck-checkbashisms flycheck

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End package managements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Maximize frame at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Smart buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Remember place in file when reopening
(save-place-mode 1)

;; Change default font
(set-face-attribute 'default nil :font "Source Code Pro-9")

;; Disable toolbar
(if window-system
    (tool-bar-mode -1))

;; Check TLS certs
(setq tls-checktrust t)
(setq gnutls-verify-error t)

;; Nice Multi-term


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nice keyboard shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Kill current buffer by default (without asking)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Complete shortcut
(global-set-key (kbd "M-/") 'hippie-expand)

;; Nice buffer search
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Regexp searches by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; Always display column number in status line
(setq column-number-mode t)

;; Display line numbers in left margin
;; (global-linum-mode nil)

;; Disable startup screens
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; Encoding and line endings
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8-unix)

;; Show matching parenthesis
(show-paren-mode 1)

;; No fucking tabs for indent
(setq-default indent-tabs-mode nil)

;; Indent with 4 spaces
(setq-default tab-width 4)

;; SSH by default for remote host access
(setq tramp-default-method "ssh")

;; Fix clipboard integration
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      ;; Save whatever’s in the current (system) clipboard before
      ;; replacing it with the Emacs’ text.
      ;; https://github.com/dakrone/eos/blob/master/eos.org
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist '(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; Tramp
(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)

;; Windows specific setup
(if (eq system-type 'windows-nt)
    (progn
      (set-face-attribute 'default nil :font "Consolas-9")
      ;; add cygwin binaries to path
      (if (file-directory-p "c:/tools/cygwin/bin")
          (add-to-list 'exec-path "c:/tools/cygwin/bin"))
      (cond  ((eq window-system 'w32)
          (setq tramp-default-method "sshx")))
      (require 'ssh-agency)))
