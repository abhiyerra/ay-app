(setq package-user-dir "/ay-app/elpa")
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")))

(package-initialize)
(package-refresh-contents)
(package-install 'elnode)
(package-install 'org)

(require 'org)
(require 'elnode)

(setq ay-server-directory "/webapp")

(defun ay-blog-handler (httpcon)
  "Handler for render the blog file."
  "")

(defun ay-feedback-handler (httpcon)
  "Receive feedback from the user on any part of the site that
might need updated and store it to a file feedback.org which can
be acted on."
  "hello")

(defun ay-handler (httpcon)
  "Demonstration function"
  (elnode-http-start httpcon "200"
                     '("Content-type" . "text/html")
                     `("Server" . ,(concat "GNU Emacs " emacs-version)))
  (elnode-http-return httpcon "<html><body><h1>Hello from Emacs!</h1></body></html>"))

;; (defun ay-handler (httpcon)
;;   (elnode-docroot-for ay-server-directory
;;                       with org-file
;;                       on httpcon
;;                       do (cond ((string= (elnode-http-pathinfo httpcon) "/feedback")
;;                                 (elnode-send-html httpcon (ay-feedback-handler httpconn)))
;;                                ((string= (elnode-http-pathinfo httpcon) "/")
;;                                 (with-current-buffer (find-file-noselect (concat org-file "/index.html"))
;;                                   (elnode-send-html httpcon (buffer-string))))
;;                                         ;((string= (file-name-extension org-file) "rb")
;;                                         ; (with-current-buffer (find-file-noselect org-file)
;;                                         ;   (elnode-send-html httpcon (buffer-string))))
;;                                ((string= (file-name-extension org-file) "html")
;;                                 (with-current-buffer (find-file-noselect org-file)
;;                                   (elnode-send-html httpcon (buffer-string))))
;;                                ((string= (file-name-extension org-file) "org")
;;                                 (with-current-buffer (find-file-noselect org-file)
;;                                   (let ((org-html (org-export-as-html 3 nil nil 'string)))
;;                                     (elnode-send-html httpcon org-html))))
;;                                (t
;;                                 (elnode-send-file httpcon org-file)))))

(elnode-start 'ay-handler :port 8010)

(while t (accept-process-output nil 1))
