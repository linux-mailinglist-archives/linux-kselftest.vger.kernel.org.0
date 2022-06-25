Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A497B55AB7B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiFYQDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiFYQDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 12:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9397167C5;
        Sat, 25 Jun 2022 09:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E10614A5;
        Sat, 25 Jun 2022 16:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5D6C3411C;
        Sat, 25 Jun 2022 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656173020;
        bh=Nm9Kq1mPpAwvoFQ5aO8nckAWwFXmXRyMc8c+8G2UCYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tWMXFB9der/tIjStzUHMj6gPTSKPJWmZqIPsVGDcMgCyN/Fg0tuDuw1pfnl2VPI9F
         u1j0agoIeajVBMe35jqHpnJwLm9x962ZfoBAEvbQ1U5RPlf3OuqqfWg0s/Qfaf8512
         dWqJ+mUEaHbLj7ieUUYraGIAeZLkdE2KEgpvaL4zdknGlCm6T+3D4rceA/RScrhNuZ
         kkP1DUaGIhKEKA2VUOpIOoW1XofpdBu/BvRoGdgumm8aqVAgOiQXwoDlnuh7OeqzPR
         EhndDoB7CizQasDVR5vbkxu+iMW/2QRKxqlrJyBHXzWlCUuQflFpmWX6z94+iLsE+D
         zal5bErietZcw==
Date:   Sun, 26 Jun 2022 01:03:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v12 3/4] trace/objtrace: Add testcases for objtrace
Message-Id: <20220626010331.f2be529cfb52706d58bbdc2f@kernel.org>
In-Reply-To: <20220606160943.663180-4-xiehuan09@gmail.com>
References: <20220606160943.663180-1-xiehuan09@gmail.com>
        <20220606160943.663180-4-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This looks good to me (and I tested).

Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, please use 'selftests/ftrace:' tag instead of (or in addition to)
'trace/objtrace:' for the ftracetest patch. And please Cc to
linux-kselftest@vger.kernel.org and Shuah Khan.

Thank you,

On Tue,  7 Jun 2022 00:09:42 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Add a series of testcases to illustrate correct and incorrect usage of
> objtrace trigger.
> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> new file mode 100644
> index 000000000000..d894442b6a30
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test objtrace-trigger
> +# requires: kprobe_events "objtrace":README
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo 'p bio_add_page arg1=$arg1 arg2=$arg2' > kprobe_events
> +
> +FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
> +if [ -z "$FEATURE" ]; then
> +    echo "objtrace trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +echo "Test objtrace trigger"
> +echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > \
> +	events/kprobes/p_bio_add_page_0/trigger
> +if [ -z $? ]; then
> +	fail "objtrace trigger syntax error"
> +fi
> +
> +echo "Test objtrace semantic errors"
> +
> +# Being lack of objtrace command
> +! echo 'objtrace:arg1,0x28:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +# Bad parameter name
> +! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +# The parameter existed on event
> +! echo 'objtrace:add:arg2:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +
> +echo "reset objtrace trigger"
> +
> +echo '!objtrace:add:arg1,0x28:u32' > \
> +	events/kprobes/p_bio_add_page_0/trigger
> +echo '-:p_bio_add_page_0' >> ./kprobe_events
> +
> +exit 0
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
