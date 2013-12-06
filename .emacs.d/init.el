;; download Emacs-24.3-with-inline-patch.dmg from http://sourceforge.jp/projects/macemacsjp/releases/

;;http://www.emacswiki.org/emacs/FrameSize
;; Mac book air 11 の画面全体に表示
 (if window-system
      (set-frame-size (selected-frame) 155 42))

;; http://www.emacswiki.org/emacs/ToolBar
;; ツールバーを非表示に
(tool-bar-mode -1)
;; バックアップを残さない
(setq make-backup-files nil)

;; markdown のコマンド設定
(setq markdown "/usr/local/bin/markdown") 

;; マウスモードの有効化
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key   [mouse-4] '(lambda () (interactive) (scroll-down 1)))
(global-set-key   [mouse-5] '(lambda () (interactive) (scroll-up   1)))

;; dired設定
;(progn
;  ;; ディレクトリを先頭に表示
;  (setq ls-lisp-dirs-first t)
;  ;; 時間フォーマットカスタマイズを有効にする
;  (setq ls-lisp-use-localized-time-format t)
;  ;; 時間フォーマット
;  (setq ls-lisp-format-time-list '(
;    "%Y-%m-%d %H:%M"
;    "%Y-%m-%d %H:--"
;  ))
;  ;; ファイルの持ち主など項目の表示を減らす
;  (setq ls-lisp-verbosity nil)
;  ;; 表示オプション(フォルダの最後に「/」を表示)
;  (setq dired-listing-switches "-lAF")
;  ;; diredバッファに切り替えるたびに更新
;  (setq dired-auto-revert-buffer t)
;)

;; git の root 取得
(defun chomp (str)
  (replace-regexp-in-string "[\n\r]+$" "" str))

;;; git
(defun git-project-p ()
  (string=
   (chomp
    (shell-command-to-string "git rev-parse --is-inside-work-tree"))
   "true"))

(defun git-root-directory ()
  (cond ((git-project-p)
         (chomp
          (shell-command-to-string "git rev-parse --show-toplevel")))
        (t
         "")))

;; git grep 定義

(defun git-grep (grep-dir command-args)
  (interactive
   (let ((root (concat (git-root-directory) "/")))
     (list
      (read-file-name
       "Directory for git grep: " root root t)
      (read-shell-command
            "Run git-grep (like this): "
            (format "PAGER='' git grep -I -n -i -e %s"
                    "")
            'git-grep-history))))
  (let ((grep-use-null-device nil)
        (command
         (format (concat
                  "cd %s && "
                  "%s")
                 grep-dir
                 command-args)))
    (grep command)))

;;行数表示
(global-linum-mode t)
; 5 桁分の領域を確保して行番号のあとにスペースを入れる
(setq linum-format "%3d ") 

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; 現在の行をハイライト表示する
(global-hl-line-mode)

;; カーソルの色をオレンジ色に設定する (白色なら white にする)
;;http://margaret-sdpara.blogspot.jp/2012/07/emacs.html
(setq default-frame-alist
      (append (list '(cursor-color . "orange")) default-frame-alist))

;; http://hitode909.hatenablog.com/entry/20110817/1313507601
;; 10秒間操作をしない場合は、2秒周期でカーソルを明滅
;;(set-cursor-color "orange")
(setq blink-cursor-interval 1.0)
(setq blink-cursor-delay 10.0)
(blink-cursor-mode 1)

;; Ctrl+H でBS
(global-set-key "\C-h" 'delete-backward-char)

;; http://ap-www.cf.ocha.ac.jp/hito/index.php?emacs.el%A4%CE%C0%DF%C4%EA
;;(setq visible-bell t) ;; 警告音を消す
(global-set-key "\M-n" 'linum-mode);;行番号
(line-number-mode t);;行数表示
;;ビープ音を消す
(setq ring-bell-function 'ignore)

;;https://gist.github.com/mitukiii/4365568
(setq default-input-method "MacOSX")
;; Google日本語入力を使う場合はおすすめ
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")
;; Monaco 12pt をデフォルトにする
;(set-face-attribute 'default nil
;                    :family "MigMix 1M"
;                    :height 170)
;; 日本語をヒラギノ角ゴProNにする
;(set-fontset-font "fontset-default"
;                  'japanese-jisx0208
;                  '("MigMix 1M"))
;; 半角カナをヒラギノ角ゴProNにする
;(set-fontset-font "fontset-default"
;                  'katakana-jisx0201
;                  '("MigMix 1M"))

;; http://qiita.com/catatsuy/items/c3e4fe2e6c856c285880
;; minibuffer 内は英数モードにする
;(add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
;(mac-translate-from-yen-to-backslash)

;; http://d.hatena.ne.jp/aoe-tk/20130210/1360506829
;; テーマを設定 wombat
(load-theme 'misterioso t)

;; markdown-mode http://jblevins.org/projects/markdown-mode/
;; cd ~/.emacs.d/; git clone git://jblevins.org/git/markdown-mode.git
;(setq load-path (append '("~/.emacs.d/markdown-mode") load-path))
;
;(autoload 'markdown-mode "markdown-mode"
;   "Major mode for editing Markdown files" t)
;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; http://moya-notes.blogspot.jp/2013/02/emacs24-config-on-mac.html#markdown2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; [基本] トラックパッド用のスクロール設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)

;; http://sakito.jp/emacs/emacs23.html#id21
(define-key global-map [ns-drag-file] 'ns-find-file)
;; http://www.emacswiki.org/emacs/TransparentEmacs
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
; (set-frame-parameter (selected-frame) 'alpha '(95 50))
; (add-to-list 'default-frame-alist '(alpha 95 50))

;; 起動時のフレームサイズを指定する
(setq initial-frame-alist
      (append (list
        '(top . 60)
        '(left . 120)
        '(width . 120)
        '(height . 25)
        )
        initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;; スタートアップを非表示とする
(setq inhibit-startup-message t)

;; option を alt にする
(setq mac-option-modifier 'meta)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elisp の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; elispディレクトリにパスを通す(本当は一番最初に書くのがいいのだろうけれど…)
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; el-speedbar.el
; 読み込み設定
(require 'sr-speedbar) 

; 左側にspeedbarを表示する
(setq sr-speedbar-right-side nil) 

; 幅を変更する
(setq sr-speedbar-width-x 20)

; 起動をF5に割り当てる
(global-set-key (kbd "<f5>") 'sr-speedbar-toggle)

; 自動でディレクトリ表示を切り替えない
(setq sr-speedbar-refresh-turn-off nil)

;全てのファイルを表示
(custom-set-variables
 '(speedbar-show-unknown-files t)
)


(make-face 'speedbar-face)
;(set-face-font 'speedbar-face "MigMix 1M-13")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

(defadvice linum-on (around linum-on-around)
  (unless (string-match "SPEEDBAR" (buffer-name))
    ad-do-it))

;; everything
(add-to-list 'load-path "~/.emacs.d/elisp/everything.el")
(require 'everything)

;; anything
(add-to-list 'load-path "~/.emacs.d/elisp/anything-config/")
(require 'anything-config)
; emacs コマンド
;(add-to-list 'anything-sources 'anything-c-source-buffers+)
;(add-to-list 'anything-sources 'anything-c-recentf)
(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-bookmarks
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-files-in-current-dir
        ))

(define-key global-map (kbd "C-c l") 'anything) ; anything 呼び出し用

;; E2WM
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-window-manager")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-window-manager/e2wm-config.el")
(require 'e2wm)
;(require 'e2wm-config)
(global-set-key (kbd "M-+") 'e2wm:start-management)

(e2wm:add-keymap 
 e2wm:pst-minor-mode-keymap
 '(("C-c 1" . e2wm:dp-code) ; codeへ変更
   ("C-c 2"  . e2wm:dp-two)  ; twoへ変更
   ("C-c 3"    . e2wm:dp-doc)  ; docへ変更
   ("C-c 4"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C-."       . e2wm:pst-history-forward-command) ; 履歴を進む
   ("C-,"       . e2wm:pst-history-back-command) ; 履歴をもどる
   ("prefix L"  . ielm)
   ("M-m"       . e2wm:pst-window-select-main-command)
   ) e2wm:prefix-key)

(setq e2wm:c-dashboard-plugins
  '(clock top
    (open :plugin-args (:command eshell :buffer "*eshell*"))
    (open :plugin-args (:command doctor :buffer "*doctor*"))
    ))

(setq e2wm:def-plugin-clock-url "http://www.bijint.com/jp/img/clk/%H%M.jpg")
(setq e2wm:def-plugin-clock-referer "http://www.bijint.com/jp/")  

;; fill-colum-indicator 動かん
; 80 桁目に縦線
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
; 縦線の幅
(setq fci-rule-width 5)
; 縦線の色
(setq fci-rule-color "white")
;;(setq fci-rule-color (aria-color "Renaissance"))
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; 全角スペースおよびタブの可視化
(setq whitespace-style '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
       ))
;;(setq whitespace-style '(spaces space-mark))
;;(setq whitespace-space-regexp "\\(\x3000+\\)")
;;(setq whitespace-display-mappings
;;      '((space-mark ?\x3000 [?\□])
;;))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

;; tabbar.el
(require 'tabbar)
(tabbar-mode)

; マウスホイールでの移動を無効
(tabbar-mwheel-mode -1)

; グループ表示を無効
(setq tabbar-buffer-groups-function nil)

; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

; タブの間
(setq tabbar-separator '(0.2))

;; 色設定
(set-face-attribute ; バー自体の色
  'tabbar-default nil
   :background "gray28"
;   :family "Inconsolata"
   :family "MigMix 1M"
   :height 1.0)
(set-face-attribute ; アクティブなタブ
  'tabbar-selected nil
   :background "gray85"
   :foreground "black"
   :weight 'bold
;   :box nil
)
(set-face-attribute ; 非アクティブなタブ
  'tabbar-unselected nil
   :background "gray36"
   :foreground "white"
;   :box nil
)

(defun my-tabbar-buffer-list ()
  (delq nil
    (mapcar #'(lambda (b)
            (cond
            ;; Always include the current buffer.
            ((eq (current-buffer) b) b)
            ((buffer-file-name b) b)
            ((char-equal ?\  (aref (buffer-name b) 0)) nil)
            ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
            ((equal "*grep*" (buffer-name b)) b) ; *scratch*バッファは表示する
            ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)


; タブ移動 Command+Shift+arrow
(global-set-key (kbd "<S-s-right>") 'tabbar-forward-tab)
(global-set-key (kbd "<S-s-left>") 'tabbar-backward-tab)
(global-set-key (kbd "C-t") 'tabbar-forward-tab)
(global-set-key (kbd "S-<left>") 'windmove-left)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "S-<right>") 'windmove-right)
(tabbar-mode)

; マウスホイールでの移動を無効
(tabbar-mwheel-mode -1)

; グループ表示を無効
(setq tabbar-buffer-groups-function nil)

; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

; タブの間
(setq tabbar-separator '(0.2))

;; 色設定
(set-face-attribute ; バー自体の色
  'tabbar-default nil
   :background "gray28"
;   :family "Inconsolata"
   :family "MigMix 1M"
   :height 1.0)
(set-face-attribute ; アクティブなタブ
  'tabbar-selected nil
   :background "gray85"
   :foreground "black"
   :weight 'bold
;   :box nil
)
(set-face-attribute ; 非アクティブなタブ
  'tabbar-unselected nil
   :background "gray36"
   :foreground "white"
;   :box nil
)

(defun my-tabbar-buffer-list ()
  (delq nil
    (mapcar #'(lambda (b)
            (cond
            ;; Always include the current buffer.
            ((eq (current-buffer) b) b)
            ((buffer-file-name b) b)
            ((char-equal ?\  (aref (buffer-name b) 0)) nil)
            ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
            ((equal "*grep*" (buffer-name b)) b) ; *scratch*バッファは表示する
            ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)


; タブ移動 Command+Shift+arrow
(global-set-key (kbd "<S-s-right>") 'tabbar-forward-tab)
(global-set-key (kbd "<S-s-left>") 'tabbar-backward-tab)
(global-set-key (kbd "C-t") 'tabbar-forward-tab)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)

(global-set-key (kbd "C-7") 'windmove-left)
(global-set-key (kbd "C-8") 'windmove-down)
(global-set-key (kbd "C-9") 'windmove-right)
(global-set-key (kbd "C-0") 'windmove-up)


;; Ctrl+Shift+arrow
;(global-set-key (kbd "<C-s-right>") 'tabbar-forward-tab)
;(global-set-key (kbd "<S-s-left>") 'tabbar-backward-tab)

;; js2mode
(require 'js2-mode) 
;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;(smart-tabs-advice js2-indent-line js2-basic-offset)

;; GNU global
;(require 'gtags)
;(global-set-key "\M-t" 'gtags-find-tag)     ;関数の定義元へ
;(global-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
;(global-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
;(global-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
;(global-set-key "\C-t" 'gtags-pop-stack)   ;前のバッファに戻る
;(add-hook 'c-mode-common-hook
;          '(lambda ()
;             (gtags-mode 1)
;             (gtags-make-complete-list)))

