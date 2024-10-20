(setq display-line-numbers-type t)
(setq display-line-numbers 'relative)
;; Note this is accompanied by a line in ~/.bashrc of
;; export BROWSER="powershell.exe /C start"
(setq browse-url-browser-function 'browse-url-generic
 browse-url-generic-program "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe")

(setq org-directory "~/Documents/code/personalMonorepo/org")
(setq gtd-directory (concat org-directory "/gtd"))
(setq inbox-file (concat gtd-directory "/inbox.org"))
(setq tickler-file (concat gtd-directory "/tickler.org"))
(setq gtd-file (concat gtd-directory "/gtd.org"))
(setq someday-file (concat gtd-directory "/someday.org"))
(setq readinglist-file (concat gtd-directory "/readinglist.org"))
(setq archive-file (concat gtd-directory "/archive.org"))

(setq org-default-notes-file inbox-file)
(setq projectile-project-search-path '("~/Documents/code/"))
;; NOTE: this is NOT recursive, you have to explicitly specify sub directories OR use (setq org-agenda-file (directory-files-recursively org-directory))
(setq org-agenda-files (list org-directory gtd-directory))

(with-eval-after-load 'org

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline inbox-file "Tasks")
                               "* TODO %i%?")
				("r" "Reading list" entry (file+headline readinglist-file "Reading List")
				 "* %i%?")
                              ("T" "Tickler" entry
                               (file+headline tickler-file "Tickler")
                               "* %i%? \n %U")))

  (setq org-refile-targets '((gtd-file :maxlevel . 3)
                           (someday-file :level . 1)
			   (readinglist-file :maxlevel . 3)
			   (archive-file :maxlevel . 3)
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

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(use-package! org
  :init
  (map! :leader
        :prefix "n"
        :desc "Org refile" "w" #'org-refile))

(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "IN PROGRESS(i)" "NEXT TASK(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  )

(use-package! org-roam
  :init
  (map! :leader
        :prefix "n"
        :desc "Org roam buffer" "l" #'org-roam-buffer-toggle
        :desc "Org roam insert" "i" #'org-roam-node-insert
        :desc "Org roam find" "f" #'org-roam-node-find
        :desc "Org roam ref find" "r" #'org-roam-ref-find
        :desc "Org roam show graph" "g" #'org-roam-show-graph
        :desc "Org roam capture" "c" #'org-roam-capture)
  (setq org-roam-directory (file-truename "~/Documents/code/personalMonorepo/org/roam"))
     ;;   org-id-link-to-org-use-id t) ;; I disabled this as it added an id to all my org captures
  :config
  (org-roam-db-autosync-mode +1)
  (set-popup-rules!
    `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
      ("^\\*org-roam: " ; node dedicated org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2)))
  (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)
  (setq org-roam-capture-templates
        '(("m" "main" plain
           "%?"
           :if-new (file+head "main/${slug}.org"
                              "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("p" "paper" plain "%?"
           :if-new
           (file+head "papers/${slug}.org" "#+title: ${title}\n#+filetags: :paper:\n")
           :immediate-finish t
           :unnarrowed t)
          ("b" "book" plain "%?"
           :if-new
           (file+head "books/${slug}.org" "#+title: ${title}\n#+filetags: :book:\n")
           :immediate-finish t
           :unnarrowed t)
          ("a" "article" plain "%?"
           :if-new
           (file+head "articles/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n")
           :immediate-finish t
           :unnarrowed t)))
  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))
  (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag))))

(set-file-template! 'org-mode :ignore t)

(use-package! websocket
    :after org-roam)

;; displays in http://127.0.0.1:35901/
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

(map! "<f9>" #'eval-buffer
      "S-<f9>" #'eval-region
      "M-y" #'magit-status
      "M-b" #'+vertico/switch-workspace-buffer
      "M-e" #'projectile-find-file
      "M-w" #'evil-write)
