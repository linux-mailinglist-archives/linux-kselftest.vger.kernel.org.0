Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51CF7986C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjIHMIV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIHMIT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 08:08:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9B1BE7;
        Fri,  8 Sep 2023 05:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305A8C433C8;
        Fri,  8 Sep 2023 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174895;
        bh=kuk2AJFs2iERTGSGT8ELn/GGfY7dWDsEGrcndV0bjW8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EZ/lufYlWutUJ639Mli6RcFwAQf83eeD7Ggoy6A/xWHFt4sPCUu/Ch//ZjfBZgCsF
         QcHUWLS4y7jJ7aptoM7Jl8GNr6fCTM5bWIm+hyltlPr83TXrxteCGvdDV2yNOxRh0R
         7E/RGfxXGSEXMq9xCSyvFevWY5rCg5UsiAI3vTxhG2QGwbUlz69Y6/Epn6DAsKIwok
         Z7WBna1b10tTeKjHv/irVW3NY3WVsV0YvqDgLyNiOf6k8zUulUgbM541u3obK7M5Dc
         GBwglrgLeGWowL1IjQH1GmeKpCiuHJGlAOpOVFfDpd9iF9SspTl5QwKRftoVTAk7nG
         u8jWvcThdMqIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF506CE0FF4; Fri,  8 Sep 2023 05:08:14 -0700 (PDT)
Date:   Fri, 8 Sep 2023 05:08:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] rcu/torture: Improve badness extraction from console
 logs
Message-ID: <df66924b-d484-457f-8c79-21aadc4c13ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908033047.2537010-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908033047.2537010-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 08, 2023 at 03:30:46AM +0000, Joel Fernandes (Google) wrote:
> Currently console.log.diags contains an output like follows:
> [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.542385] Call Trace:
> 
> This is not very useful and easier access to the call trace is desired.
> Improve the script by extracting more lines after each grep match.
> Provide a summary in the beginning like before, but also include details
> below. Limit the total number of issues to a maximum of 10. And limit
> the lines included after each issue to a maximum of 20.

Much better!

The above commit log would be better something as follows:

------------------------------------------------------------------------

Currently console.log.diags contains a line for each issue that was
located in the console.log file, for example:

[ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.542385] Call Trace:

Although this is quite helpful when viewed using the kvm-find-errors.sh
script (in which case the console.log.diags file supplies the search
strings to use on the full console.log file that immediately follows), the
first splat often fully identifies the problem.  In such cases, it would
be helpful for this splat to be contained within the console.log.diags
file itself, without the need to refer to the full console.log file.

This commit therefore limits the number of issues summarized to 10,
and follows the summaries with up to 20 lines of the console.log file
associated with each issue.

------------------------------------------------------------------------

Plus please see one simplification below.

							Thanx, Paul

> With these changes the output becomes:
> 
> Issues found:
> Line 6228: [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> Line 6245: [ 2457.542385] Call Trace:
> 
> Details of each issue:
> Issue 1 (line 6228):
> [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.326661] Modules linked in:
> [ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.128+ #381
> [ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
> [...]
> [ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
> [ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 0000000000000003
> [ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 0000000000000003
> [ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000001
> [ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff8db902d87f40
> [ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: ffff8db9011a3200
> [ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000) knlGS:0000000000000000
> [ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 00000000000006e0
> [ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2457.542385] Call Trace:
> [ 2457.546756]  <TASK>
> [ 2457.550349]  ? __warn+0x7b/0x100
> [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> -------------------------------------
> Issue 2 (line 6245):
> [ 2457.542385] Call Trace:
> [ 2457.546756]  <TASK>
> [ 2457.550349]  ? __warn+0x7b/0x100
> [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.574948]  ? report_bug+0x99/0xc0
> [ 2457.593824]  ? handle_bug+0x3c/0x70
> [ 2457.599534]  ? exc_invalid_op+0x13/0x60
> [ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
> [ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
> [ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
> [ 2457.705658]  rcu_tasks_kthread+0x114/0x200
> [ 2457.712450]  ? wait_woken+0x70/0x70
> [ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
> [ 2457.746221]  kthread+0x130/0x160
> [ 2457.751487]  ? set_kthread_struct+0x40/0x40
> [ 2457.758178]  ret_from_fork+0x22/0x30
> [ 2457.763909]  </TASK>
> [ 2457.767546] irq event stamp: 29544441
> [ 2457.773344] hardirqs last  enabled at (29544451): [<ffffffffaace6cbd>] __up_console_sem+0x4d/0x60
> [ 2457.786967] hardirqs last disabled at (29544460): [<ffffffffaace6ca2>] __up_console_sem+0x32/0x60
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: Limit number of issues reported and include summary on the top.
> 
>  .../rcutorture/bin/console-badness.sh         | 42 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
> index aad51e7c0183..2612a4931723 100755
> --- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
> +++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
> @@ -9,10 +9,50 @@
>  # Copyright (C) 2020 Facebook, Inc.
>  #
>  # Authors: Paul E. McKenney <paulmck@kernel.org>
> +INPUT_DATA=$(< /dev/stdin)

Long runs can have extremely large console.log files, which might not
play well with shell variables.  So this really needs to go into a file.
An easy way to do that is like this:

------------------------------------------------------------------------

T="`mktemp -d ${TMPDIR-/tmp}/console-badness.sh.XXXXXX`"
trap 'rm -rf $T' 0

------------------------------------------------------------------------

The "trap" statement auto-removes this temporary directory when the
script exits.

Then dump stdin to $T/console.  Or, better, change console-badness.sh to
take the console file name as a parameter instead of taking its contents
on stdin.  (It appears to be invoked from very few places.)

> +MAX_NR_ISSUES=10
>  
> -grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
> +# Get the line numbers for all the grep matches
> +GREP_LINES="$(echo "$INPUT_DATA" |
> +grep -n -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
>  grep -v 'ODEBUG: ' |
>  grep -v 'This means that this is a DEBUG kernel and it is' |
>  grep -v 'Warning: unable to open an initial console' |
>  grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr.*the init process!' |
>  grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
> +)"

Then redirect the above grep to "$T/badness-nbr" or some such.

> +
> +# Exit if no grep matches
> +if [ ! -n "$GREP_LINES" ]; then exit 0; fi
> +
> +# Print first MAX_NR_ISSUES grepped lines
> +echo "Issues found:"
> +issue_num=1
> +while IFS= read -r line; do
> +    # Extract the line number from the line
> +    num=$(echo "$line" | awk -F: '{print $1}')
> +    # Extract the rest of the line
> +    line_rest=$(echo "$line" | cut -d: -f2-)
> +    echo "Line $num: $line_rest"
> +    if [ "$issue_num" -eq "$MAX_NR_ISSUES" ]; then break; fi
> +    issue_num="$(($issue_num + 1))"
> +done <<< "$GREP_LINES"
> +echo ""

The above then collapses into something like this:

sed < $T/badness-nbr -e 's/^[0-9]*:/Line & /' | head -"${MAX_NR_ISSUES}"

> +
> +# Print details of each issue
> +#
> +# Go through each line of GREP_LINES, extract the line number and then
> +# print from that line and 20 lines after that line. Do that for each
> +# grep match upto MAX_NR_ISSUES of them.
> +echo "Details of each issue:"
> +issue_num=1
> +while IFS= read -r line; do
> +    # Extract the line number from the line
> +    num=$(echo "$line" | awk -F: '{print $1}')
> +    # Print 20 lines after the matched line
> +    echo "Issue $issue_num (line $num):"
> +    echo "$INPUT_DATA" | sed -n "${num},$(($num + 20))p"
> +    echo "-------------------------------------"
> +    if [ "$issue_num" -eq "$MAX_NR_ISSUES" ]; then break; fi
> +    issue_num="$(($issue_num + 1))"
> +done <<< "$GREP_LINES"

And the above also takes input from the file.

One issue here is that if a number of badness strings occur in console.log
in quick succession, there will be overlapping output, as in a given line
from console.log might be printed many times.  For example, "WARNING"
is often almost immediately followed by "Call Trace".

In that case, is there a nice way to print the lines starting with the
line containing "WARNING" though the 20 lines following "Call Trace"?

							Thanx, Paul
