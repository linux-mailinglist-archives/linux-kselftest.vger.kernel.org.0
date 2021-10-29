Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67643F6A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 07:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhJ2F3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 01:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhJ2F3t (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 01:29:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 460B460E8B;
        Fri, 29 Oct 2021 05:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635485241;
        bh=dnYSGUCJcklBjUcXGtlK8BIT0TI1nr/ntPVW2d/mYtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZMFdlUfEbJcD78kBHt/dNn4QVWc7XZBZxYPqC5MGYazbmqG+SWFiscGo4SudQUgpq
         L+AbMphsTXkYLCyjKSO/VnBl/yaY6eaAOcnpPMNNGNS6zpfAo539n1cXw+v3/IEr4c
         MWk4vAxlw+F3COestUiamFNUV4Hw3lwy14TohYZumSf3B0qgGUnG1Ns5hEmyvwDLrh
         79BTQ0Lgt2tliZbIWyQCk20ThaN7GovQB68zBqr5bKE7j3Q31px55V4iuCZ1FTnRKC
         0rVt2LBkkUz6Nq+53xLcCcUj4VcDXpBV4cVlluauj0Q8nXIQKeWVK4kBV/xU02/HP4
         CtedOxWfp6B6g==
Date:   Fri, 29 Oct 2021 14:27:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-Id: <20211029142717.d332e2a9991fe813f6f8625f@kernel.org>
In-Reply-To: <20211028195805.2684854-3-kaleshsingh@google.com>
References: <20211028195805.2684854-1-kaleshsingh@google.com>
        <20211028195805.2684854-3-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 28 Oct 2021 12:57:58 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Add tests for the parsing of hist trigger expressions; and to
> validate expression evaluation.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
> Changes in v6:
>   - Read the expression result from the trigger file,
>     instead of creating a histogram to print the value.
> 
> Changes in v5:
>   - Add README pattern to requires tag, per Masami
> 
> Changes in v3:
>   - Remove .sym-offset error check tests
> 
> Changes in v2:
>   - Add Namhyung's Reviewed-by
>   - Update comment to clarify err_pos in "Too many subexpressions" test
> 
> 
>  .../trigger/trigger-hist-expressions.tc       | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> new file mode 100644
> index 000000000000..33eb79589b32
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test histogram expression parsing
> +# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log "<var1>=<field|var_ref|numeric_literal>":README
> +
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +test_hist_expr() { # test_name expression expected_val
> +    trigger="events/sched/sched_process_fork/trigger"
> +
> +    reset_trigger_file $trigger
> +
> +    echo "Test hist trigger expressions - $1"
> +
> +    echo "hist:keys=common_pid:x=$2" > $trigger
> +
> +    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> +
> +    x=`grep -o 'x=[[:digit:]]*' $trigger | awk -F= '{ print $2 }'`
> +    actual=$(( x + 0 )) # To print negative numbers correctly
> +
> +    if [ $actual != $3 ]; then
> +        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
> +    fi
> +
> +    reset_trigger_file $trigger
> +}
> +
> +check_error() { # test_name command-with-error-pos-by-^
> +    trigger="events/sched/sched_process_fork/trigger"
> +
> +    echo "Test hist trigger expressions - $1"
> +    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" $trigger
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
