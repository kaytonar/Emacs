(require 'package)
(add-to-list 'package-archives '("GNU" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)


(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(setq use-package-always-ensure t)

(use-package all-the-icons)

(use-package rainbow-mode
  :defer t
  )

(use-package evil
  :ensure t
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-redo))

(use-package dracula-theme)
  ;; :ensure t
   ;; :config
(load-theme 'dracula t)
   
   

(global-hl-line-mode t) ;; This highlights the current line in the buffer

(use-package beacon ;; This applies a beacon effect to the highlighted line
   :ensure t
   :config
   (beacon-mode 1))


(use-package web-mode
  :mode (
	 ("\\.js?\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         ("\\.css?\\'" . web-mode)
         ))

;;Which-Key

(use-package which-key
  :config 
    (setq which-key-idle-delay 0.3)
    (setq which-key-popup-type 'frame)
    (which-key-mode)
    (which-key-setup-minibuffer)
    (set-face-attribute 'which-key-local-map-description-face nil 
       :weight 'bold)
  :ensure t)

;; Helm	 
(use-package helm-ag
  :init
    (require 'helm-config)
    (setq helm-split-window-in-side-p t
          helm-move-to-line-cycle-in-source t)
  :config 
    (helm-mode 1) ;; Most of Emacs prompts become helm-enabled
    (helm-autoresize-mode 1) ;; Helm resizes according to the number of candidates
    (global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers ( Emacs way )
    (define-key evil-ex-map "b" 'helm-buffers-list) ;; List buffers ( Vim way )
    (global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
    (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
    (global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
    (global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
    (global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
    (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to paste
  :ensure t)


(use-package general
  :config
  (general-evil-setup t))


(use-package all-the-icons-dired)
(use-package dired-open)
(use-package peep-dired)

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
               "d d" '(dired :which-key "Open dired")
               "d j" '(dired-jump :which-key "Dired jump to current")
               "d p" '(peep-dired :which-key "Peep-dired"))

(with-eval-after-load 'dired
  ;;(define-key dired-mode-map (kbd "M-p") 'peep-dired)
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" default))
 '(package-selected-packages
   '(helm rainbow-mode use-package peep-dired general evil dired-open all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
