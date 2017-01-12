source $HOME/.keychain/(hostname)-fish

# emacs ansi-term support
if test -n "$EMACS"
  set -x TERM eterm-color
end

function fish_title
  true
end

if status --is-interactive
    keychain --eval --quiet --quick $HOME/.ssh/id_rsa
end

