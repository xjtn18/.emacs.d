(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq package-user-dir "~/.emacs.d/elpa")
(package-initialize)

;; @NOTE: Uncomment this to refresh the package list (when setting up for the first time, or adding a new package manager)
;;(package-refresh-contents)


;; To install, run M-x, 'package-install', and enter the package name.
;; Be aware that you may need to run package-refresh-contents first for the packages to appear.
;; Also be aware that Elpa is the standard GNU emacs package manager; Melpa is another that offers
;;     most of the packages I use. The line at the top is where we add Melpa to the package archives.

;; --- My package list ---
;; Evil (Vim emulation layer)
;; naysayer (Jon Blow color scheme)
;; hl-todo



(require 'evil)
(evil-mode 1)




;;;;  CUSTOM COLON COMMANDS WITH EVIL  ;;;;

;; Define evil colon command to open my emacs init file.
(defun my-open-init-file () (interactive)
  (find-file "~/.emacs.d/init.el"))
(evil-ex-define-cmd "rc" 'my-open-init-file)


;; Define evil colon command to open my user documents folder.
(defun my-open-docs () (interactive)
  (find-file "~/Documents"))
(evil-ex-define-cmd "docs" 'my-open-docs)


;; Define evil colon command to open my main dev directory.
(defun my-open-dev () (interactive)
  (find-file "C:/dev"))
(evil-ex-define-cmd "dev" 'my-open-dev)


;; Open naysayer color scheme file
(defun my-open-color-scheme () (interactive)
  (find-file "~/.emacs.d/elpa/naysayer-theme-20200405.123/naysayer-theme.el"))
(evil-ex-define-cmd "cs" 'my-open-color-scheme)


;; Copy entire buffer contents
(defun my-copy-buffer () (interactive)
   (copy-region-as-kill (point-min) (point-max))
)
(evil-ex-define-cmd "cb" 'my-copy-buffer)


;; Open custom theme directory
(defun my-goto-custom-themes () (interactive)
  (find-file "~/.emacs.d/my_themes")
)
(evil-ex-define-cmd "td" 'my-goto-custom-themes)


;; Increase/decrease font size with Control +/- if you want (otherwise you can just C-scroll)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Add to the custom-theme-load-path
(add-to-list 'custom-theme-load-path "~/.emacs.d/my_themes")

;; Theme
(load-theme 'jake_wheatgrass t)
;;(load-file "~/.emacs.d/my_themes/jake_wheatgrass-theme.el")


;; Define the width of a tab
(setq-default tab-width 3)
(setq-default evil-shift-width 3)
(setq c-basic-offset 3)


;; prevent emacs from making backups of edited files.
(setq make-backup-files nil)

;; Highlight line with the cursor, preserving the colours.
;;(set-face-attribute hl-line-face nil :inherit nil :background "#1C212B")


;; Enable current line highlighting
;;(global-hl-line-mode 1)
;;(set-face-background hl-line-face "#1C212B")


;; Enable TODO highlighting

(global-hl-todo-mode 1)
(setq hl-todo-keyword-faces
	'(("TODO"   . "#e8ce27")
	  ("NOTE"  . "#db621d")
	  ("FIXME"  . "#eb4034")
	 )
)


;; disable any bold text
(set-face-bold-p 'bold nil)


;; automatically set to fullscreen.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; use visual flash when doing an illegal action, instead of the annoying windows bell sound
(setq visible-bell t)


;; Save on focus lost
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))



;; Enable C# syntax highlighter
(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-local-mode 1) ;; Emacs 25
)
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	[default default default italic underline success warning error])
 '(ansi-color-names-vector
	["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
	'("0c41069758f9cede81c3f3cec4c739aafa637a445470886c018113fcfb1675f1" default))
 '(initial-buffer-choice "C:/dev/")
 '(linum-format " %5i ")
 '(menu-bar-mode nil)
 '(package-selected-packages '(hl-todo naysayer-theme evil))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "outline" :slant normal :weight normal :height 130 :width normal)))))



