Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA8179A67
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgCDUuH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 15:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgCDUuH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 15:50:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7112320828;
        Wed,  4 Mar 2020 20:50:06 +0000 (UTC)
Date:   Wed, 4 Mar 2020 15:50:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Use printf instead of echo in kprobe
 syntax error tests
Message-ID: <20200304155004.7dd033a3@gandalf.local.home>
In-Reply-To: <20200304161435.23019-1-seth.forshee@canonical.com>
References: <20200304161435.23019-1-seth.forshee@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed,  4 Mar 2020 10:14:35 -0600
Seth Forshee <seth.forshee@canonical.com> wrote:

> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -37,7 +37,7 @@ fi
>  
>  check_error 'p vfs_read ^$none_var'	# BAD_VAR
>  
> -check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
> +check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
>  check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
>  check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
>  
> @@ -80,7 +80,7 @@ check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
>  # instruction boundary check is valid on x86 (at this moment)
>  case $(uname -m) in
>    x86_64|i[3456]86)
> -    echo 'p vfs_read' > kprobe_events
> +    printf 'p vfs_read' > kprobe_events
>      if grep -q FTRACE ../kprobes/list ; then
>  	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
>      fi
> @@ -89,13 +89,13 @@ esac
>  
>  # multiprobe errors
>  if grep -q "Create/append/" README && grep -q "imm-value" README; then
> -echo 'p:kprobes/testevent _do_fork' > kprobe_events
> +printf 'p:kprobes/testevent _do_fork' > kprobe_events
>  check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
> -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
> -check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
> -check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
> -check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> -check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
> +printf 'p:kprobes/testevent _do_fork abcd=\\1' > kprobe_events
> +check_error 'p:kprobes/testevent _do_fork ^bcd=\\1'	# DIFF_ARG_TYPE
> +check_error 'p:kprobes/testevent _do_fork ^abcd=\\1:u8'	# DIFF_ARG_TYPE
> +check_error 'p:kprobes/testevent _do_fork ^abcd=\\"foo"'# DIFF_ARG_TYPE
> +check_error '^p:kprobes/testevent _do_fork abcd=\\1'	# SAME_PROBE
>  fi
>  
>  exit 0


This change causes my tests to fail:

++ echo 'Test command: p vfs_read arg1="abcd'
Test command: p vfs_read arg1="abcd
++ echo
++ grep 'trace_kprobe: error:' -A 3 error_log
[61913.240093] trace_kprobe: error: Invalid fetch argument
  Command: p vfs_read arg1="abcd
                           ^
+++ tail -n 1 error_log
+++ wc -c
++ N=29
+++ expr 13 + 21
++ test 34 -eq 29


-- Steve
