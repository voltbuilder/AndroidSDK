#!/bin/sh
tool_name=$(basename "$0")

if [ "$tool_name" = "sdkmanager" ] || [ "$tool_name" = "avdmanager" ]; then
    tool_path="$ANDROID_HOME/cmdline-tools/tools/bin/$tool_name"
elif [ "$tool_name" = "adb" ] || [ "$tool_name" = "emulator" ]; then
    if [ -x "$ANDROID_HOME/platform-tools/$tool_name" ]; then
        tool_path="$ANDROID_HOME/platform-tools/$tool_name"
    else
        tool_path="$ANDROID_HOME/emulator/$tool_name"
    fi
else
    tool_path=""
    for candidate in "$ANDROID_HOME"/build-tools/*/"$tool_name"; do
        if [ -x "$candidate" ]; then
            tool_path="$candidate"
            break
        fi
    done
fi

if [ -z "$tool_path" ] || [ ! -x "$tool_path" ]; then
    echo "$tool_name not found for box64 wrapper" >&2
    exit 127
fi

exec box64 "$tool_path" "$@"
