;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; setup load path
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/themes/")
(add-to-list 'load-path "~/.emacs.d/emacs-jabber-0.8.0")
(add-to-list 'load-path "~/.emacs.d/haskell-mode/")
(add-to-list 'load-path "~/.emacs.d/emacs-wiki-2.72/")


;; don't show splash
(setq inhibit-splash-screen t)

;; strip the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; column numbers
(column-number-mode 1)

;; colors
(require 'color-theme-wombat)
(color-theme-wombat)

;; javascript mode
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode" t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

;; php mode
(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

;; haskell mode modules
(autoload 'haskell-mode "haskell-mode" "Haskell editing mode" t)
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(autoload 'turn-on-haskell-doc-mode "haskell-doc" nil t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-font-lock)

;; enable terminal colors in 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Swank-Clojure Jars
(setq swank-clojure-classpath '("~/clojure/clojure.jar" "~/clojure-contrib/clojure-contrib.jar" "~/.emacs.d/swank-clojure/src/"))

;; add SBCL to slime lisp implementations
;; (add-to-list 'slime-lisp-implementations '(sbcl ("/usr/bin/sbcl")))

;; Java Annotations
(require 'java-mode-indent-annotations)
(add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)

;; xml file extensions
(add-to-list 'auto-mode-alist '("\\.xsd$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.wsdl$" . xml-mode))

;; Jabber
(require 'jabber-autoloads)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jabber-account-list (quote (("youngnh@gmail.com/emacs" (:network-server . "talk.google.com") (:connection-type . ssl)) ("nyoung@revelytix.com/emacs" (:network-server . "talk.google.com") (:connection-type . ssl))))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; MediaWiki editing
(require 'emacs-wiki)
(setq mediawiki-url "https://revelytix.servehttp.com:553/w/index.php")
(require 'mediawiki)