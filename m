Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2602543D655
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ0WO5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 18:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhJ0WO5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 18:14:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED54B60E75;
        Wed, 27 Oct 2021 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635372751;
        bh=qDYo3qUo7XfTZD0MoKBSQuJOm3bh9eM3O0CK7xq0y4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTPoSM+NFFoCPZQle5PvcjGOM5OOYZM2caCgZb8ftod6yw1Rfn2FSwmO5IgVOlSnx
         P2upKErThXMT5mtRZ4Rvyn4FxfFTvmaFgvmEROAcd4IgD1m8uxzGIqi5IRJU0SJFGK
         AEns2ks5yw8ECdPUfKWmRj6KjmlLPAzFiI0bbQQaxZ4pPzsrEpA2T3WjBqqkfZMdil
         eleeJyNL+J57Ge2FLrOmfGHakLHxacbKB4l4ofyn8LX7IfFELEMt+CnM6ajeXULLR/
         86wNADmxJyKOajO4lLmyCT+7hLrBLCNmvnmHJjYOSeTKyEUslLsER5oUSaNqD8vFkj
         1uvc4mWH93DCQ==
Date:   Thu, 28 Oct 2021 07:12:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/3] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-Id: <20211028071226.9d1d0bd1f4a5d04999c1a9f0@kernel.org>
In-Reply-To: <20211027205919.1648553-4-kaleshsingh@google.com>
References: <20211027205919.1648553-1-kaleshsingh@google.com>
        <20211027205919.1648553-4-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 13:59:10 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Add tests for the parsing of hist trigger expressions; and to
> validate expression evaluation.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

This looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
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
>  .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> new file mode 100644
> index 000000000000..9690f9f809e7
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> @@ -0,0 +1,72 @@
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
