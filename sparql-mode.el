(require 'font-lock)

(defconst sparql-font-lock-keywords
  (list "\\<BASE\\>"
        "\\<PREFIX\\>"
        "\\<SELECT\\>"
        "\\<DISTINCT\\>"
        "\\<REDUCED\\>"
        "\\<AS\\>"
        "\\<WHERE\\>"
        "\\<SERVICE\\>"
        "\\<GROUP\\>"
        "\\<BY\\>"
        "\\<HAVING\\>"
        "\\<ORDER\\>"
        "\\<ASC\\>"
        "\\<DESC\\>"
        "\\<LIMIT\\>"
        "\\<OFFSET\\>"
        "\\<BINDINGS\\>"
        "\\<OPTIONAL\\>"
        "\\<FILTER\\>")
  "Font lock keywords")

(defun sparql-mode ()
  "Major mode for editing SPARQL queries"
  (interactive)

  (set (make-local-variable 'font-lock-defaults)
       (list sparql-font-lock-keywords nil t))

  (setq major-mode 'sparql-mode)
  (setq mode-name "SPARQL"))

(provide 'sparql-mode)