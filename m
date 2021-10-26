Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAD43B296
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhJZMpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 08:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235791AbhJZMpo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 08:45:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA4F60F39;
        Tue, 26 Oct 2021 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635252200;
        bh=YBc8Em5aUfRy4S1XWYzleN8bqGvlhMEwzsJsr5FHZgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hk0OKeyyuA7z30tq4mnnLwUA/7RwBEpM8Z6pze3MEa/coy292optjdVFL+ZgFOKEx
         XJnqi+Qegm5O4SxAqMaNnW6IPjgBklgqBshc92/HzWf+OKKoPuuebdiuoVCTgEIIZP
         xmVtDmDRuppwwQ6AGS/VBMsuRnjfVrldtchXp2dtLtGzSvr3xJTCuvL0YyzfxJOgY6
         f1iISu4u9KNNUmBKAjaTCC7ibFpoaFfmRquY1M6p9lZnFqwNk6HiOqoGQIFKLHEmI7
         aGki21GL9hF2+Ae1C0tbcU4/9c6WQ6XVafjMHDspxbzdK+9ILag9EMHZwOo4tr9szq
         3Dj71IfqCx3Dg==
Date:   Tue, 26 Oct 2021 21:43:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-Id: <20211026214311.583c728d90d41778c38201dd@kernel.org>
In-Reply-To: <20211025200852.3002369-8-kaleshsingh@google.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-8-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kalesh,

On Mon, 25 Oct 2021 13:08:39 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Add tests for the parsing of hist trigger expressions; and to
> validate expression evaluation.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> ---
> 
> Changes in v3:
>   - Remove .sym-offset error check tests
> 
> Changes in v2:
>   - Add Namhyung's Reviewed-by
>   - Update comment to clarify err_pos in "Too many subexpressions" test
> 
> 
>  .../testing/selftests/ftrace/test.d/functions |  4 +-
>  .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 000fd05e84b1..1855a63559ad 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -16,13 +16,13 @@ reset_tracer() { # reset the current tracer
>  
>  reset_trigger_file() {
>      # remove action triggers first
> -    grep -H ':on[^:]*(' $@ |
> +    grep -H ':on[^:]*(' $@ | tac |
>      while read line; do
>          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
>  	file=`echo $line | cut -f1 -d:`
>  	echo "!$cmd" >> $file
>      done
> -    grep -Hv ^# $@ |
> +    grep -Hv ^# $@ | tac |
>      while read line; do
>          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
>  	file=`echo $line | cut -f1 -d:`

If this update has any meaning, please make a separate patch for this part.

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> new file mode 100644
> index 000000000000..e715641c54d3
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> @@ -0,0 +1,72 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test histogram expression parsing
> +# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log

Hmm, are there any way to check the running kernel supports this feature?
Because the latest version of the kselftest is expected to run on the old stable
kernel for testing, the testcase should check whether the kernel supports this
testing feature or not. (That's why the requires tag supports README pattern check)

So, at first if you didn't update the <tracefs>/README, please update it first
to show the new syntax is supported, and add "SOME-PATTERN":README to the
requires tag.

Thank you,

> +
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +get_hist_var() { #var_name hist_path
> +    hist_output=`grep -m1 "$1: " $2`
> +    hitcount=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "hitcount:") print $(i+1)} }'`
> +    var_sum=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "'$1':") print $(i+1)} }'`
> +    var_val=$(( var_sum / hitcount ))
> +    echo $var_val
> +}
> +
> +test_hist_expr() { # test_name expression expected_val
> +    reset_trigger
> +
> +    echo "Test hist trigger expressions - $1"
> +
> +    echo "hist:keys=common_pid:x=$2" > events/sched/sched_process_fork/trigger
> +    echo 'hist:keys=common_pid:vals=$x' >> events/sched/sched_process_fork/trigger
> +    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> +
> +    actual=`get_hist_var x events/sched/sched_process_fork/hist`
> +
> +    if [ $actual != $3 ]; then
> +        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
> +    fi
> +
> +    reset_trigger
> +}
> +
> +check_error() { # test_name command-with-error-pos-by-^
> +    reset_trigger
> +
> +    echo "Test hist trigger expressions - $1"
> +    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" 'events/sched/sched_process_fork/trigger'
> +
> +    reset_trigger
> +}
> +
> +test_hist_expr "Variable assignment" "123" "123"
> +
> +test_hist_expr "Subtraction not associative" "16-8-4-2" "2"
> +
> +test_hist_expr "Division not associative" "64/8/4/2" "1"
> +
> +test_hist_expr "Same precedence operators (+,-) evaluated left to right" "16-8+4+2" "14"
> +
> +test_hist_expr "Same precedence operators (*,/) evaluated left to right" "4*3/2*2" "12"
> +
> +test_hist_expr "Multiplication evaluated before addition/subtraction" "4+3*2-2" "8"
> +
> +test_hist_expr "Division evaluated before addition/subtraction" "4+6/2-2" "5"
> +
> +# Division by zero returns -1
> +test_hist_expr "Handles division by zero" "3/0" "-1"
> +
> +# err pos for "too many subexpressions" is dependent on where
> +# the last subexpression was detected. This can vary depending
> +# on how the expression tree was generated.
> +check_error "Too many subexpressions" 'hist:keys=common_pid:x=32+^10*3/20-4'
> +check_error "Too many subexpressions" 'hist:keys=common_pid:x=^1+2+3+4+5'
> +
> +check_error "Unary minus not supported in subexpression" 'hist:keys=common_pid:x=-(^1)+2'
> +
> +exit 0
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
