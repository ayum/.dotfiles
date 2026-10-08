alias dnf='sudo dnf'

systemctl() {
    case "$1" in
        --user) command systemctl "$@" ;;
        *)      sudo systemctl "@" ;;
    esac
}
