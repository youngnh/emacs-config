(require 'font-lock)

(defvar sparql-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?' "\"" table)
    (modify-syntax-entry ?# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?\r ">" table)
    (modify-syntax-entry ?< "(" table)
    (modify-syntax-entry ?> ")" table)
    table))

(defconst sparql-keyword-re
  (regexp-opt '("BASE" "PREFIX" "SELECT" "DISTINCT" "REDUCED"
                "AS" "WHERE" "SERVICE" "GROUP" "BY"
                "HAVING" "ORDER" "ASC" "DESC" "LIMIT"
                "OFFSET" "BINDINGS" "OPTIONAL" "FILTER") 'words)
  "Font lock keywords.")

(defconst sparql-constant-re
  (regexp-opt '("false" "true") 'words)
  "Constant literals.")

(defconst sparql-font-lock-keywords
  (list (list sparql-keyword-re 1 font-lock-keyword-face)
        (list "\\(\\?\\|\\$\\)\\w+" 0 font-lock-variable-name-face t)
        (cons sparql-constant-re font-lock-constant-face)
        (list "<[^<>]*>" 0 font-lock-constant-face t)))

(defun sparql-mode ()
  "Major mode for editing SPARQL queries"
  (interactive)

  (set-syntax-table sparql-mode-syntax-table)

  (set (make-local-variable 'font-lock-defaults)
       (list sparql-font-lock-keywords nil t))

  (setq major-mode 'sparql-mode)
  (setq mode-name "SPARQL"))

(provide 'sparql-mode)