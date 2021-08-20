Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95D3F2439
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 02:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhHTArT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 20:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233644AbhHTArT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 20:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DDE060FDA;
        Fri, 20 Aug 2021 00:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629420402;
        bh=gKN7gx8PX+ih/o/6BTY2lm55czR9ZZKPxulLys7jVQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R823YqEzVPjKasv1ESpoEkS++umC0AXLAb6vxWuBwtY5nEU1FPk9Oz+/wtirc3c1j
         ICZMQHVXNu/X12J64b3eKJs4kCCwPvS35YQQ7hVHSOwF9H02R7zroE/5u1qf24PBjY
         WTHcd1DUmUusSm5Oqzdv/vbz1SMTECVUc4glhykCmmQM0Ab6yLAPNINIirQot3iOjW
         uMvIaUVxxpm6kWm4qrJ3HS8Y+7BTMATCCNzipTSbnLyMJbFgkWFRycX5ijpSD//Yt1
         +cOQtqGNpZxcZc1G4nARFsJFLrZvDo1Uk80lisZtc2WM2daf6nmhKf/HYp4CdZTrcq
         qiKOrmewpRteg==
Date:   Fri, 20 Aug 2021 09:46:39 +0900
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
Subject: Re: [PATCH v8 4/5] selftests/ftrace: Add selftest for testing
 eprobe events
Message-Id: <20210820094639.77a9d0eec97bde10e28f5b47@kernel.org>
In-Reply-To: <20210819152825.526931866@goodmis.org>
References: <20210819152604.704335282@goodmis.org>
        <20210819152825.526931866@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Aug 2021 11:26:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test to test event probes, by creating a synthetic event across
> sys_enter_openat and sys_exit_openat that passes the filename pointer from
> the enter of the system call to the exit, and then add an event probe to
> the synthetic event to make sure that the file name is seen.
> 
> Link: https://lkml.kernel.org/r/20210819041842.884828019@goodmis.org
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../test.d/dynevent/add_remove_eprobe.tc      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> new file mode 100644
> index 000000000000..7b242f29b916
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - add/remove eprobe events
> +# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
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

Hmm, can you make this more simple one without synthetic events?
Since synthetic event depends on CONFIG_SYNTH_EVENTS, you need to add
"synth_events" to 'requires' tag.
However, this means that this testcase doesn't run when CONFIG_SYNTH_EVENTS=n
but CONFIG_*PROBE_EVENTS=y.

Thank you,

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
