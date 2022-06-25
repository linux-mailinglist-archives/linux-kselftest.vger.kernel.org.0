Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93055ABB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiFYRFe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiFYRFe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 13:05:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D415A1C;
        Sat, 25 Jun 2022 10:05:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 93-20020a9d02e6000000b0060c252ee7a4so4210221otl.13;
        Sat, 25 Jun 2022 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7H5SaYzv2eC4qn7QVIEB3Nk4jIz7zk3QKC77y/SmGCc=;
        b=PFQA8zKEBn+igmT4Fu1/pNnWCTfpaSL8OvfqluOElWHkZih788+XHnlr6wVt0uh/N5
         eCqSKeGUWbOL+WodDR5s34znFQOjK9V6P2CnHNAT3OuCN/Iytc5IJulpCe26mnrrmIsn
         gdDZ4Jb2ALLyTMfbZkluEnF306BhT4RRg0o59x+tiGeuw57jmWM9LzuPZRc4WKbDivEI
         WexCqhrp0MW7o3nq6/+9bV6lGPNUpWJxrJmpFq3qKeshDf8mU7+Pl0JjP2+6KqhNXqMD
         fFrOQ460vEdd/ThPd4DKofCwCf+aWSt+dhZHqsnEM5wACgQ7SeBEMpgp/1CSqpeXpevt
         09YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7H5SaYzv2eC4qn7QVIEB3Nk4jIz7zk3QKC77y/SmGCc=;
        b=bCQJkYIM2N+kPeIhv7yWyxylZrqH8NjRLtcM4G3HiJmoUVNDit8gkusmjoK6M3E3O6
         rAoCJcqp4ri90+jPwydAyuDQXvpF4aDtLgERpPIrmJQNBN29Gu4G/1pc4Mf7EtlcolBI
         7oquucBD+UudCY7nEQ7qcKidKkhDvVAXBEl6GZutWIGehmHXCjoAZ7ozdzKwRkBo8DDn
         i34/l8g1XtMqNYJiqjfFu6DwgNWU1Ham+vTACA7wo1Zeu5Qsvw4ZGxCW2hqLXgsTET/f
         QECzo61nCmx6prZC5MEB8g5P3s2GZU+ZlExQI3lp3Tpd3wAtHY7BlR/oDtH0OGEhJ4/4
         25+Q==
X-Gm-Message-State: AJIora9nZwgea9y1/Q8wTAxdiGSscTkxJt4cQ5KkldpM82FGVDRCccsM
        0VmXRnF72Q2zoj1OGy1VVtZaMWvJjx4RbGkYb+4=
X-Google-Smtp-Source: AGRyM1s+2CDw35sNXG+k+BeeSLuZ2+XvjSvgnJF6bOiWrH4ZyiipT1Fu03c+Wg/bd1jGN/8UbDPnhfatuRXn62NpBmQ=
X-Received: by 2002:a9d:4c85:0:b0:616:baf1:4307 with SMTP id
 m5-20020a9d4c85000000b00616baf14307mr1729295otf.381.1656176732601; Sat, 25
 Jun 2022 10:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220606160943.663180-1-xiehuan09@gmail.com> <20220606160943.663180-4-xiehuan09@gmail.com>
 <20220626010331.f2be529cfb52706d58bbdc2f@kernel.org>
In-Reply-To: <20220626010331.f2be529cfb52706d58bbdc2f@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 26 Jun 2022 01:05:20 +0800
Message-ID: <CAEr6+EB2_nfpZW00_4pDcvhqpO9abEPZNA5m8pU6DmNWPRKjEQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] trace/objtrace: Add testcases for objtrace
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Masami,

On Sun, Jun 26, 2022 at 12:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> This looks good to me (and I tested).
>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> BTW, please use 'selftests/ftrace:' tag instead of (or in addition to)
> 'trace/objtrace:' for the ftracetest patch. And please Cc to
> linux-kselftest@vger.kernel.org and Shuah Khan.

Thanks for the reminder, I will do it like this in my next version.

> Thank you,
>
> On Tue,  7 Jun 2022 00:09:42 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Add a series of testcases to illustrate correct and incorrect usage of
> > objtrace trigger.
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> > new file mode 100644
> > index 000000000000..d894442b6a30
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> > @@ -0,0 +1,41 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test objtrace-trigger
> > +# requires: kprobe_events "objtrace":README
> > +
> > +fail() { #msg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +echo 'p bio_add_page arg1=$arg1 arg2=$arg2' > kprobe_events
> > +
> > +FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
> > +if [ -z "$FEATURE" ]; then
> > +    echo "objtrace trigger is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +echo "Test objtrace trigger"
> > +echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > \
> > +     events/kprobes/p_bio_add_page_0/trigger
> > +if [ -z $? ]; then
> > +     fail "objtrace trigger syntax error"
> > +fi
> > +
> > +echo "Test objtrace semantic errors"
> > +
> > +# Being lack of objtrace command
> > +! echo 'objtrace:arg1,0x28:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> > +# Bad parameter name
> > +! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> > +# The parameter existed on event
> > +! echo 'objtrace:add:arg2:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> > +
> > +echo "reset objtrace trigger"
> > +
> > +echo '!objtrace:add:arg1,0x28:u32' > \
> > +     events/kprobes/p_bio_add_page_0/trigger
> > +echo '-:p_bio_add_page_0' >> ./kprobe_events
> > +
> > +exit 0
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie
