Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989971CDB5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgEKNiK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 09:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgEKNiK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 09:38:10 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498A0206F9;
        Mon, 11 May 2020 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589204289;
        bh=WwDE+Fb8z57q8OKzPF9RACs94iZxWF3u3IPperUFdGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z5rmd7KSgTp2/xdiux62bJoMVYAgSuMtc8CTcMJLP9uc7ZMzaJhz4YArkSNYtcmux
         704q5CAPni+6iRE5LE0Wpbu2t8n4Fv5ZPLQqVaftO52tBd6SSsjjqJxEKUzRIEW/7O
         6CnknnK2DX5mlxMjnFpEobk3BV883/MgwyUtxCn8=
Date:   Mon, 11 May 2020 22:38:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
Message-Id: <20200511223804.9483cab03c9221818ff4fc5b@kernel.org>
In-Reply-To: <158920418730.16156.8299185499520876735.stgit@devnote2>
References: <87imh21x6f.fsf@igel.home>
        <158920418730.16156.8299185499520876735.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andreas and David,

OK, what about this fix?

On Mon, 11 May 2020 22:36:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the built-in echo has different behavior in POSIX shell
> (dash) and bash, kprobe_syntax_errors.tc can fail on dash which
> interpret backslash escape automatically.
> 
> To fix this issue, we explicitly use printf "%s" (not interpret
> backslash escapes) if the command string can include backslash.
> 
> Reported-by: Liu Yiding <yidingx.liu@intel.com>
> Suggested-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/test.d/functions    |    8 +++++---
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    4 +++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 61a3c7e2634d..697c77ef2e2b 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -119,12 +119,14 @@ yield() {
>      ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
>  }
>  
> +# Since probe event command may include backslash, explicitly use printf "%s"
> +# to NOT interpret it.
>  ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
> -    pos=$(echo -n "${2%^*}" | wc -c) # error position
> -    command=$(echo "$2" | tr -d ^)
> +    pos=$(printf "%s" "${2%^*}" | wc -c) # error position
> +    command=$(printf "%s" "$2" | tr -d ^)
>      echo "Test command: $command"
>      echo > error_log
> -    (! echo "$command" >> "$3" ) 2> /dev/null
> +    (! printf "%s" "$command" >> "$3" ) 2> /dev/null
>      grep "$1: error:" -A 3 error_log
>      N=$(tail -n 1 error_log | wc -c)
>      # "  Command: " and "^\n" => 13
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index ef1e9bafb098..eb0f4ab4e070 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -91,7 +91,9 @@ esac
>  if grep -q "Create/append/" README && grep -q "imm-value" README; then
>  echo 'p:kprobes/testevent _do_fork' > kprobe_events
>  check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
> -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
> +
> +# Explicitly use printf "%s" to not interpret \1
> +printf "%s" 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
>  check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
>  check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
>  check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
