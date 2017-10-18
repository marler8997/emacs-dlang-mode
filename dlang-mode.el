
(defvar dlang-keywords
  '("abstract"
    "alias"
    "align"
    "asm"
    "assert"
    "auto"

    "body"
    "bool"
    "break"
    "byte"

    "case"
    "cast"
    "catch"
    "cdouble"
    "cent"
    "cfloat"
    "char"
    "class"
    "const"
    "continue"
    "creal"

    "dchar"
    "debug"
    "default"
    "delegate"
    "delete"
    "deprecated"
    "do"
    "double"

    "else"
    "enum"
    "export"
    "extern"

    "false"
    "final"
    "finally"
    "float"
    "for"
    "foreach"
    "foreach_reverse"
    "function"

    "goto"

    "idouble"
    "if"
    "ifloat"
    "immutable"
    "import"
    "in"
    "inout"
    "int"
    "interface"
    "invariant"
    "ireal"
    "is"

    "lazy"
    "long"

    "macro"
    "mixin"
    "module"

    "new"
    "nothrow"
    "null"

    "out"
    "override"

    "package"
    "pragma"
    "private"
    "protected"
    "public"
    "pure"

    "real"
    "ref"
    "return"

    "scope"
    "shared"
    "short"
    "static"
    "struct"
    "super"
    "switch"
    "synchronized"

    "template"
    "this"
    "throw"
    "true"
    "try"
    "typedef"
    "typeid"
    "typeof"

    "ubyte"
    "ucent"
    "uint"
    "ulong"
    "union"
    "unittest"
    "ushort"

    "version"
    "void"
    "volatile"

    "wchar"
    "while"
    "with"

    "__FILE__"
    "__FILE_FULL_PATH__"
    "__MODULE__"
    "__LINE__"
    "__FUNCTION__"
    "__PRETTY_FUNCTION__"

    "__gshared"
    "__traits"
    "__vector"
    "__parameters"
    ))

(defvar dlang-mode-hook nil)
(defvar dlang-mode-map
  (let ((dlang-mode-map (make-keymap)))
    (define-key dlang-mode-map "\C-j" 'newline-and-indent)
    dlang-mode-map))

(add-to-list 'auto-mode-alist (cons "\\.d\\'" 'dlang-mode))

(defconst dlang-font-lock-keywords
  (list (cons (concat "\\<" (regexp-opt dlang-keywords) "\\>") 'font-lock-keyword-face)))

; for now the tab key will just insert 4 spaces
(defun dlang-indent-line ()
  (insert "    "))

(defvar dlang-mode-syntax-table
  (let ((dlang-mode-syntax-table (make-syntax-table nil)))
    ; This is added so entity names with underscores can be more easily parsed
    (modify-syntax-entry ?_ "w" dlang-mode-syntax-table)

    ; Comment styles are same as C++
    (modify-syntax-entry ?/ ". 124b" dlang-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" dlang-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" dlang-mode-syntax-table)
    dlang-mode-syntax-table))
  
(defun dlang-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map dlang-mode-map)
  (set-syntax-table dlang-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(dlang-font-lock-keywords))
  ;; Register our indentation function
  (set (make-local-variable 'indent-line-function) 'dlang-indent-line)
  (setq indent-tabs-mode nil)
  (setq major-mode 'dlang-mode)
  (setq mode-name "Dlang")
  (run-hooks 'dlang-mode-hook))

(provide 'dlang-mode)
