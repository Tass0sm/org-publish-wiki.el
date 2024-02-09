;; Package

(require 'f)
(require 'org)
(require 'org-roam)
(require 'ox-haunt)
(require 'org-roam-export)

(defvar org-publish-wiki-path org-roam-directory
  "Path to wiki that should be published.")

(defvar org-publish-wiki-output-path (f-join org-directory "published-wiki")
  "Path to directory in which wiki should be published.")

(defun org-publish-wiki-entry (name)
  "Returns the org-publish-alist entry for the wiki"
  (list name
	:base-directory org-publish-wiki-path
	:publishing-directory org-publish-wiki-output-path))

(defun org-publish-wiki-add-entry (name)
  "Add entry to list.

(org-publish-wiki-add-entry \"my-wiki\")"

  (add-to-list 'org-publish-project-alist (org-publish-wiki-entry name)))

;; Be sure to know: (org-roam-update-org-id-locations)

(provide 'org-publish-wiki)
