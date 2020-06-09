;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

(setq debug-on-error t
      backup-inhibited t
      make-backup-files nil
      auto-save-default nil
      auto-save-list-file-prefix nil
      load-prefer-newer t
      ring-bell-function 'ignore
      sentence-end-double-space nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


(setq package-archives '(
        ("gnu"   . "http://elpa.emacs-china.org/gnu/")
        ("melpa" . "http://elpa.emacs-china.org/melpa/")
        ("marmalade" . "http://elpa.emacs-china.org/marmalade/")))

(package-initialize)

(defun packages-require (&rest packs)
  "Install and load a package. If the package is not available
   installs it automaticaly."
  (mapc (lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
	packs))


(packages-require
 'paredit
 'company
 'rainbow-delimiters
 )


(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode t)
	    (rainbow-delimiters-mode t)
	    (show-paren-mode 1)))
(add-hook 'lisp-interaction-mode
	  (lambda ()
	    (paredit-mode t)
	    (rainbow-delimiters-mode t)
	    (show-paren-mode 1)))


(require 'ielm)

(defun ielm/clear-repl ()
  "Clear current REPL buffer"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (ielm-send-input)))

(define-key inferior-emacs-lisp-mode-map
  (kbd "M-RET")
  #'ielm-return)
(define-key inferior-emacs-lisp-mode-map
  (kbd "C-j")
  #'ielm-return)
(define-key inferior-emacs-lisp-mode-map
  (kbd "RET")
  #'electric-newline-and-maybe-indent)
(define-key inferior-emacs-lisp-mode-map
  (kbd "<up>")
  #'previous-line)
(define-key inferior-emacs-lisp-mode-map
  (kbd "<down>")
  #'next-line)
(define-key inferior-emacs-lisp-mode-map
  (kbd "C-<up>")
  #'comint-previous-input)
(define-key inferior-emacs-lisp-mode-map
  (kbd "C-<down>")
  #'comint-next-input)
(define-key inferior-emacs-lisp-mode-map
  (kbd "C-c C-q")
  #'ielm/clear-repl)


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file) 
  (load custom-file))

(provide 'init)
