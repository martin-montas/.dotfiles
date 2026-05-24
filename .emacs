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
        evil-org
        vertico
        general
        consult
        orderless
        marginalia
        go-mode
        rust-mode
        vterm
        company
        lsp-mode
        project
        modus-themes))

;;; =========================
;;; UI
;;; =========================
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq inhibit-startup-screen t)

(set-face-attribute 'default nil
                    :font "Hack 14")

(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format-buffer nil t)))

;; add this here for c/c++ formatting
(add-hook 'c++-mode-hook #'eglot-ensure)

(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format-buffer nil t)))


;;; =========================
;;; THEME (ONLY ONE ACTIVE)
;;; =========================
(require 'modus-themes)

(setq modus-themes-common-palette-overrides
      '((bg-mode-line "#888888")
        (fg-mode-line "#131313")
        (bg-mode-line-active "#888888")
        (fg-mode-line-active "#131313")
        (bg-mode-line-inactive "#2b2b2b")
        (fg-mode-line-inactive "#888888")))
(load-theme 'modus-vivendi t)
(set-face-attribute 'mode-line nil :background "#939393" :foreground "#131313")
;;; =========================
;;; EVIL CORE
;;; =========================
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

;;; =========================
;;; EVIL ORG
;;; =========================
(with-eval-after-load 'evil-org
  (add-hook 'org-mode-hook #'evil-org-mode)
  (evil-org-set-key-theme '(navigation insert textobjects additional shift todo heading)))

(with-eval-after-load 'org-agenda
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(evil-set-initial-state 'org-mode 'normal)

;;; =========================
;;; completion stack
;;; =========================
(vertico-mode 1)
(marginalia-mode 1)
(recentf-mode 1)

(setq completion-styles '(orderless basic))
(setq completion-category-overrides nil)
(setq consult-preview-key 'any)

(add-hook 'after-init-hook #'global-company-mode)

(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-j") #'vertico-next)
  (define-key vertico-map (kbd "C-k") #'vertico-previous))

;;; =========================
;;; LEADER KEY
;;; =========================
(require 'general)

(setq consult-fd-args
      "fdfind --color=never --hidden --follow --type f --exclude .git")

(general-create-definer my/leader
  :states '(normal visual motion)
  :keymaps 'override
  :prefix "SPC")

(my/leader
  "h"  #'windmove-left
  "j"  #'windmove-down
  "k"  #'windmove-up
  "l"  #'windmove-right

  "ff" #'consult-fd
  "fg" #'consult-ripgrep
  "fb" #'consult-buffer
  "fr" #'consult-recent-file

  "fp" #'project-find-file
  "pp" #'project-dired

  "-"  #'dired
  "gg" #'magit-status
  "tt" #'vterm

  "cc" #'compile
  "bb" #'switch-to-buffer
  "bd" #'kill-current-buffer

  "fe" #'dired-create-empty-file
  "oa" #'org-agenda
  "oc" #'org-capture)

;;; =========================
;;; ORG
;;; =========================
(require 'org)

(setq org-directory "~/personal/slipbox/org/")
(setq org-agenda-files '("~/personal/slipbox/org/"))

(setq org-capture-templates
      '(("t" "Task" entry
         (file "~/personal/slipbox/org/tasks.org")
         "* TODO %?\n  %U")))

;;; =========================
;;; compile
;;; =========================
(defun my/compile-default ()
  (interactive)
  (let ((compilation-read-command nil))
    (compile compile-command)))

;;; =========================
;;; GO
;;; =========================
(require 'go-mode)

(add-hook 'go-mode-hook #'eglot-ensure)

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'gofmt-before-save nil t)))

;;; =========================
;;; misc
;;; =========================
(setq make-backup-files nil)
(setq auto-save-default nil)
(set-face-foreground 'default "#BBBBBB")

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(load custom-file 'noerror)

(setq use-short-answers t)

;;; =========================
;;; PATH
;;; =========================
(setenv "PATH"
        (concat (getenv "PATH") ":"
                (expand-file-name "~/go/bin")))

(add-to-list 'exec-path (expand-file-name "~/go/bin"))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq warning-minimum-level :error)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop))
