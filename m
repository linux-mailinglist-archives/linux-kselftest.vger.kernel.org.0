Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA06443B411
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 16:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhJZOb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbhJZObW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B59C06122E
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 07:28:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1834827pjb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lurf7pLmFfI8PFqHVx6TDwHnjD6o21b/FbSCQOL4ZwA=;
        b=kyJREW0kMU2y5W01Tp8hmPQxtDJafRxlr1A/Heu3XNDIF1+OOngkjBp7l/UbHLSSS9
         WgkFV+hQ+r8y6kI3VijZ6K6AUu3yqvcg+yYjE1hW2pqKZqqvQRigIU/3NV5q8xh2MQAi
         SAP2MsyjU7+gQQ/3EJitOymtYcpD0VV9q/r2md6ecKZW4QV+iuu3JQ9Qx1SLMfdbQZ4J
         EhsC+/MfHTU3mQqve40aLRakdwwykEugm/QUsscB9BuWsaHiM/r0VsujGJt3Mz8Gwcz0
         LYibsNVpHh6hv/WVBTRZOim/Sm8d8jGW5heMoNorhlG/1/x6J5eJavazPg3y7zEZG2ex
         ZTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lurf7pLmFfI8PFqHVx6TDwHnjD6o21b/FbSCQOL4ZwA=;
        b=Px4O+VFDU0CoA+TttpO1W4W0Qn6alIFjhc7vT9FZJgA2Z55NlbTU61QiVLwVVle18f
         0ESXSTb2yhvp5yvsa3WCkbN6XKu39Y5iAdKmDIpOmcljILHtdboi1WBSAZa4tETWpFXv
         9URRuj/gKQBGmdO7L4f7psDSwxxuXDQA1z6Ry0q7KiFJkJBusC0uj6skSopfM1GY2jAS
         horGn5HtKbJjp99AYv71NfZCZYk5w1cQB3srF5IOj1aQYg/049ZicHBFY9T2zmL+D8QO
         1MMBEKXMvCNFI8flFiOirp2BN2Q3xadHUHaccNsoCGnGkrzlPdvkBb1gqRbtwJY8clsi
         psUA==
X-Gm-Message-State: AOAM533r2q9IoMnKtkirRdGBIRBrs7uHKLaPDjCJ2kQOVVimCzz2nfCO
        uhJWJEOsqDlvL9nbzTYvRbMFBd/FYSVhI63+z+lifA==
X-Google-Smtp-Source: ABdhPJzMJdJHE9L/b1rT+cs4ENyPqi8wu9eQIbr7CMebXBLB3zRikOsje5xfnU8hY9nFtgLTr4mWvqH3ADsOiDagAwY=
X-Received: by 2002:a17:903:183:b0:140:47c1:1f2e with SMTP id
 z3-20020a170903018300b0014047c11f2emr14674517plg.69.1635258530393; Tue, 26
 Oct 2021 07:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
 <20211025200852.3002369-8-kaleshsingh@google.com> <20211026214311.583c728d90d41778c38201dd@kernel.org>
In-Reply-To: <20211026214311.583c728d90d41778c38201dd@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Oct 2021 07:28:39 -0700
Message-ID: <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 5:43 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Kalesh,
>
> On Mon, 25 Oct 2021 13:08:39 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Add tests for the parsing of hist trigger expressions; and to
> > validate expression evaluation.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >
> > Changes in v3:
> >   - Remove .sym-offset error check tests
> >
> > Changes in v2:
> >   - Add Namhyung's Reviewed-by
> >   - Update comment to clarify err_pos in "Too many subexpressions" test
> >
> >
> >  .../testing/selftests/ftrace/test.d/functions |  4 +-
> >  .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
> >  2 files changed, 74 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > index 000fd05e84b1..1855a63559ad 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -16,13 +16,13 @@ reset_tracer() { # reset the current tracer
> >
> >  reset_trigger_file() {
> >      # remove action triggers first
> > -    grep -H ':on[^:]*(' $@ |
> > +    grep -H ':on[^:]*(' $@ | tac |
> >      while read line; do
> >          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> >       file=`echo $line | cut -f1 -d:`
> >       echo "!$cmd" >> $file
> >      done
> > -    grep -Hv ^# $@ |
> > +    grep -Hv ^# $@ | tac |
> >      while read line; do
> >          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> >       file=`echo $line | cut -f1 -d:`
>
> If this update has any meaning, please make a separate patch for this part.

Hi Masami,

Thanks for the feedback. The above change is to ensure we remove
triggers in the reverse order that we created them - important when
one trigger depends on another. I can split it out into a separate
patch and will add a README pattern check to the requires tag for
these tests.

Thanks,
Kalesh

>
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> > new file mode 100644
> > index 000000000000..e715641c54d3
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> > @@ -0,0 +1,72 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test histogram expression parsing
> > +# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log
>
> Hmm, are there any way to check the running kernel supports this feature?
> Because the latest version of the kselftest is expected to run on the old stable
> kernel for testing, the testcase should check whether the kernel supports this
> testing feature or not. (That's why the requires tag supports README pattern check)
>
> So, at first if you didn't update the <tracefs>/README, please update it first
> to show the new syntax is supported, and add "SOME-PATTERN":README to the
> requires tag.
>
> Thank you,
>
> > +
> > +
> > +fail() { #msg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +get_hist_var() { #var_name hist_path
> > +    hist_output=`grep -m1 "$1: " $2`
> > +    hitcount=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "hitcount:") print $(i+1)} }'`
> > +    var_sum=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "'$1':") print $(i+1)} }'`
> > +    var_val=$(( var_sum / hitcount ))
> > +    echo $var_val
> > +}
> > +
> > +test_hist_expr() { # test_name expression expected_val
> > +    reset_trigger
> > +
> > +    echo "Test hist trigger expressions - $1"
> > +
> > +    echo "hist:keys=common_pid:x=$2" > events/sched/sched_process_fork/trigger
> > +    echo 'hist:keys=common_pid:vals=$x' >> events/sched/sched_process_fork/trigger
> > +    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> > +
> > +    actual=`get_hist_var x events/sched/sched_process_fork/hist`
> > +
> > +    if [ $actual != $3 ]; then
> > +        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
> > +    fi
> > +
> > +    reset_trigger
> > +}
> > +
> > +check_error() { # test_name command-with-error-pos-by-^
> > +    reset_trigger
> > +
> > +    echo "Test hist trigger expressions - $1"
> > +    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" 'events/sched/sched_process_fork/trigger'
> > +
> > +    reset_trigger
> > +}
> > +
> > +test_hist_expr "Variable assignment" "123" "123"
> > +
> > +test_hist_expr "Subtraction not associative" "16-8-4-2" "2"
> > +
> > +test_hist_expr "Division not associative" "64/8/4/2" "1"
> > +
> > +test_hist_expr "Same precedence operators (+,-) evaluated left to right" "16-8+4+2" "14"
> > +
> > +test_hist_expr "Same precedence operators (*,/) evaluated left to right" "4*3/2*2" "12"
> > +
> > +test_hist_expr "Multiplication evaluated before addition/subtraction" "4+3*2-2" "8"
> > +
> > +test_hist_expr "Division evaluated before addition/subtraction" "4+6/2-2" "5"
> > +
> > +# Division by zero returns -1
> > +test_hist_expr "Handles division by zero" "3/0" "-1"
> > +
> > +# err pos for "too many subexpressions" is dependent on where
> > +# the last subexpression was detected. This can vary depending
> > +# on how the expression tree was generated.
> > +check_error "Too many subexpressions" 'hist:keys=common_pid:x=32+^10*3/20-4'
> > +check_error "Too many subexpressions" 'hist:keys=common_pid:x=^1+2+3+4+5'
> > +
> > +check_error "Unary minus not supported in subexpression" 'hist:keys=common_pid:x=-(^1)+2'
> > +
> > +exit 0
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
