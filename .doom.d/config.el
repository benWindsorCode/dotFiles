;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Ben Windsor"
      user-mail-address "benjaminwindsor@hotmail.com")

(setq browse-url-generic-program "/mnt/c/Program Files \(x86\)/Google/Chrome/Application/chrome.exe")
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-zenburn)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/code/personalMonorepo/org")
(setq gtd-directory (concat org-directory "/gtd"))
(setq roam-directory (concat org-directory "/roam"))
(setq inbox-file (concat gtd-directory "/inbox.org"))
(setq tickler-file (concat gtd-directory "/tickler.org"))
(setq gtd-file (concat gtd-directory "/gtd.org"))
(setq someday-file (concat gtd-directory "/someday.org"))

(setq org-default-notes-file inbox-file)
(setq projectile-project-search-path '("~/Documents/code/"))
;; NOTE: this is NOT recursive, you have to explicitly specify sub directories OR use (setq org-agenda-file (directory-files-recursively org-directory))
(setq org-agenda-files (list org-directory gtd-directory))
(setq org-roam-directory (file-truename roam-directory))

;; Run roam functions on file changes to maintain note consistency. Disable if slowdown.
(org-roam-db-autosync-mode)

(with-eval-after-load 'org

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline inbox-file "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline tickler-file "Tickler")
                               "* %i%? \n %U")))

  (setq org-refile-targets '((gtd-file :maxlevel . 3)
                           (someday-file :level . 1)
                           (tickler-file :maxlevel . 2)))

  (setq org-agenda-custom-commands
	'(("a" agenda "" nil ("agenda.html"))
	  ("n" "Simple agenda view" ((agenda "") (alltodo "")) nil ("agenda_joint.html"))
	  ("w" "Weekly summary"
           ((agenda ""
                    ((org-agenda-ndays 10)))
            (alltodo ""
                     ((org-agenda-ndays 10)
                      (org-agenda-span 3)))
            (todo "DONE"
                    ((org-agenda-ndays 10))))
           nil
           ("agenda_week.html"))))
)

(setq org-todo-keywords '((sequence "TODO(t)" "IN PROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)")))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
