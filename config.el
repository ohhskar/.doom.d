;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Oscar Vian Valles"
      user-mail-address "oscarvianvalles@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "Terminus" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 12 :weight 'light)
      doom-big-font (font-spec :family "Terminus" :size 32 :weight 'regular)
      )
(setq-default line-spacing 5)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/personal/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq-default scroll-margin 32)
(setq-default tab-width 2)
(setq
 projectile-project-search-path '(("~/Projects/" . 2))
 org-ellipsis " ▾ "
 org-superstar-headline-bullets-list '("⁖")
 org-superstar-prettify-item-bullets nil
 )
(after! org
  (set-face-attribute 'org-level-1 nil
                      :height 1.2
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      :height 1.15
                      :weight 'bold)
  (set-face-attribute 'org-level-3 nil
                      :height 1.1
                      :weight 'bold)
  (set-face-attribute 'org-level-4 nil
                      :height 1.05
                      :weight 'bold)
  (set-face-attribute 'org-level-5 nil
                      :weight 'bold)
  (set-face-attribute 'org-level-6 nil
                      :weight 'bold)
  (set-face-attribute 'org-document-title nil
                      :height 1.75
                      :weight 'bold)
  )

(setq-hook! 'web-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)

(setq langtool-http-server-host "localhost"
      langtool-http-server-port 8082)
(setq langtool-default-language "en-US")
(setq langtool-disabled-rules "WHITESPACE_RULE")

(use-package! evil-colemak-basics
  :after evil evil-snipe
  :init
  (setq evil-colemak-basics-layout-mod `mod-dh) ; Swap "h" and "m"
  (setq evil-colemak-basics-char-jump-commands 'evil-snipe)
  :config
  (global-evil-colemak-basics-mode) ; Enable colemak rebinds
  )
(after! evil

  (map! :map evil-window-map
        (:leader
         (:prefix ("w" . "Select Window")
          :n :desc "Left"  "m" 'evil-window-left
          :n :desc "Up"    "e" 'evil-window-up
          :n :desc "Down"  "n" 'evil-window-down
          :n :desc "Right" "i" 'evil-window-right
          ))
        ))

(setq lsp-eslint-auto-fix-on-save t)
(defun lsp--eslint-before-save (orig-fun)
  "Run lsp-eslint-apply-all-fixes and then run the original lsp--before-save."
  (when lsp-eslint-auto-fix-on-save (lsp-eslint-apply-all-fixes))
  (funcall orig-fun))

(advice-add 'lsp--before-save :around #'lsp--eslint-before-save)
