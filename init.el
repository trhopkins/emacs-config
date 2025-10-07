; Org Mode basic settings
(require 'org)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-cc" 'org-capture)
(setq org-blank-before-new-entry '((heading . t) (plain-list-item . auto)))
(setq org-todo-keywords
      '((sequence "BKLG(b)" "TODO(t!)" "INPR(i!)" "|" "DONE(d!)" "CNCL(c@/!)")) )
(setq org-directory (concat (getenv "HOME") "/Documents/org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-log-into-drawer t)
(setq org-agenda-files (list (concat org-directory "/journal.org")
			 (concat org-directory "/notes.org")
			 (concat org-directory "/chores.org")
			 (concat org-directory "/leisure.org")
			 (concat org-directory "/work.org")
			 (concat org-directory "/code.org") ))
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(setq org-capture-templates
;      '(("w" "Work" entry (file+headline (concat org-directory "/work.org") "Tasks")
;	 "** TODO %?\n  %U\n  %a"
;	 :empty-lines 1)
;	("c" "Code" entry (file+headline (concat org-directory "/code.org") "Tasks")
;	 "** TODO %?\n  %U\n  %a"
;	 :empty-lines 1)
;	("h" "Chore" entry (file+headline (concat org-directory "/chores.org") "Tasks")
;	 "** TODO %?\n  SCHEDULED: %t\n  %U"
;	 :empty-lines 1)
;	("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
;	 "* %?\n  %U\n"
;	 :empty-lines 1)
;	))

(setq org-capture-templates
      `(("t" "Todo" entry (file+headline "~/Documents/org/chores.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree ,(concat org-directory "/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a") ))

; stolen from https://github.com/MooersLab/emacs-simple-init-org/blob/fb8b922e355cc3ce70c0e72d59028673f19cb43d/init.el#L1829C1-L1843C17
(defun org-ask-location ()
  (let* ((org-refile-targets '((nil :maxlevel . 9)))
         (hd (condition-case nil
                 (car (org-refile-get-location "Tag" nil t))
               (error (car org-refile-history)))))
    (goto-char (point-min))
    (outline-next-heading)
    (if (re-search-forward
         (format org-complex-heading-regexp-format (regexp-quote hd))
         nil t)
        (goto-char (point-at-bol))
      (goto-char (point-max))
      (or (bolp) (insert "\n"))
      (insert "* " hd "\n")))
  (end-of-line))

; general Emacs settings
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :height 240)
(load-theme 'adwaita t)
(setq-default org-enforce-todo-dependencies t)
