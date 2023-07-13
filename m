Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415167518A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 08:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjGMGMu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 02:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGMGMt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 02:12:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5044F1992;
        Wed, 12 Jul 2023 23:12:46 -0700 (PDT)
X-QQ-mid: bizesmtp91t1689228753t4c3q9ae
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 13 Jul 2023 14:12:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 8bAiRczmfHRwTspAsE5lUh6JC0H57C6KXRJ+mfOM3wtDtmURwWNd7+rwwEIM7
        elMTkr++KDM6+20L24hFX+YqDHlG3hD1Qxv3oHtmABGD9CuEv1U1WNyizqcVNXqsJW1C7Z+
        emygNCJBbZZF2QjGEYBtZNdtLc+Wdl5/wAEHgkiiEQeHDFnwLrfcWEeLraqodYI7LgTSAfh
        N55a2VYKPVKAYjF5kYI8JdJzy+8hrMPBpqAk8ZXZUETdYZFzDEy2zVgDNT2YK+IIHTfY6EK
        YwKSFiSUNP+94MQ+iYEWzxz6CpLx2plxqiRZURZzfmthtOyh+8meOUJEDX4GJXRWxTZsfN0
        /xmVQdN5DP9W1eVXdRshb3t4ZfqixRiAYVnIuP/
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 874338276069120476
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Thu, 13 Jul 2023 14:12:27 +0800
Message-Id: <20230713061227.43222-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a00284a6-54b1-498c-92aa-44997fa78403@t-8ch.de>
References: <a00284a6-54b1-498c-92aa-44997fa78403@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-07-12 17:17:39+0800, Zhangjin Wu wrote:
> > As the environ and _auxv support added for nolibc, the assembly _start
> > function becomes more and more complex and therefore makes the porting
> > of nolibc to new architectures harder and harder.
> > 
> > To simplify portability, this C version of _start_c() is added to do
> > most of the assembly start operations in C, which reduces the complexity
> > a lot and will eventually simplify the porting of nolibc to the new
> > architectures.
> > 
> > The new _start_c() only requires a stack pointer argument, it will find
> > argv, envp and _auxv for us, and then call main(), finally, it exit()
> > with main's return status. With this new _start_c(), the future new
> > architectures only require to add very few assembly instructions.
> > 
> > As suggested by Thomas, users may use a different signature of main
> > (e.g. void main(void)), a _nolibc_main alias is added for main to
> > silence the warning about potential conflicting types.
> > 
> > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > Link: https://lore.kernel.org/lkml/90fdd255-32f4-4caf-90ff-06456b53dac3@t-8ch.de/
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/Makefile |  1 +
> >  tools/include/nolibc/crt.h    | 59 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >  create mode 100644 tools/include/nolibc/crt.h
> > 
> > diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> > index 64d67b080744..909b6eb500fe 100644
> > --- a/tools/include/nolibc/Makefile
> > +++ b/tools/include/nolibc/Makefile
> > @@ -27,6 +27,7 @@ nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
> >  arch_file := arch-$(nolibc_arch).h
> >  all_files := \
> >  		compiler.h \
> > +		crt.h \
> >  		ctype.h \
> >  		errno.h \
> >  		nolibc.h \
> > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > new file mode 100644
> > index 000000000000..f9db2389acd2
> > --- /dev/null
> > +++ b/tools/include/nolibc/crt.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * C Run Time support for NOLIBC
> > + * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
> > + */
> > +
> > +#ifndef _NOLIBC_CRT_H
> > +#define _NOLIBC_CRT_H
> > +
> > +char **environ __attribute__((weak));
> > +const unsigned long *_auxv __attribute__((weak));
> > +
> > +typedef int (_nolibc_main_fn)(int, char **, char **);
> 
> What's the advantage of the typedef over using the pointer type inline?
>

With the extra comment added, this is not required anymore, will remove
this typedef.

> > +static void exit(int);
> > +
> > +void _start_c(long *sp)
> > +{
> > +	int argc, i;
> > +	char **argv;
> > +	char **envp;
> > +	/* silence potential warning: conflicting types for 'main' */
> > +	_nolibc_main_fn _nolibc_main __asm__ ("main");
> 
> What about the stackprotector initialization?
> It would really fit great into this series.
>

Ok, which gcc version supports stackprotector? seems the test even skip
on gcc 10, I will find one to verify the code change.

> > +
> > +	/*
> > +	 * sp  :  argc          <-- argument count, required by main()
> > +	 * argv:  argv[0]       <-- argument vector, required by main()
> > +	 *        argv[1]
> > +	 *        ...
> > +	 *        argv[argc-1]
> > +	 *        null
> > +	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
> > +	 *        envp[1]
> > +	 *        ...
> > +	 *        null
> > +	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
> > +	 *        auxv[1]
> > +	 *        ...
> > +	 *        null
> > +	 */
> > +
> > +	/* assign argc and argv */
> > +	argc = sp[0];
> > +	argv = (void *)(sp + 1);
> 
> Bit of a weird mismatch between array syntax and pointer arithmetic.
>

This 'argc = *sp;' may be better ;-)

> > +
> > +	/* find envp */
> > +	envp = argv + argc + 1;
> > +	environ = envp;
> 
> Is envp really needed? Could just be assigned directly to environ.
>

Ok, let's save one variable, envp is used to be consistent with the
frequenty declaration of main().

> > +
> > +	/* find auxv */
> > +	i = 0;
> > +	while (envp[i])
> > +		i++;
> > +	_auxv = (void *)(envp + i + 1);
> 
> Could be simplified a bit:
> 
> _auxv = (void *) envp;
> while (_auxv)
> 	_auxv++;
>

Yeah, it is better, but needs a little change.

    _auxv = (void *) envp;
    while (*_auxv)
	_auxv++;
    _auxv++;

Thanks,
Zhangjin

> > +
> > +	/* go to application */
> > +	exit(_nolibc_main(argc, argv, envp));
> > +}
> > +
> > +#endif /* _NOLIBC_CRT_H */
> > -- 
> > 2.25.1
> > 
