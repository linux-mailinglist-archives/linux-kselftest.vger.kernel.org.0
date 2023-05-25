Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F47102D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 04:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEYCYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 22:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjEYCYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 22:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68117139;
        Wed, 24 May 2023 19:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03EB1635A0;
        Thu, 25 May 2023 02:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0FEC433D2;
        Thu, 25 May 2023 02:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684981453;
        bh=1XyJN682bKPmnrFMOUA/Rz8FyBhig9nJpB9ztqCBcMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UDEj8I3OQISu5wf/9VcTweiPKsdAojV5u/bdpiZ76ZZeRJmm0NuU7d2PHyvTL7njK
         d8A3DpR/AMg7zrSetNBn/55/5Pza0YtFdIa1gBPMaKMEdDWqnNgTYnRKHLGXjuK7/U
         WF/mQ7Hj/+wVbSO/gMBsnUPvndFEW5x+k+l0WgzjrO1aoMnDePhaHyLqb9ZKNFUi6G
         zyZxqHGByC7Ds0cjyCxvWacmZrytuaPkhQ57OjM5fuRl1J7H/DCAdTgNSjDPsF+MBv
         6MN1Eqc1YhJud4XYlX5di0PEFunkYoxqOkqg/nn6loUCe8yFTzWo4JECqhvOyaYZWe
         eAR7Fy5Kq1lMQ==
Date:   Thu, 25 May 2023 10:24:08 +0800
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing/selftests: Update synthetic event selftest to
 use common_stacktrace
Message-Id: <20230525102408.4b2750621cb1deeb05e58980@kernel.org>
In-Reply-To: <20230523225402.55951f2f@rorschach.local.home>
References: <20230523225402.55951f2f@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 23 May 2023 22:54:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> With the rename of the stacktrace field to common_stacktrace, update the
> selftests to reflect this change. Copy the current selftest to test the
> backward compatibility "stacktrace" keyword. Also the "requires" of that
> test was incorrect, so it would never actually ran before. That is fixed
> now.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  .../trigger-synthetic-event-stack-legacy.tc   | 24 +++++++++++++++++++
>  .../trigger-synthetic-event-stack.tc          |  5 ++--
>  2 files changed, 26 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc
> new file mode 100644
> index 000000000000..d0cd91a93069
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger trace action with dynamic string param (legacy stack)
> +# requires: set_event synthetic_events events/sched/sched_process_exec/hist "long[] stack' >> synthetic_events":README
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo "Test create synthetic event with stack"
> +
> +# Test the old stacktrace keyword (for backward compatibility)
> +echo 's:wake_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
> +echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
> +echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(wake_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
> +echo 1 > events/synthetic/wake_lat/enable
> +sleep 1
> +
> +if ! grep -q "=>.*sched" trace; then
> +    fail "Failed to create synthetic event with stack"
> +fi
> +
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
> index 755dbe94ccf4..8f1cc9a86a06 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
> -# requires: set_event synthetic_events events/sched/sched_process_exec/hist "long[]' >> synthetic_events":README
> +# requires: set_event synthetic_events events/sched/sched_process_exec/hist "can be any field, or the special string 'common_stacktrace'":README
>  
>  fail() { #msg
>      echo $1
> @@ -10,9 +10,8 @@ fail() { #msg
>  
>  echo "Test create synthetic event with stack"
>  
> -
>  echo 's:wake_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
> -echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
> +echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=common_stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
>  echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(wake_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
>  echo 1 > events/synthetic/wake_lat/enable
>  sleep 1
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
