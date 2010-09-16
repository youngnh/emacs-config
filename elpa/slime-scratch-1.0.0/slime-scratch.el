;;; slime-scratch.el --- Imitate Emacs' *scratch* buffer
;;
;; Copyright (C) 2010 Helmut Eller
;;
;; Author: Helmut Eller <heller@common-lisp.net>
;; Version: 1.0.0
;; Package-requires: ((slime "20100404"))
;;
(defun slime-buffer-name (type &optional hidden)
  (assert (keywordp type))
  (concat (if hidden " " "")
          (format "*slime-%s*" (substring (symbol-name type) 1))))

;;;###autoload
(defun slime-scratch ()
  (interactive)
  (slime-switch-to-scratch-buffer))

(defun slime-switch-to-scratch-buffer ()
  (set-buffer (slime-scratch-buffer))
  (unless (eq (current-buffer) (window-buffer))
    (pop-to-buffer (current-buffer) t)))

(defvar slime-scratch-file nil)

(defun slime-scratch-buffer ()
  "Return the scratch buffer, create it if necessary."
  (or (get-buffer (slime-buffer-name :scratch))
      (with-current-buffer (if slime-scratch-file
                               (find-file slime-scratch-file)
                             (get-buffer-create (slime-buffer-name :scratch)))
        (rename-buffer (slime-buffer-name :scratch))
	(clojure-mode)	
	(slime-mode t)
	(current-buffer))))

(provide 'slime-scratch)
;;; slime-scratch.el ends here