(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme/")
(add-to-list 'load-path "~/.emacs.d/color-theme/themes/")
(add-to-list 'load-path "~/.emacs.d/sml-mode/")

;; turn off audible bell
(setq visible-bell t)

;; don't show splash
(setq inhibit-splash-screen t)

;; strip the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; column numbers
(column-number-mode 1)

;; don't wrap lines
(setq-default truncate-lines t)

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; colors
(require 'color-theme-wombat)
(color-theme-wombat)

;; Haskell mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; javascript mode
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode" t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

;; php mode
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))

;; SML mode
(autoload 'sml-mode "sml-mode" "Major mode for editing SML." t)
(autoload 'run-sml "sml-proc" "Run an inferior SML process." t)
(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))

;; n3 mode
(autoload 'n3-mode "n3-mode" "Major mode for editing OWL or N3 files" t)
(add-hook 'n3-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.\\(n3\\|owl|ttl\\)\\'" . n3-mode))

;; enable terminal colors in 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Java Annotations
(require 'java-mode-indent-annotations)
(add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)

;; xml file extensions
(add-to-list 'auto-mode-alist '("\\.xsd$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.wsdl$" . xml-mode))

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

;; Org Mode settings
(setq org-log-done 'time)

;; Save Action
(defun iwb ()
  "indent whole buffer"
  (interactive)
  ;; can't do this because commas are whitespace in clojure-mode (even ;; in string literals)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; paredit in lisp modes
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda ()
                               (paredit-mode +1)
                               (add-hook 'local-write-file-hooks 'iwb)))
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

(setq swank-clojure-classpath '("~/clojure/clojure.jar" "~/clojure-contrib/clojure-contrib.jar" "~/swank-clojure/swank-clojure.jar"))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "#559944"))))
 '(diff-changed ((nil nil)))
 '(diff-context ((((class color grayscale) (min-colors 88)) nil)))
 '(diff-file-header ((((class color) (min-colors 88) (background dark)) (:background "dark5" :foreground "royalblue" :weight bold))))
 '(diff-function ((t (:foreground "#00bbdd"))))
 '(diff-header ((((class color) (min-colors 88) (background dark)) (:background "dark5" :foreground "royalblue1"))))
 '(diff-hunk-header ((t (:foreground "#fbde2d"))))
 '(diff-indicator-changed ((t (:inherit diff-changed))))
 '(diff-nonexistent ((t (:inherit diff-file-header))))
 '(diff-refine-change ((((class color) (min-colors 88) (background dark)) (:background "dark"))))
 '(diff-removed ((t (:foreground "#de1923")))))
