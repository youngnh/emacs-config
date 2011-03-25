(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme/")
(add-to-list 'load-path "~/.emacs.d/color-theme/themes/")

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
