;;; =========================
;;; PACKAGE SYSTEM
;;; =========================

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;;; ensure package list exists once
(unless package-archive-contents
  (package-refresh-contents))

(defun ensure-package (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;; =========================
;;; CORE PACKAGES
;;; =========================

(mapc #'ensure-package
      '(evil evil-collection magit go-mode))

;;; =========================
;;; UI BASICS
;;; =========================

(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq auto-window-vscroll nil)
(setq windmove-wrap-around t)

(load-theme 'manoj-dark t)

;;; =========================
;;; COMPLETION
;;; =========================

(fido-vertical-mode 1)

;;; =========================
;;; RECENT FILES
;;; =========================

(require 'recentf)
(recentf-mode 1)

;;; =========================
;;; EVIL CONFIG (MUST BE BEFORE evil-mode)
;;; =========================

(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-d-scroll t)

(require 'evil)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

;;; =========================
;;; LEADER KEY SYSTEM
;;; =========================

(defvar my/leader-map (make-sparse-keymap)
  "Global leader keymap.")

(defun my/set-leader-key ()
  "Bind SPC as leader in Evil states."
  (define-key evil-normal-state-map (kbd "SPC") my/leader-map)
  (define-key evil-visual-state-map (kbd "SPC") my/leader-map)
  (define-key evil-motion-state-map (kbd "SPC") my/leader-map))

(with-eval-after-load 'evil
  (my/set-leader-key))

;;; =========================
;;; PROJECT / FILE NAVIGATION
;;; =========================

(require 'project)

(define-key my/leader-map (kbd "ff") #'find-file)
(define-key my/leader-map (kbd "pf") #'project-find-file)
(define-key my/leader-map (kbd "fr") #'recentf-open-files)
(define-key my/leader-map (kbd "bb") #'switch-to-buffer)
(define-key my/leader-map (kbd "-")  #'dired)

;;; =========================
;;; WINDOW NAVIGATION
;;; =========================

(define-key my/leader-map (kbd "h") #'windmove-left)
(define-key my/leader-map (kbd "j") #'windmove-down)
(define-key my/leader-map (kbd "k") #'windmove-up)
(define-key my/leader-map (kbd "l") #'windmove-right)

;;; =========================
;;; MAGIT
;;; =========================

(define-key my/leader-map (kbd "gg") #'magit-status)
(define-key my/leader-map (kbd "gc") #'magit-commit)
(define-key my/leader-map (kbd "gp") #'magit-push)
;;; =========================
;;; CUSTOM SHORTCUTS
;;; =========================

(define-key my/leader-map (kbd "fc")
  (lambda () (interactive)
    (find-file "~/.emacs")))

;;; =========================
;;; MISC
;;; =========================
(define-key my/leader-map  (kbd "cc") #'compile)
(define-key my/leader-map  (kbd "tt") #'vterm)

(setq byte-compile-warnings '(not free-vars unresolved noruntime))
(setq warning-minimum-level :error)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e14289199861a5db890065fdc5f3d3c22c5bac607e0dbce7f35ce60e6b55fc52" "d12b1d9b0498280f60e5ec92e5ecec4b5db5370d05e787bc7cc49eae6fb07bc0" "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93" "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b" "7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9" default))
 '(package-selected-packages '(vterm doom-themes evil evil-collection magit go-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'doom-1337 t)

; Source - https://stackoverflow.com/a/14075788
; Posted by Lluís
; Retrieved 2026-05-18, License - CC BY-SA 3.0

(menu-bar-mode -1)

(defun my-menu-bar-open-after ()
  (remove-hook 'pre-command-hook 'my-menu-bar-open-after)
  (when (eq menu-bar-mode 42)
    (menu-bar-mode -1)))

(defun my-menu-bar-open (&rest args)
  (interactive)
  (let ((open menu-bar-mode))
    (unless open
      (menu-bar-mode 1))
    (funcall 'menu-bar-open args)
    (unless open
      (setq menu-bar-mode 42)
      (add-hook 'pre-command-hook 'my-menu-bar-open-after))))

(global-set-key [f10] 'my-menu-bar-open)

(tool-bar-mode -1)


(set-face-attribute 'mode-line nil
  :background "#1e1e1e"
  :foreground "#ffffff"
  :box nil)

(set-face-attribute 'mode-line-inactive nil
  :background "#2d2d2d"
  :foreground "#888888"
  :box nil)

(scroll-bar-mode -1)


(set-face-attribute 'default nil
  :font "Hack"
  :height 135)
