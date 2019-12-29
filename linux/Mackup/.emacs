;;======================================== KEYS ========================================

;; quick movement
(global-set-key	(kbd "M-<up>") 'backward-list)
(global-set-key	(kbd "M-<down>") 'forward-list)

;; for xterm-mouse-mode
(global-set-key (kbd "<mouse-4>") 'previous-line)
(global-set-key (kbd "<mouse-5>") 'next-line)
(global-set-key (kbd "<mouse-2>") 'yank)

;;===================================== PACKAGES =====================================

;; this function is missing and must be defined here
(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons
       (car the-plist)
       (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
    alist))

;; load path
;;(add-to-list 'load-path "~/.emacs.d/color-theme-660/")

;; requires
;;(require 'color-theme)
(require 'package)

;; sources
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Added by Package.el.
(package-initialize)
;;(package-refresh-contents)

;; Themes
(color-theme-initialize)
(color-theme-taylor)	;; Current theme

;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "/usr/local/bin/sbcl") ;;ccl64, sbcl
(setq slime-contribs '(slime-fancy))

;;======================================== MODES ========================================

(transient-mark-mode    1) 
(show-paren-mode        1)
(electric-pair-mode     1)
;;(hs-minor-mode          1)
(follow-mode            1)
(save-place-mode        1)
(xterm-mouse-mode       1)
(delete-selection-mode  1)
(visual-line-mode       1)

;;======================================== MISC =======================================

;; disabled command enable
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; indentation
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (color-theme folding doremi-mac slime ##))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;======================================== LINUX =======================================

(menu-bar-showhide-tool-bar-menu-customize-disable)
