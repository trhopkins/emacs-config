; general Emacs settings
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :height 240)
(load-theme 'wombat t)
(setq-default org-enforce-todo-dependencies t)

(setq custom-file "~/.emacs.d/customizations.el")

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

(setq org-capture-templates
      '(("w" "Work" entry (file+headline (concat org-directory "/work.org") "Tasks")
         "* TODO %?\n  %U\n  %a"
         :empty-lines 1)

        ("c" "Code" entry (file+headline "~/Documents/org/code.org" "Tasks")
         "* TODO %?\n  %U\n  %a"
         :empty-lines 1)

        ("h" "Chore" entry (file+headline "~/Documents/org/chores.org" "Tasks")
         "* TODO %?\n  SCHEDULED: %t\n  %U"
         :empty-lines 1)

        ("l" "Leisure" entry (file+headline "~/Documents/org/leisure.org" "Activities")
         "* %?\n  %U"
         :empty-lines 1)

        ("j" "Journal" entry (file+datetree "~/Documents/org/journal.org")
         "* %?\n  Entered on %U\n"
         :empty-lines 1)

        ("n" "Note" entry (file+headline "~/Documents/org/notes.org" "Inbox")
         "* %?\n  %U\n  %i\n  %a"
         :empty-lines 1)))

; steal from https://github.com/MooersLab/emacs-simple-init-org/blob/fb8b922e355cc3ce70c0e72d59028673f19cb43d/init.el#L1829C1-L1843C17?

; Org Babel Geiser Guile setup
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)))

;(setq geiser-default-implementation 'guile)

(require 'package)

(add-to-list 'package-archives
	     '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(use-package geiser
  :ensure t)

(use-package geiser-guile
  :ensure t
  :after geiser
  :config
  (setq geiser-default-implementation 'guile)
  (setq geiser-guile-binary "/usr/bin/guile3.0"))

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode . paredit-mode)
         (scheme-mode . paredit-mode)
         (geiser-repl-mode . paredit-mode))
  :config
  (define-key paredit-mode-map (kbd "C-j") nil))

(add-hook 'geiser-repl-mode-hook
          #'(lambda () (define-key paredit-mode-map (kbd "C-j") 'geiser-repl-maybe-send)))
