(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme/")
(add-to-list 'load-path "~/.emacs.d/color-theme/themes/")
(add-to-list 'load-path "~/.emacs.d/slime/")
(add-to-list 'load-path "~/.emacs.d/haskell-mode/")
(add-to-list 'load-path "~/.emacs.d/mmm-mode/")

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

;; colors
(require 'color-theme-wombat)
(color-theme-wombat)

;; multiple major modes
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 0)

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

;; slime
(require 'slime)
(slime-setup '(slime-fancy))

;; clojure mode
(require 'clojure-mode)
;;(require 'clojure-test-mode)

;; Swank-Clojure Jars
(setq clojure-classpath '("~/clojure/clojure.jar" "~/clojure-contrib/clojure-contrib.jar" "~/swank-clojure/swank-clojure.jar"))

(defun clojure-concat-paths (paths)
  (mapconcat 'identity (mapcar 'expand-file-name paths) path-separator))

(defun clojure-init (file encoding)
  (concat
   "(require 'swank.loader)\n\n"
   "(swank.loader/init)\n\n"
   "(require 'swank.swank)\n\n"
   (when (boundp 'slime-protocol-version)
     (format "(swank.swank/ignore-protocol-version %S)\n\n"
             slime-protocol-version))
   ;; Hacked in call to get the localhost address to work around a bug
   ;; where the REPL doesn't pop up until the user presses Enter.
   "(do (.. java.net.InetAddress getLocalHost getHostAddress) nil)"
   (format "(swank.swank/start-server %S :encoding %S)\n\n"
           (expand-file-name file)
           (format "%s" (slime-coding-system-cl-name encoding)))))

;; add SBCL to slime lisp implementations
(add-to-list 'slime-lisp-implementations '(sbcl ("/usr/bin/sbcl")))

;; Clojure is default slime lisp implementation
(require 'assoc)
(setq clojure-cmd (list "java" "-classpath" (clojure-concat-paths clojure-classpath) "clojure.main" "--repl"))
(aput 'slime-lisp-implementations 'clojure (list clojure-cmd :init 'clojure-init))

;; Java Annotations
(require 'java-mode-indent-annotations)
(add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)

;; xml file extensions
(add-to-list 'auto-mode-alist '("\\.xsd$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.wsdl$" . xml-mode))

;; Org Mode settings
(setq org-log-done 'time)
