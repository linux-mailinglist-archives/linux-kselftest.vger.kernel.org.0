Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5B66182C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 19:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjAHSb5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjAHSbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 13:31:25 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E6BE08;
        Sun,  8 Jan 2023 10:31:24 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 8BBAF7E375;
        Sun,  8 Jan 2023 18:31:21 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673202684;
        bh=9umJdbd5KJp+UAquobmdtoTrKKFWq86YVx9C36KKXTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7NWNwnRsbgY/ky7Pr0tGgXFs9PhWyZ7zoHECB+EhKwbBt+dhqloDjPfoaP5niaUW
         96fqfpIMvsASqaE8lCwVaOVhEh+Fd/fgIDgt4/YychEgZiPABIFatwbl+YEkEGwP8S
         04KzDsYS4rGpvVISxChA7vjerSQxjXd4FxJkC0ruAZXXx33qPfsgkncN0or3oXl5Z7
         C7EHWCESCTlPOHQLq+XyFvRdqZAoNOCu5SM/ZEDy4z2XhzjAKEXMm0BX7VtLhkDRpD
         41/cXCqsUAeyj8vKDGOJZsIft4owS6YNUvoazObcyXK+h4FCXIHtUZ/7BQ1TmGAIel
         +qDcepXBz8V6g==
Date:   Mon, 9 Jan 2023 01:31:17 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] nolibc signal handling support
Message-ID: <Y7sL9U1dYkuWJ8rS@biznet-home.integral.gnuweeb.org>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
 <20230108175842.GB18859@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108175842.GB18859@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 08, 2023 at 06:58:42PM +0100, Willy Tarreau wrote:
> I'm currently testing it on various archs. For now:
> 
>   - x86_64 and arm64 pass the test

Thanks for testing.

>   - i386 and arm fail:
>       59 sigactiontest_sigaction_sig(2): Failed to set a signal handler
>        = -1 EINVAL                [FAIL]
>       60 signaltest_signal_sig(2): Failed to set a signal handler
>        = -1 EINVAL                   [FAIL]

I'll take a look at i386 for now.

>   - riscv and mips build are now broken:
>       sysroot/riscv/include/sys.h:1110:18: error: 'struct sigaction' has no member named 'sa_restorer'
>        1110 |         if (!act2.sa_restorer) {
>             |                  ^
>       sysroot/riscv/include/sys.h:1111:34: error: 'SA_RESTORER' undeclared (first use in this function); did you mean 'SA_RESTART'?
>        1111 |                 act2.sa_flags |= SA_RESTORER;
>             |                                  ^~~~~~~~~~~
>             |                                  SA_RESTART

Just a speculation:
This is probably because not all architectures have a SA_RESTORER. I'll
need to figure out how Linux handles signal on those architectures.

>   - s390 segfaults:
>       58 select_fault = -1 EFAULT              [OK]
>       59 sigactionqemu: uncaught target signal 11 (Segmentation fault) - core dumped
>       Segmentation fault
> 
>     It dies in __restore_rt at 1006ba4 while performing the syscall,
>     I don't know why, maybe this arch requires an alt stack or whatever :
> 
>       0000000001006ba0 <__restore_rt>:
>        1006ba0:       a7 19 00 ad             lghi    %r1,173
>        1006ba4:       0a 00                   svc     0
>        1006ba6:       07 07                   nopr    %r7

Bah, no clue on this. I'll CC s390 people in the next version and ask
them to shed some light.

> At the very least we need to make sure we don't degrade existing tests,
> which means making sure that it builds everywhere and that all those
> which build do work.

Understand.

> It would be nice to figure what's failing on i386. Given that both it
> and arm fail on EINVAL while both x86_64 and arm64 work, I suspect that
> once you figure what breaks i386 it'll fix the problem on arm at the
> same time. I had a quick look but didn't spot anything suspicious.
> Once we've figured this, we could decide to tag archs supporting
> sig_action() and condition the functions definition and the tests to
> these.

I'll be pondering this code this week (to follow what actually the
rt_sigaction wants on i386 and arm):

  https://github.com/torvalds/linux/blob/v6.2-rc3/kernel/signal.c#L4404-L4434

Hopefully, I can get it sorted before the weekend.

> The advantage of trying with i386 is that your regular tools and the
> debugger you used for x86_64 will work. I'm proceeding like this with
> the toolchains from https://mirrors.edge.kernel.org/pub/tools/crosstool/ :
> 
>  $ make nolibc-test LDFLAGS=-g CFLAGS=-g ARCH=i386 CC=/path/to/gcc-11.3.0-nolibc/i386-linux/bin/i386-linux-gcc
>  $ gdb ./nolibc-test
>  > b sigaction
>  > run
>  > s
>  ...

Nice tip! I'll be playing with that.

> Note that the code looks correct at first glance:
> 
> 0804b4a0 <__restore_rt>:
>  804b4a0:       b8 ad 00 00 00          mov    $0xad,%eax
>  804b4a5:       cd 80                   int    $0x80
> 
> I also think that the printf() in test_sigaction_sig() are not welcome
> as they corrupt the output. Maybe one thing you could do to preserve the
> info would be to prepend a space in front of the message and remove the
> LF. For example the simple patch below:
[...]
> Which is way more readable and still grep-friendly.

Yeah, that looks much better. Applied to my local git tree with
attribution.

-- 
Ammar Faizi

