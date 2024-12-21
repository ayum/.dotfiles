(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache (expand-file-name "~/.cache/eln-cache/")))

(if window-system
 (setq default-frame-alist '((background-color . "black"))))
