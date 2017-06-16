__zplug::log::capture::error_file()
{
    if [[ ! -s $1 ]]; then
        return
    fi

    __zplug::log::capture::error < $1
    zf_rm $1
}

__zplug::log::capture::debug_file()
{
    if [[ ! -s $1 ]]; then
        return
    fi

    __zplug::log::capture::debug < $1
    zf_rm $1
}

__zplug::log::capture::info_file()
{
    if [[ ! -s $1 ]]; then
        return
    fi

    __zplug::log::capture::info < $1
    zf_rm $1
}

__zplug::log::capture::error()
{
    local message="$(<&0)"

    if [[ -z $message ]]; then
        return 0
    fi

    __zplug::job::handle::flock --escape \
        "$_zplug_log[trace]" \
        "$(__zplug::log::format::with_json "ERROR" "$message")"
}

__zplug::log::capture::debug()
{
    local message="$(<&0)"

    if [[ -z $message ]]; then
        return 0
    fi

    __zplug::job::handle::flock --escape \
        "$_zplug_log[trace]" \
        "$(__zplug::log::format::with_json "DEBUG" "$message")"
}

__zplug::log::capture::info()
{
    local message="$(<&0)"

    if [[ -z $message ]]; then
        return 0
    fi

    __zplug::job::handle::flock --escape \
        "$_zplug_log[trace]" \
        "$(__zplug::log::format::with_json "INFO" "$message")"
}
