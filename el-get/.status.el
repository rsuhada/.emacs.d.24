((backups-mode status "installed" recipe
               (:name backups-mode :type github :pkgname "chadbraunduin/backups-mode" :description "Backups and versioning management system" :website "https://github.com/chadbraunduin/backups-mode"))
 (desktop-recover status "installed" recipe
                  (:name desktop-recover :type github :pkgname "doomvox/desktop-recover" :description "Backups .desktop file and recovers it" :website "https://github.com/doomvox/desktop-recover/blob/master/desktop-recover.el"))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (tellicopy status "installed" recipe
            (:name tellicopy :auto-generated t :type emacswiki :description "A minor mode for saving the thing at point to `kill-ring'" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/tellicopy.el")))
