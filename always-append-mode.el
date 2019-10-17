;;; always-append-mode.el --- Always append to kill-ring.  -*- lexical-binding: t; -*-

;; Keywords: convenience

;;; Commentary:

;; Always append to kill-ring

;;; Code:

(defun always-append--advice (&rest _args)
  "Advice function passed to `advice-add' and `advice-remove'.
Just call `append-next-kill'. `_ARGS' are ignored."
  (append-next-kill))

(defvar always-append--functions-to-advice
  (list #'kill-region #'kill-ring-save)
  "Functions to advice with `always-append--advice'.")

;;;###autoload
(define-minor-mode always-append-mode
  "Always append to kill-ring.
Create `append-next-kill' advice :before functions in
`always-append--functions-to-advice' variable."
  :global t
  :lighter " AlwaysAppend"
  (if always-append-mode
      (dolist (func always-append--functions-to-advice)
        (advice-add func :before #'always-append--advice))
    (dolist (func always-append--functions-to-advice)
      (advice-remove func #'always-append--advice))))

(provide 'always-append-mode)
;;; always-append.el ends here
