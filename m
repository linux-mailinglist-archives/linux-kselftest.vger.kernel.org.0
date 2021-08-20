Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE46B3F243E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 02:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhHTAyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 20:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234160AbhHTAyj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 20:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BEF060F58;
        Fri, 20 Aug 2021 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629420842;
        bh=Hj0nxdulrC9JuM4VDcoJ+O7Op2x6KdB7INRx7a3mmsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uoowtAUe/u3zvb6G3BU5xvAKdLDR+v+7bRE7v2uW8V2aFMiKWCwG6XXCcs9sVk9oQ
         EJu9zmnbjU6HwjZewJNIeTTc3kQh4qYk8b5vwrIjj4yUI87eieIDUC8HGudEGPKZQF
         ZSY2EtKl+ExgwJK1JeiORx1p6jYXOwjhy4jyeiTc5GDrFTrlaVsGh1VAFby/cuwQeq
         U6+UTNAca9XBnV0qtUyhRhNIYP2OhIHYmEydPJqQsjmhyVvqusl7gPe6FO+kU+Ed7/
         8481Zt0f3ppqfvbVjgBBJj0yiSl6fjGu8XvLapP7m/YFa5Ca38G/xLgveZ0MuVQm4v
         M4KRNtfPJBAdw==
Date:   Fri, 20 Aug 2021 09:53:59 +0900
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
Subject: Re: [PATCH v8 5/5] selftests/ftrace: Add selftest for testing
 duplicate eprobes and kprobes
Message-Id: <20210820095359.f99a6cecb9886d8809685465@kernel.org>
In-Reply-To: <20210819152825.715290342@goodmis.org>
References: <20210819152604.704335282@goodmis.org>
        <20210819152825.715290342@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Aug 2021 11:26:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a selftest that makes sure that eprobes and kprobes can not be created
> with the same group and name as existing events.

Hmm, can you also remove kprobe event dependency from this test case?
The event probe depends on CONFIG_PROBE_EVENTS meta config, but that
is enabled both of CONFIG_KPROBE_EVENTS and CONFIG_UPROBE_EVENTS.
This means if the kernel configs CONFIG_KPROBE_EVENTS=n and
CONFIG_UPROBE_EVENTS=y, this will be executed but should fail.

Thank you,

> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/dynevent/test_duplicates.tc | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> new file mode 100644
> index 000000000000..022b569267ed
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - check if duplicate events are caught
> +# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<attached-event>o [<args>]":README
> +
> +echo 0 > events/enable
> +
> +clear_dynamic_events
> +
> +# first create dynamic events for eprobes and kprobes.
> +
> +echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
> +
> +# Test eprobe for same eprobe, existing kprobe and existing event
> +! echo 'e:egroup/eevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +! echo 'e:kgroup/kevent syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +! echo 'e:syscalls/sys_enter_open syscalls/sys_enter_openat file=+0($filename):ustring' >> dynamic_events
> +
> +# Test kprobe for same kprobe, existing eprobe and existing event
> +! echo 'p:kgroup/kevent vfs_open file=+0($arg2)' >> dynamic_events
> +! echo 'p:egroup/eevent vfs_open file=+0($arg2)' >> dynamic_events
> +! echo 'p:syscalls/sys_enter_open vfs_open file=+0($arg2)' >> dynamic_events
> +
> +echo '-:egroup/eevent' >> dynamic_events
> +echo '-:kgroup/kevent' >> dynamic_events
> +
> +clear_trace
> -- 
> 2.30.2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
