;;; qob-mode.el --- Major mode for editing Qob files  -*- lexical-binding: t; -*-

;; Copyright (C) 2024-2025  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/cl-qob/qob-mode
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1"))
;; Keywords: lisp qob

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; major mode for editing Qob files.
;;

;;; Code:

(defvar qob-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\; "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?: "_" table)
    table))

(defface qob-mode-symbol-face
  '((t :inherit font-lock-constant-face))
  "Face for highlighting symbols (e.g. :git) in Qob files."
  :group 'qob-mode)

(defconst qob-mode-font-lock-keywords
  `((,(regexp-opt
       '("files" "source" "depends-on")
       'symbols)
     . font-lock-keyword-face))
  "Keywords in Qob file.")

;;;###autoload
(define-derived-mode qob-mode lisp-mode "Qob"
  "Major mode for editing Qob files."
  :syntax-table qob-mode-syntax-table
  (font-lock-add-keywords 'qob-mode qob-mode-font-lock-keywords)
  ;; FIXME: toggling comments only applies to the current line,
  ;; breaking multiline sexps.
  (setq-local comment-start ";; ")
  (setq-local comment-end "")
  (setq-local indent-line-function #'lisp-indent-line))

;;;###autoload
(add-to-list 'auto-mode-alist '("/Qob\\'" . qob-mode))

(provide 'qob-mode)
;;; qob-mode.el ends here
