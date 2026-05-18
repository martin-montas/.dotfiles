(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)

(package-initialize)

(menu-bar-mode -1)

;; MUST be before loading evil
(setq evil-want-C-u-scroll t)
(setq evil-want-C-d-scroll t)
(setq evil-want-integration t)
(setq evil-want-keybinding nil)

(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq auto-window-vscroll nil)
