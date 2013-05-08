(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings slime slime-repl scratch clojure-mode groovy-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; kill underlining, auto-fill, "pretty" symbols
(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(remove-hook 'prog-mode-hook 'esk-local-comment-auto-fill)
(remove-hook 'text-mode-hook 'turn-on-auto-fill)
(remove-hook 'clojure-mode-hook 'esk-pretty-fn)

;; Load Wombat theme
(load-theme 'wombat)

;; so I can more easily tell where I am in a file
(when window-system
  (blink-cursor-mode 1))

;; blind old man
(text-scale-increase 1)
(set-face-attribute 'default nil :height 140)

;; don't wrap lines
(setq-default truncate-lines t)

;; don't try to outguess what file I want to visit
(setq ido-use-filename-at-point nil)

;; column numbers
(setq column-number-mode t)

;; alter what is displayed in a dired buffer
(setq dired-listing-switches "-alh")

;; On a regular Mac keyboard, map Command to Meta and Option to Super
;; from http://batsov.com/articles/2012/10/14/emacs-on-osx/
;; and 
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

;; clojure-mode indentation
(add-hook 'clojure-mode-hook
          '(lambda () (define-clojure-indent
                   (let->> 1)
                   (local 1)
                   (plan-context 1)
                   (map-context 1)
                   (optimize-context 1)
                   (results-context 1)
                   (record-case 1)

                   (case-inf 1)
                   (run 2)
                   (run* 1)
                   (fresh 1)
                   
                   (query+ 1)
                   (frame+ 1)
                   (join+ 1)
                   (union+ 1)
                   (criteria+ 1)
                   (project+ 1)
                   (bind+ 1)
                   (remote+ 1))
             ;; don't reindent when I hit enter, I may want to preserve my manual formatting
             (define-key clojure-mode-map (kbd "RET") 'newline-and-indent)))

;; Clojure mode when opening ClojureScript files
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode))

;; don't reindent when I hit enter, I may want to preserve my manual formatting
(define-key lisp-mode-shared-map (kbd "RET") 'newline-and-indent)

;; bind the incredibly satisfying to use `align-regexp` command
(global-set-key (kbd "C-x a r") 'align-regexp)

;; rgrep is indispensable
(global-set-key (kbd "C-x C-r") 'rgrep)

;; Start a shell
(global-set-key (kbd "C-x M-m") 'shell)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; enable these magnificently useful commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Haskell mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Note when an Org Mode TODO was completed
(setq org-log-done 'time)

(defun slime-send-shell-dwim (arg)
  "Send the appropriate forms to be evaluated"
  (interactive "P")
  (save-excursion
    (cond
     ;; Region selected - evaluate region
     ((not (equal mark-active nil))
      (copy-region-as-kill (mark) (point)))

     ;; At/before sexp - evaluate next sexp
     ((or (looking-at "\s(")
          (save-excursion
            (ignore-errors (forward-char 1))
            (looking-at "\s(")))
      (forward-list 1)
      (let ((end (point))
            (beg (save-excursion
                   (backward-list 1)
                   (point))))
        (copy-region-as-kill beg end)))

     ;; At/after sexp - evaluate last sexp
     ((or (looking-at "\s)")
          (save-excursion
            (backward-char 1)
            (looking-at "\s)")))
      (if (looking-at "\s)")
          (forward-char 1))
      (let ((end (point))
            (beg (save-excursion
                   (backward-list 1)
                   (point))))
        (copy-region-as-kill beg end)))

     ;; Default - evaluate enclosing top-level sexp
     (t (progn
          (while (ignore-errors (progn
                                  (backward-up-list)
                                  t)))
          (forward-list 1)
          (let ((end (point))
                (beg (save-excursion
                       (backward-list 1)
                       (point))))
            (copy-region-as-kill beg end)))))
    (set-buffer (get-buffer "*shell*"))
    (unless (eq (current-buffer) (window-buffer))
      (pop-to-buffer (current-buffer) t))
    (goto-char (point-max))
    (yank)
    (unless arg (progn
                  (comint-send-input)
                  (other-window 1)))))

(add-hook 'clojure-mode-hook '(lambda () (define-key clojure-mode-map [f7] 'slime-send-shell-dwim)))

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
 '(magit-item-highlight ((t (:inherit nil)))))
