Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4163F37EF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 03:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhHUBla (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 21:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHUBl3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 21:41:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F5F61163;
        Sat, 21 Aug 2021 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629510051;
        bh=yKkJ4SLfNYw+uYg298yLZSt7Kzso3olgvrYqbSi4JpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tirdiOdTmkhhkR0Rj6yNbP3zMxa/wl6C1Hr8R3Z7pR7FoEnwrYzeEebuJM0/yPYje
         7QE7DH5NkZDJf0v7XtM/8XrAj3rlJPIC3aK3ZtRdkH7fqRQwR90lG8ZfnGr0/e8Ar/
         m5BF0a9egBr65g3MsULoK9eekLiTLStfoaIiU8rh3upNj+0vJsCXU2N5b2WKwo2rNT
         iFfKx55e+z/GHIb2GRaF9CX/nhrQWYwp6KOXzp3k7iJcpQwpSbcl+zV/IU/YyrHDKt
         WJTx3/wrqB7R6ZFMyFct2mzPnk3RhBvUYWiY8a8xVsiYXp62iXWFQgxO3F1q2y+Kc+
         Bm0f+o+dRR6EQ==
Date:   Sat, 21 Aug 2021 10:40:48 +0900
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
Subject: Re: [PATCH v9 4/6] selftests/ftrace: Add test case to test adding
 and removing of event probe
Message-Id: <20210821104048.2eeda1067909e7df0771bef6@kernel.org>
In-Reply-To: <20210820204742.274591200@goodmis.org>
References: <20210820204644.546662591@goodmis.org>
        <20210820204742.274591200@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 20 Aug 2021 16:46:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test case that adds an event probe, makes sure that it works, and
> then removes it.
> 
> Link: https://lore.kernel.org/linux-kselftest/20210819152825.526931866@goodmis.org/
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  .../test.d/dynevent/add_remove_eprobe.tc      | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> new file mode 100644
> index 000000000000..25a3da4eaa44
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - add/remove eprobe events
> +# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
> +
> +echo 0 > events/enable
> +
> +clear_dynamic_events
> +
> +SYSTEM="syscalls"
> +EVENT="sys_enter_openat"
> +FIELD="filename"
> +EPROBE="eprobe_open"
> +
> +echo "e:$EPROBE $SYSTEM/$EVENT file=+0(\$filename):ustring" >> dynamic_events
> +
> +grep -q "$EPROBE" dynamic_events
> +test -d events/eprobes/$EPROBE
> +
> +echo 1 > events/eprobes/$EPROBE/enable
> +ls
> +echo 0 > events/eprobes/$EPROBE/enable
> +
> +content=`grep '^ *ls-' trace | grep 'file='`
> +nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."'` || true
> +
> +if [ -z "$content" ]; then
> +	exit_fail
> +fi
> +
> +if [ ! -z "$nocontent" ]; then
> +	exit_fail
> +fi
> +
> +echo "-:$EPROBE" >> dynamic_events
> +
> +! grep -q "$EPROBE" dynamic_events
> +! test -d events/eprobes/$EPROBE
> +
> +clear_trace
> -- 
> 2.30.2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
