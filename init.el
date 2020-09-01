(menu-bar-mode 0)
(toggle-scroll-bar 0)
(tool-bar-mode 0)

(setq kill-buffer-query-functions nil)

(defun set-font (name size)
  "Set font-family to NAME with SIZE."
  (set-frame-font (concat name " " (number-to-string size)) nil t))

(set-font "Victor Mono Nerd Font" 12)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents)
  (load-file "~/.emacs.d/init.el")
  (all-the-icons-install-fonts)
  (kill-emacs))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package evil
  :ensure t
  :hook
  (prog-mode . evil-mode)
  (pdf-view-mode . evil-mode)
  :init (setq evil-want-keybinding nil))

(use-package evil-multiedit
  :ensure t
  :bind
  (:map evil-visual-state-map
	("R" . 'evil-multiedit-match-all)))

(use-package evil-org
  :after org
  :ensure t
  :init (evil-collection-init))

(use-package evil-collection
  :ensure t
  :after evil)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold nil
	doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config)
  (when doom-themes-enable-italic
    (set-face-attribute 'font-lock-comment-face nil :slant 'italic)))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :after doom-themes
  :config
  (setq doom-modeline-enable-word-count t
	doom-modeline-buffer-encoding nil
	doom-modeline-height 30))

(use-package all-the-icons :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")))
  (setq dashboard-banner-logo-title "Δ M A C S "
	dashboard-startup-banner "~/.emacs.d/logo-small.png"
	dashboard-center-content t
	dashboard-show-shortcuts t
	dashboard-set-heading-icons t
	dashboard-set-file-icons t
	show-week-agenda-p t
	dashboard-items '(
			  (projects . 5)
			  (recents . 5)
			  (agenda . 5)
			 )
	dashboard-set-navigator nil
	dashboard-set-footer nil))

(use-package smooth-scrolling
  :ensure t
  :init (smooth-scrolling-mode 1))

(use-package which-key
  :ensure t
  :init (which-key-mode 1)
  :config
  (which-key-setup-side-window-bottom))

(defun insert-file-name ()
  (interactive)
  (insert (ido-read-file-name "Insert filename: ")))

(use-package projectile
  :ensure t
  :init
    (projectile-mode 1))

(use-package vterm
  :ensure t)

(use-package magit
  :ensure t
  :bind (:map text-mode-map
	      ("C-x g" . 'magit-status)))

(use-package darkroom
    :ensure t
    :bind (:map prog-mode-map
		("C-M-z" . 'darkroom-mode)))

(ido-mode 1)
(setq ido-enable-flex-matching t)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1)
  :config
  (setq ido-vertical-show-count t))

(use-package ido-sort-mtime
  :ensure t
  :init
  (ido-sort-mtime-mode 1))

(use-package smex
  :ensure t
  :bind
  (:map global-map
	("M-x" . 'smex)
	("M-X" . 'smex-major-mode-commands)))

(use-package helpful
  :ensure t
  :bind
  (:map global-map
	("C-h f" . #'helpful-callable)
	("C-h v" . #'helpful-variable)
	("C-h k" . #'helpful-key)))

(use-package ranger
  :ensure t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'global-hl-line-mode )

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :bind
  (:map prog-mode-map
	("C-<tab>" . 'company-complete)))

(use-package format-all
  :ensure t
  :init (format-all-mode 1))

(use-package haskell-mode
  :ensure t
  :bind
  (:map evil-normal-state-map
	("g i" . haskell-navigate-imports)
	("g r" . haskell-mode-find-uses)
	("g d" . haskell-mode-jump-to-def-or-tag))
  (:map haskell-mode-map
	("C-c C-l" . 'haskell-process-load-or-reload)
	("C-`" . 'haskell-interactive-bring)
	("C-c C-t" . 'haskell-process-do-type)
	("C-c C-i" . 'haskell-process-do-info)
	("C-c h" . 'hoogle)
	("C-c C-k" . 'haskell-interactive-mode-clear))
  :hook
  (haskell-mode . interactive-haskell)
  :config
  (setq haskell-process-type 'stack-ghci))

(use-package yaml-mode
  :ensure t)

(use-package fish-mode
  :ensure t)

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package org
  :ensure t
  :config
  (setq org-confirm-babel-evaluate nil
	org-src-window-setup 'other-window)
  (require 'org-tempo))

(org-babel-do-load-languages
 'org-babel-load-languages '(
			     (C . t)
			     (python . t)
			     (js . t)
			     (shell . t)
			     (latex . t)
			     (haskell . t)
			     ))

(use-package htmlize
  :ensure t)

(use-package ox-reveal
  :ensure t)
(setq org-reveal-root
      (concat "file:///" (getenv "HOME") "/.emacs.d/reveal.js"))

(use-package ox-epub
  :ensure t)

(use-package nov
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  )

(use-package pdf-tools
  :ensure t
  :config
    (pdf-loader-install))

(use-package saveplace-pdf-view
  :ensure t
  :config
  (save-place-mode 1))

(use-package interleave
  :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-rpc-virtualenv-path 'current))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
