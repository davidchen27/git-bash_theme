# 终端打印结构美化 Start
if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1="\[\033]0;David's Workstation\007\]"  # 设置终端打开后的标题
	PS1="$PS1"'\n'
	PS1="$PS1"'\[\033[35m\]'                  # 粉紫色
	PS1="$PS1"'┌'                             # 第一个字符, 与第二行的└◥配合表现出相连的样子
	PS1="$PS1"'\[\033[32m\]'                  # 亮绿色
	PS1="$PS1"' @\u '                         # 主机用户名 user@host<space>
	PS1="$PS1"'\[\033[35m\]'                  # 粉紫色
	PS1="$PS1"'in '                           # in
	PS1="$PS1"'\[\033[33m\]'                  # 亮黄色
	PS1="$PS1"'\W'                            # 当前工作目录
	PS1="$PS1"'\[\033[35m\]'                  # 粉紫色
	PS1="$PS1"' at '                          # at
	PS1="$PS1"'\[\033[36m\]'                  # 亮青色
	PS1="$PS1"'[\@]'                          # 显示当前时间
	isGit="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
	if [ "$isGit" = "true" ]                  # 如果当前目录是Git目录
	then
	PS1="$PS1"'\[\033[35m\]'                  # 粉紫色
	PS1="$PS1"' ▧▧▷'                          # 显示Git图标
	fi
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[31m\]'              # 亮红色
			PS1="$PS1"'`__git_ps1`'               # 打印调用__git_ps1函数返回值, 即分支信息
		fi
	fi
	PS1="$PS1"'\[\033[0m\]'                   # 重置颜色
	PS1="$PS1"' ✘\n'                         # 当前行结束符 + 换行
	PS1="$PS1"'\[\033[35m\]└◥\[\033[0m\] '    # 第二行结束符
fi
# 终端打印结构美化 End

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
