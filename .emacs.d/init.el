;;; init.el --- Custom init.el

;;; Commentary:

;; This is a custom init.el for Emacs daily use

;;; Code:

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
             '("melpa" . "https://melpa.org/packages/") t)

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

;; Enable use-package
(eval-when-compile
(require 'use-package))

;; Check and install missing packages if needed
(setq use-package-always-ensure t)

;; Checks for package update
(use-package auto-package-update
  :config
  (auto-package-update-maybe)
  (setq auto-package-update-delete-old-versions t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN - Theme / Look'n'feel settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Nice mode line, with nice theme
(use-package smart-mode-line-powerline-theme
  :config (setq sml/theme 'powerline
                sml/no-confirm-load-theme t))

(use-package smart-mode-line
  :config (sml/setup))

;; Use custom theme
;; (use-package zenburn-theme
;;  :config (load-theme 'zenburn t))

(use-package purp-theme
  :config (load-theme 'purp t))

;; No toolbar / menubar
(tool-bar-mode -1)
(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Theme / Look'n'feel settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN - Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Everywhere completion
(use-package counsel
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-height 20
        ivy-count-format "(%d/%d) "
        ivy-display-style 'fancy
        ivy-format-function 'ivy-format-function-line
        ivy-extra-directories nil
        ivy-use-selectable-prompt t
        ivy-re-builders-alist
            '((ivy-switch-buffer . ivy--regex-plus)
              (t . ivy--regex-fuzzy))
        ivy-initial-inputs-alist nil)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-c s") 'counsel-tramp)
  (global-set-key (kbd "C-c C-r") 'ivy-resume))

(use-package counsel-tramp)
(use-package counsel-bbdb)
(use-package counsel-dash)
(use-package counsel-gtags)
(use-package ivy-gitlab)
(use-package ivy-todo)
(use-package flyspell-correct-ivy)

(use-package flycheck
  :init (global-flycheck-mode)
  :config (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package all-the-icons)
(use-package all-the-icons-dired
  :config (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
(use-package all-the-icons-ivy
  :config (all-the-icons-ivy-setup))

;; Code completion
(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map (kbd "RET") nil)
  (setq company-idle-delay 0.125
        company-minimum-prefix-length 1
        company-require-match nil
        company-transformers '(company-sort-by-occurrence)
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-frontend
                            company-echo-metadata-frontend)
        company-tooltip-limit 15
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
        company-tooltip-flip-when-above t))

;; Additional completion packages
(use-package company-flx
  :config (company-flx-mode +1))
(use-package company-ansible)
(use-package company-dict)
(use-package company-edbi)
(use-package company-emoji)
(use-package company-jedi)
(use-package company-lua)
;(use-package company-lsp)
;(use-package company-nixos-options)
(use-package company-quickhelp)
(use-package company-restclient)
(use-package company-shell)
(use-package company-statistics)
(use-package company-tern)
(use-package company-try-hard)
(use-package company-web)

;; Gtags
(use-package ggtags
  :config (setq ggtags-executable-directory "/usr/bin"
                ggtags-use-idutils t
                ggtags-use-project nil
                ggtags-global-mode 1
                ggtags-oversize-limit 104857600 ;; Allow very large database files
                ggtags-sort-by-nearness t))

(use-package docker-tramp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Displays key binding for current mode
(use-package discover-my-major
  :bind (("C-h C-m" . discover-my-major)
         ("C-h M-m" . discover-my-mode)))

;; Org mode
(use-package org
  :bind (("\C-cl" . org-store-link)
         ("\C-cl" . org-agenda))
  :config (setq org-log-done t))

;; Git integration
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

;; Nice package to automatically disassemble java .class files
(use-package autodisass-java-bytecode)

;; Other useful modes
(use-package markdown-mode+)
(use-package markdown-toc)
(use-package json-mode)
(use-package nix-mode)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package yaml-mode)
(use-package adoc-mode)

(use-package pdf-tools)
(pdf-tools-install)

(use-package indium)

(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

(use-package logview)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Custom packages
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
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 90
                    :weight 'normal
                    :width 'normal)
;;(set-default-font "-*-Hack-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

;; Disable toolbar
(if window-system
    (tool-bar-mode -1))

;; Check TLS certs
(setq tls-checktrust t)
(setq gnutls-verify-error t)


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
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-splash-screen t
      initial-scratch-message nil)

;; Encoding and line endings
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8-unix)

;; Show matching parenthesis
(show-paren-mode 1)

;; Delete marked text on typing
(delete-selection-mode t)

;; Soft-wrap lines
(global-visual-line-mode t)

;; No fucking tabs for indent
(setq-default indent-tabs-mode nil)

;; Indent with 4 spaces
(setq-default tab-width 4)

(setq backup-by-copying t)

;; Save mini-buffer command history
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)

;; Save recent files history
(require 'recentf)

(recentf-mode t)
(setq recentf-max-menu-items 50)
(setq recentf-max-saved-items 5000)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; Also save ring history
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

;; Set where history are saved
(setq savehist-file (concat user-emacs-directory "savehist"))

;; Fix path for NixOS
;(setq exec-path (append exec-path '("/run/current-system/sw/bin")))

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
      ediff-split-window-function 'split-window-horizontally
      ediff-merge-split-window-function 'split-window-horizontally
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; Tramp

;; SSH by default for remote host access
(setq tramp-default-method "ssh")
(setq tramp-copy-size-limit 1240)
;; No tramp history file on remote host 
(setq tramp-histfile-override t)

(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)

;; Dired

;; Try to guess destination path using splitted window
(setq dired-dwim-target t)

;; Eshell

;; Nice ehancements
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/aweshell"))
(require 'aweshell)
(setq eshell-up-print-parent-dir t)

;; Dark theme for shell
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-dakrone "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-dakrone))

;; Use Ivy for tab completion
;; https://emacs.stackexchange.com/a/27871
(add-hook 'eshell-mode-hook
  (lambda () 
    (define-key eshell-mode-map (kbd "<tab>")
      (lambda () (interactive) ('completion-at-point)))))

;; Update PATH
;; (add-to-list 'exec-path "/data/scripts/sh")

;; Proxy environment variables for Eshell
;; (setenv "http_proxy" "http://127.0.0.1:8118")
;; (setenv "https_proxy" "http://127.0.0.1:8118")

;; Docker environment variables for Eshell
(setenv "DOCKER_HOST" "tcp://127.0.0.1:2375")
(setenv "DOCKER_PROXY" "http://docker.for.win.localhost:8118")

;; customization settings
(setq custom-file "~/.emacs.d/custom.el")
    (unless (file-exists-p custom-file)
  (with-temp-buffer
    (insert ";;; custom.el --- local customization\n")
    (write-file custom-file t)))
(load custom-file)

;;; init-el ends here
