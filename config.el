;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Exuanbo"
      user-mail-address "exuanbo@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-unicode-font (font-spec :family "Source Han Sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; ui
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; theme
(use-package! doom-themes
  :config
  ;;(setq doom-themes-enable-bold nil)
  (load-theme 'doom-one t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; solaire-mode
(use-package! solaire-mode
  :hook
  ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  (minibuffer-setup . solaire-mode-in-minibuffer)
  :config
  (solaire-global-mode +1))

;; all-the-icons-ibuffer
(use-package! all-the-icons-ibuffer
  :defer t
  :init (all-the-icons-ibuffer-mode 1))

;; evil
(setq-default evil-escape-key-sequence "jk"
              evil-escape-delay 0.25)

(setq evil-vsplit-window-right t)

;; which-key
(setq which-key-idle-delay 0.5)

;; company
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

;; lsp-mode
(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))

(after! lsp-mode
  (setq lsp-prefer-capf t
        lsp-idle-delay 0.5))

(after! lsp-pythoon-ms
  (setq lsp-python-ms-executable
        "~/repositories/python-language-server/output/bin/Release/osx-x64/publish/Microsoft.Python.LanguageServer"))

;; org
(after! org
  (setq ;;org-startup-indented nil
        ;;org-indent-indentation-per-level 0
        org-adapt-indentation nil

        org-export-with-sub-superscripts nil
        org-html-doctype "html5"
        org-html-html5-fancy t
        org-html-head-include-default-style nil
        org-html-htmlize-output-type 'css)

  (set-face-attribute 'org-link nil :weight 'normal)
  (set-face-attribute 'org-document-title nil :height 1.75 :weight 'bold)
  (set-face-attribute 'org-level-1 nil :height 1.25)
  (set-face-attribute 'org-level-2 nil :height 1.125)
  (set-face-attribute 'org-level-3 nil :weight 'normal)
  (set-face-attribute 'org-level-4 nil :weight 'normal)
  (set-face-attribute 'org-level-5 nil :weight 'normal)
  (set-face-attribute 'org-level-6 nil :weight 'normal))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))
