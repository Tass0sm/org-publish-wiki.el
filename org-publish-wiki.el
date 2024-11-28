;; Package

(require 'f)
(require 'dash)
(require 'org)
(require 'org-roam)
(require 'ox-haunt)
(require 'org-roam-export)

(defvar org-publish-wiki-path org-roam-directory
  "Path to wiki that should be published.")

(defvar org-publish-wiki-output-path (if ox-haunt-base-dir
                                         (f-join ox-haunt-base-dir "posts/wiki")
                                       (f-join org-directory "published-wiki"))
  "Path to directory in which wiki should be published.")

;; TODO: Move elsewhere:
(defun org-publish-wiki--get-file-tags (filename)
  "TODO: Write Description"
  (let ((node-ids (org-roam-db-query [:select id :from nodes :where (and (= file $s1) (= level 0))] filename)))
    (org-roam-db-query [:select tag :from tags :where (= node-id $s1)] (caar node-ids))))

(defun org-haunt-publish-to-haunt (plist filename pub-dir)
  "TODO: Write Description"
  (let ((tags (org-publish-wiki--get-file-tags filename)))
    (message (format "%s - %s" filename tags))
    (when (-contains? tags '("publishable"))
      (org-publish-org-to 'haunt filename ".html" plist pub-dir))))

(defun org-publish-wiki-entry (name)
  "Returns the org-publish-alist entry for the wiki"
  (list name
	:base-directory org-publish-wiki-path
	:publishing-directory org-publish-wiki-output-path
        :publishing-function 'org-haunt-publish-to-haunt
	:select-tags '("publishable")))

(defun org-publish-wiki-add-entry (name)
  "Add entry to list.

(org-publish-wiki-add-entry \"my-wiki\")"
  (add-to-list 'org-publish-project-alist (org-publish-wiki-entry name)))

;; Be sure to know: (org-roam-update-org-id-locations)

(provide 'org-publish-wiki)
