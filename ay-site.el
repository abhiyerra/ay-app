(add-to-list 'load-path "/ay-site/org-mode/lisp")
(add-to-list 'load-path "/ay-site/org-mode/contrib/lisp")
(add-to-list 'load-path "/ay-site/elnode")

(require 'org)
(require 'elnode)

(setq ay-server-directory "/ay-site/website")

(defun ay-blog-handler (httpcon)
  "Handler for render the blog file."
  "")

(defun ay-feedback-handler (httpcon)
  "Receive feedback from the user on any part of the site that
might need updated and store it to a file feedback.org which can
be acted on."
  "hello")

(defun ay-handler (httpcon)
  (elnode-docroot-for ay-server-directory
                      with org-file
                      on httpcon
                      do (cond ((string= (elnode-http-pathinfo httpcon) "/feedback")
                                (elnode-send-html httpcon (ay-feedback-handler httpconn)))
                               ((string= (elnode-http-pathinfo httpcon) "/")
                                (with-current-buffer (find-file-noselect (concat org-file "/index.html"))
                                  (elnode-send-html httpcon (buffer-string))))
                                        ;((string= (file-name-extension org-file) "rb")
                                        ; (with-current-buffer (find-file-noselect org-file)
                                        ;   (elnode-send-html httpcon (buffer-string))))
                               ((string= (file-name-extension org-file) "html")
                                (with-current-buffer (find-file-noselect org-file)
                                  (elnode-send-html httpcon (buffer-string))))
                               ((string= (file-name-extension org-file) "org")
                                (with-current-buffer (find-file-noselect org-file)
                                  (let ((org-html (org-export-as-html 3 nil nil 'string)))
                                    (elnode-send-html httpcon org-html))))
                               (t
                                (elnode-send-file httpcon org-file)))))

(defun ay-site-start ()
  (elnode-stop 8010)
  (elnode-start 'ay-handler :port 8010))

(ay-site-start)
