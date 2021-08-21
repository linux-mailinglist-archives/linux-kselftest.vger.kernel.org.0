Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D523F37ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 03:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhHUBjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 21:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhHUBjG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 21:39:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA0F6115A;
        Sat, 21 Aug 2021 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629509907;
        bh=Ho9JVlJs97ztPR9AJtuL3+94U2yv6sPg84bnD6MpLZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JYvvqLcWtv/C8HQczf9GpGViuQTrSo6ky4irszjp/rg0J25NnOw+N6bLyW14MwiuF
         /GN6z6GV5fHb0smSoIlFkGNvvqBc0nmuqTpGpknME06aBkGkuYqrVRoVXUTCZrKdmQ
         2jH9QMxP75L4B5N+TpvXQGRmxy25xyvgcshzqqr5q4KNt8DaUot2Cn49vi5lk7TOLY
         v2KesOxAsiIq0MQHYhFR6v8LEU/yST9VGoSQf7KVDh/gTTwheXoPRPHwKKcepGkqLp
         P9IKtFCu6ThZkO7iuYBHIL9L9VgtxELzDsKybRFSocBbUNnu0FiAWYBMMoGhEMwHIB
         uRoEfKIv269gA==
Date:   Sat, 21 Aug 2021 10:38:23 +0900
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
Subject: Re: [PATCH v9 5/6] selftests/ftrace: Add selftest for testing
 eprobe events on synthetic events
Message-Id: <20210821103823.3991d3b48ade660c8e33e637@kernel.org>
In-Reply-To: <20210820204742.463259900@goodmis.org>
References: <20210820204644.546662591@goodmis.org>
        <20210820204742.463259900@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 20 Aug 2021 16:46:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test to test event probes, by creating a synthetic event across
> sys_enter_openat and sys_exit_openat that passes the filename pointer from
> the enter of the system call to the exit, and then add an event probe to
> the synthetic event to make sure that the file name is seen.
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
>  .../inter-event/trigger-synthetic-eprobe.tc   | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
> new file mode 100644
> index 000000000000..914fe2e5d030
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger eprobe on synthetic event
> +# requires: dynamic_events synthetic_events events/syscalls/sys_enter_openat/hist "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
> +
> +echo 0 > events/enable
> +
> +clear_dynamic_events
> +
> +SYSTEM="syscalls"
> +START="sys_enter_openat"
> +END="sys_exit_openat"
> +FIELD="filename"
> +SYNTH="synth_open"
> +EPROBE="eprobe_open"
> +
> +echo "$SYNTH u64 filename; s64 ret;" > synthetic_events
> +echo "hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
> +echo "hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger
> +
> +echo "e:$EPROBE synthetic/$SYNTH file=+0(\$filename):ustring ret=\$ret:s64" >> dynamic_events
> +
> +grep -q "$SYNTH" dynamic_events
> +grep -q "$EPROBE" dynamic_events
> +test -d events/synthetic/$SYNTH
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
> +echo '!'"hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger
> +echo '!'"hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
> +echo '!'"$SYNTH u64 filename; s64 ret;" >> synthetic_events
> +
> +! grep -q "$SYNTH" dynamic_events
> +! grep -q "$EPROBE" dynamic_events
> +! test -d events/synthetic/$SYNTH
> +! test -d events/eprobes/$EPROBE
> +
> +clear_trace
> -- 
> 2.30.2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
