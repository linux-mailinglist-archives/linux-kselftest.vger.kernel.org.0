Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4E3F37F1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 03:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhHUBme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 21:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHUBme (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 21:42:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5A1361163;
        Sat, 21 Aug 2021 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629510115;
        bh=HBWduDiPhGmHdP51duukiLFu8daTpY7XH8pt3F5Gdvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPN8ZQQg+M64VXwH9EZvhEHX3mwyKpAjPqifcxEHvyklD9mKWVfO0vhS4x0A538IE
         89s96x55cAt8P8YvMOPXbMfXq+9ERqlLEvdDrPF/RNYJ/NsB4IOBizcaCWYTkRvwt8
         Cn00B/rCLMDZ53lZqmkhOVkGK2uq9vQL3v+1qq4c/SF7JQPiCSQ9Po52uZD1Pw6283
         caHoIuglN8fjNyXn3BVsHjo1gp5gFR9ol1i7n7ULUnvHibPR6ea+ovL96zy9RsURJJ
         1E3SPUEaGQKroGOGrgf4GYBFeckX064DmRIO5tkzE+VQx9X/a9fRbJqW0S0ulYLxGJ
         8wSd0sxNk/hcw==
Date:   Sat, 21 Aug 2021 10:41:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 6/6] selftests/ftrace: Add selftest for testing
 duplicate eprobes and kprobes
Message-Id: <20210821104152.de68dee1b30a72bf2b0c815f@kernel.org>
In-Reply-To: <20210820204742.653288346@goodmis.org>
References: <20210820204644.546662591@goodmis.org>
        <20210820204742.653288346@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 20 Aug 2021 16:46:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a selftest that makes sure that eprobes and kprobes can not be created
> with the same group and name as existing events.
> 
> Link: https://lore.kernel.org/linux-kselftest/20210819152825.715290342@goodmis.org/
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  .../ftrace/test.d/dynevent/test_duplicates.tc | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> new file mode 100644
> index 000000000000..db522577ff78
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - check if duplicate events are caught
> +# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
> +
> +echo 0 > events/enable
> +
> +HAVE_KPROBES=0
> +
> +if [ -f kprobe_events ]; then
> +	HAVE_KPROBES=1
> +fi
> +
> +clear_dynamic_events
> +
> +# first create dynamic events for eprobes and kprobes.
> +
> +echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +
> +# Test eprobe for same eprobe, existing kprobe and existing event
> +! echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +! echo 'e:syscalls/sys_enter_open syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +
> +if [ $HAVE_KPROBES -eq 1 ]; then
> +    echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
> +    ! echo 'e:kgroup/kevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +
> +# Test kprobe for same kprobe, existing eprobe and existing event
> +    ! echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
> +    ! echo 'p:egroup/eevent vfs_open file=+0($arg2)' >> dynamic_events
> +    ! echo 'p:syscalls/sys_enter_open vfs_open file=+0($arg2)' >> dynamic_events
> +
> +    echo '-:kgroup/kevent' >> dynamic_events
> +fi
> +
> +echo '-:egroup/eevent' >> dynamic_events
> +
> +clear_trace
> -- 
> 2.30.2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
