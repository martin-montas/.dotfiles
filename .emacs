;;; =========================
;;; package system
;;; =========================

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defun ensure-package (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;; =========================
;;; packages
;;; =========================

(mapc #'ensure-package
      '(evil
        evil-collection
        magit
        go-mode
        doom-themes
        vterm
        company))

;;; =========================
;;; ui basics
;;; =========================

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq inhibit-startup-screen t)

(load-theme 'doom-tomorrow-night t)

(set-face-attribute 'default nil
                    :font "Hack"
                    :height 135)

;;; =========================
;;; completion
;;; =========================

(add-hook 'after-init-hook #'global-company-mode)

;;; =========================
;;; recent files
;;; =========================

(recentf-mode 1)

;;; =========================
;;; evil
;;; =========================

(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

;;; =========================
;;; leader key (MUST BE BEFORE USAGE)
;;; =========================

(defvar my/leader-map (make-sparse-keymap)
  "Leader keymap.")

(define-key evil-normal-state-map (kbd "SPC") my/leader-map)
(define-key evil-visual-state-map (kbd "SPC") my/leader-map)
(define-key evil-motion-state-map (kbd "SPC") my/leader-map)
(define-key evil-insert-state-map (kbd "C-SPC") my/leader-map)

;;; =========================
;;; org
;;; =========================

(require 'org)

(setq org-directory "~/personal/slipbox/org/")
(setq org-agenda-files '("~/personal/slipbox/org/"))

(setq org-capture-templates
      '(("t" "Task" entry
         (file "~/personal/slipbox/org/tasks.org")
         "* TODO %?\n  %U")))

(define-key my/leader-map (kbd "oa") #'org-agenda)
(define-key my/leader-map (kbd "oc") #'org-capture)

(define-key my/leader-map (kbd "ot")
  (lambda ()
    (interactive)
    (org-capture nil "t")))

;;; =========================
;;; file navigation
;;; =========================

(require 'project)

(define-key my/leader-map (kbd "ff") #'find-file)
(define-key my/leader-map (kbd "pf") #'project-find-file)
(define-key my/leader-map (kbd "pp") #'project-switch-project)
(define-key my/leader-map (kbd "fr") #'recentf-open-files)

;;; =========================
;;; buffers
;;; =========================

(define-key my/leader-map (kbd "bb") #'switch-to-buffer)
(define-key my/leader-map (kbd "bd") #'kill-current-buffer)

;;; =========================
;;; windows
;;; =========================

(define-key my/leader-map (kbd "h") #'windmove-left)
(define-key my/leader-map (kbd "j") #'windmove-down)
(define-key my/leader-map (kbd "k") #'windmove-up)
(define-key my/leader-map (kbd "l") #'windmove-right)

;;; =========================
;;; dired
;;; =========================

(define-key my/leader-map (kbd "-") #'dired)

;;; =========================
;;; magit
;;; =========================

(define-key my/leader-map (kbd "gg") #'magit-status)

;;; =========================
;;; terminal
;;; =========================

(with-eval-after-load 'vterm
  (define-key my/leader-map (kbd "tt") #'vterm))

;;; =========================
;;; compile
;;; =========================

(define-key my/leader-map (kbd "cc") #'compile)

;;; =========================
;;; config shortcut
;;; =========================

(define-key my/leader-map (kbd "fc")
  (lambda ()
    (interactive)
    (find-file user-init-file)))

;;; =========================
;;; go development
;;; =========================

(require 'go-mode)

(add-hook 'go-mode-hook #'eglot-ensure)

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      #'gofmt-before-save
                      nil
                      t)))

;;; =========================
;;; misc
;;; =========================

(setq backup-files nil)
(setq auto-save-default nil)
(setq make-backup-files nil)

;;; =========================
;;; custom file
;;; =========================

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(load custom-file 'noerror)

;;; =========================
;;; mode line styling
;;; =========================

(set-face-attribute 'mode-line nil
  :background "#1e1e1e"
  :foreground "#ffffff"
  :box nil)

(set-face-attribute 'mode-line-inactive nil
  :background "#2d2d2d"
  :foreground "#888888"
  :box nil)

;;; =========================
;;; PATH (go)
;;; =========================

(setenv "PATH"
        (concat (getenv "PATH") ":"
                (expand-file-name "~/go/bin")))
(add-to-list 'exec-path (expand-file-name "~/go/bin"))
