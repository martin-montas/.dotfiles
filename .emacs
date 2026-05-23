;; =========================
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
        vertico
        general
        consult
        orderless
        marginalia
        go-mode
        rust-mode
        doom-themes
        vterm
        company
        lsp-mode
        project))

;;; =========================
;;; UI
;;; =========================
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq inhibit-startup-screen t)

(load-theme 'doom-1337 t)

(set-face-attribute 'default nil
                    :font "Iosevka 14")
(set-face-attribute 'mode-line nil
                    :background "#282828"
                    :foreground "#ebdbb2"
                    :box nil)

(set-face-attribute 'mode-line-inactive nil
                    :background "#1d2021"
                    :foreground "#928374"
                    :box nil)

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

;;; =========================
;;; EVIL
;;; =========================
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

;;; =========================
;;; IMPORTANT: free SPC from Evil/others
;;; =========================
(define-key evil-normal-state-map (kbd "SPC") nil)
(define-key evil-visual-state-map (kbd "SPC") nil)
(define-key evil-motion-state-map (kbd "SPC") nil)

;;; =========================
;;; LEADER (ONLY SYSTEM USED)
;;; =========================
(require 'general)
(setq completion-styles '(orderless basic))
(setq completion-ignore-case t)


(setq consult-fd-args
      "fdfind --color=never --hidden --follow --type f --exclude .git")

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

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
  "cc" #'my/compile-default
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

(evil-set-initial-state 'org-mode 'normal)

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

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(load custom-file 'noerror)

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
