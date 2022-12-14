(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Update all custom emacs search paths:
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'custom-theme-load-path "~/.emacs.d/my_themes")

(package-initialize)

;; NOTE: Uncomment this to refresh the package list (when setting up for the first time, or adding a new package manager)
;;(package-refresh-contents)


;; To install, run M-x, 'package-install', and enter the package name.
;; Be aware that you may need to run package-refresh-contents first for the packages to appear.
;; Also be aware that Elpa is the standard GNU emacs package manager; Melpa is another that offers
;;     most of the packages I use. The line at the top is where we add Melpa to the package archives.

;; ------ My package list ------
;; Evil      (Vim emulation layer)
;; hl-todo   (To highlight specific words in files)
;; rjsx-mode (For jsx formatting, highlighting, and functionality)
;; csharp-mode (Formatting and highlighting for C#)
;; yaml-mode (Formatting and highlighting for YAML)
;; python-mode (Formatting and highlighting for Python)
;; naysayer  (Jon Blow color scheme)



(require 'evil)
(evil-mode 1)

;; Setup the undo-tree to get C-r 'redo' functionality
;; 'use-package' is a 3rd party package - may or may not be needed to get redo undo-tree working - this block was copied from Reddit.
(require 'use-package)
(use-package undo-tree
			 :ensure t
			 :after evil
			 :diminish
			 :config
			 (evil-set-undo-system 'undo-tree)
			 (global-undo-tree-mode 1))
;; tell undo-tree to save history files into a seperate directory
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))



(require 'org)
;; Org mode - set colors for emphasized text (bold, italic, etc.)
;; --- For dark color schemes
;;(add-to-list 'org-emphasis-alist '("*" (:weight bold :foreground "yello")))
;;(add-to-list 'org-emphasis-alist '("/" (:slant oblique :foreground "sky blue")))

;; --- For light color schemes
;;(add-to-list 'org-emphasis-alist '("*" (:weight bold :foreground "dark orange")))
;;(add-to-list 'org-emphasis-alist '("/" (:slant oblique :foreground "DodgerBlue1")))
;; Change font when in org mode
(defun my/org-font ()
  (face-remap-add-relative 'default :family "DejaVu Sans Mono"))
(add-hook 'org-mode-hook 'my/org-font)
;; Hide the text markdown characters (*, ?, _, etc.)
(setq org-hide-emphasis-markers t)
;; Default startup 'fold' configuration
(setq org-startup-folded t)



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
  (find-file "~/dev"))
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

;; Open my WID scrum buffer
(defun my-goto-wid-buffer () (interactive)
  (find-file "~/dev/notes/personal/WID.org")
)
(evil-ex-define-cmd "wid" 'my-goto-wid-buffer)


;; Set evil command to get the json path under the cursor (doesnt even work, nice)
;; NOTE - this is a really jank plugin. The paths will only work/be correct if the entire file is valid JSON and if you are running the command when the cursor is within a STRING.
(require 'json-snatcher)
(evil-ex-define-cmd "jsp" 'jsons-print-path)

;; Python pretty print dictionaries in JSON format
(defun python-prettyprint-region ()
  (interactive)
  (let ( (new-buffer-name "*pprint*") (selection (buffer-substring-no-properties (region-beginning) (region-end))))
    (if (bufferp new-buffer-name)
      (kill-buffer new-buffer-name))
    (call-process
     "python"
     nil
     new-buffer-name nil
     "-c"
     "import ast; import json; import sys; x=ast.literal_eval(sys.argv[1]); print(json.dumps(x,indent=4))"
     selection)
    (pop-to-buffer new-buffer-name)))
(evil-ex-define-cmd "pjs" 'python-prettyprint-region)


;; Increase/decrease font size with Control +/- if you want (otherwise you can just C-scroll)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Theme
(load-theme 'classic t)
;; THE DEFAULT THEME DIRECTORY PATH IS = C:\Program Files\Emacs\x86_64\share\emacs\{version}\etc\themes


;; Define the width of a tab
(setq-default tab-width 4)
(setq-default evil-shift-width 4)
(setq c-basic-offset 4)
(setq c-backspace-function 'delete-backward-char)
;;(setq-default indent-tabs-mode nil)

;; The variable below is declared from rjsx-mode
(setq sgml-basic-offset 4)


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
	'(("TODO"       . "#e8ce27")
	  ("NOTE"       . "#db621d")
	  ("FIXME"      . "#eb4034")
	  ("NOCHECKIN"  . "#e8ce27")
	  ("CHECKIN"    . "#e8ce27")
	 )
)


;; disable any bold text
(set-face-bold-p 'bold nil)


;; window settings
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
(if (window-system) (set-frame-size (selected-frame) 110 70))
(if (window-system) (set-frame-position (selected-frame) 1300 60))


;; use visual flash when doing an illegal action, instead of the annoying windows bell sound
(setq visible-bell t)


;; Sets cursor to not skip (visual) lines on long wrapped lines
(global-visual-line-mode 1)
;;(setq-default bidi-display-reordering nil)
(setq bidi-inhibit-bpa t)
(setq-default bidi-paragraph-direction 'left-to-right)
;; Make movement keys work move across visual lines rather than logical lines
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
; Make horizontal movement cross lines                                    
(setq-default evil-cross-lines t)


;; Save on focus lost
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))


;; Enable python jedi package (auto-complete)
;;(add-hook 'python-mode-hook 'jedi:setup)



;; Enable C# syntax highlighter
(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-local-mode 1) ;; Emacs 25
)
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)



;; enter rjsx mode when opening JS files
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)) ;; automatically adds .jsx files

(good-scroll-mode 1)

;; Native emacs minor modes
(which-function-mode 1) ;; display function name where cursor resides
(electric-pair-mode 1) ;; auto enclose parentheses and braces



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
 '(initial-buffer-choice "~/dev")
 '(linum-format " %5i ")
 '(menu-bar-mode nil)
 '(package-selected-packages '(hl-todo naysayer-theme evil))
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "outline" :slant normal :weight normal :height 110 :width normal)))))



