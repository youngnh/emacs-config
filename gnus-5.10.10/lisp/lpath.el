;; Shut up.

(defun maybe-fbind (args)
  (while args
    (or (fboundp (car args))
	(defalias (car args) 'ignore))
    (setq args (cdr args))))

(defun maybe-bind (args)
  (mapcar (lambda (var) (unless (boundp var) (set var nil))) args))

(unless (featurep 'xemacs)
  (defun nnkiboze-score-file (a))
  (maybe-fbind
   '(Info-menu
     cp-supported-codepages delete-annotation glyph-height make-annotation
     make-glyph map-extents set-extent-property set-itimer-function w3-do-setup
     w3-prepare-buffer w3-region w32-focus-frame w3m-detect-meta-charset
     w3m-region window-pixel-height window-pixel-width))

  (when (<= emacs-major-version 22)
    (maybe-fbind '(display-time-event-handler frame-device)))

  (when (= emacs-major-version 21)
    (defun split-line (&optional arg))
    (maybe-fbind
     '(bbdb-complete-name
       custom-autoload delete-extent device-connection dfw-device
       events-to-keys find-coding-system find-face font-lock-set-defaults
       get-char-table glyph-width mail-aliases-setup make-event
       make-network-process message-xmas-redefine put-char-table temp-directory
       unicode-precedence-list url-generic-parse-url url-http-file-exists-p
       url-insert-file-contents valid-image-instantiator-format-p
       vcard-pretty-print w3-coding-system-for-mime-charset))
    (maybe-bind
     '(filladapt-mode
       help-echo-owns-message itimer-list ps-print-color-p url-version
       w3-meta-charset-content-type-regexp
       w3-meta-content-type-charset-regexp))))

(when (featurep 'xemacs)
  (defun nnkiboze-score-file (a))
  (defun split-line (&optional arg))
  (maybe-fbind
   '(codepage-setup
     create-image detect-coding-string display-time-event-handler
     event-click-count event-end event-start find-coding-systems-for-charsets
     find-coding-systems-region find-coding-systems-string find-image
     image-size image-type-available-p insert-image mail-abbrevs-setup
     make-mode-line-mouse-map make-network-process mouse-minibuffer-check
     mouse-movement-p mouse-scroll-subr posn-point posn-window put-image
     read-event rmail-msg-is-pruned rmail-msg-restore-non-pruned-header
     select-safe-coding-system sort-coding-systems track-mouse
     url-generic-parse-url url-http-file-exists-p url-insert-file-contents
     vcard-pretty-print w3m-detect-meta-charset window-edges))
  (maybe-bind
   '(adaptive-fill-first-line-regexp
     buffer-display-table cursor-in-non-selected-windows
     default-enable-multibyte-characters filladapt-mode
     gnus-agent-expire-current-dirs idna-program installation-directory
     line-spacing mark-active mouse-selection-click-count
     mouse-selection-click-count-buffer
     rmail-insert-mime-forwarded-message-function tool-bar-mode
     transient-mark-mode url-version w3-meta-charset-content-type-regexp
     w3-meta-content-type-charset-regexp))

  (when (or (and (= emacs-major-version 21) (= emacs-minor-version 4))
	    (featurep 'sxemacs))
    (maybe-fbind
     '(custom-autoload
       display-graphic-p display-images-p display-visual-class
       replace-regexp-in-string select-frame-set-input-focus
       unicode-precedence-list w32-focus-frame x-focus-frame)))

  (unless (featurep 'mule)
    (maybe-fbind
     '(ccl-execute-on-string
       charsetp coding-system-get get-charset-property pgg-parse-crc24-string
       unicode-precedence-list))
    (maybe-bind
     '(current-language-environment language-info-alist pgg-parse-crc24)))

  (unless (featurep 'file-coding)
    (maybe-fbind
     '(coding-system-base
       coding-system-change-eol-conversion coding-system-list coding-system-p
       find-coding-system))
    (maybe-bind '(buffer-file-coding-system enable-multibyte-characters))))

(provide 'lpath)

;;; arch-tag: d1ad864f-dca6-4d21-aa3f-be3248e66dba
