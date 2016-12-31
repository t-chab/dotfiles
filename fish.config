set -gx HOSTNAME (hostname)
[ -e $HOME/.keychain/$HOSTNAME-fish ]; and source "$HOME/.keychain/$HOSTNAME-fish"

# emacs ansi-term support
if test -n "$EMACS"
    set -x TERM eterm-color
end

# this function may be required
function fish_title
    true
end

if status --is-interactive
    keychain --eval --quiet -Q $HOME/.ssh/id_rsa
end
