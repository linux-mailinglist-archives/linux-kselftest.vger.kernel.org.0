Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39167511E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGLUjm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 16:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGLUjl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 16:39:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65665C0;
        Wed, 12 Jul 2023 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689194377; bh=Bv1FBLS0imEYqyDXO06WSOGp+LcvozRCbruE7WI3Jd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8awcXtzB6DxFLJ+qYGSHN6okWFP0MeMDxEv2DsDe8HOSZWS4zJ/oPzDPK74JHCqF
         CmZjzXLhGgAItOrcctkBK4SJ4pJckjjEXi0cB2Y6D9+ia8tyVc/GbfRLcekO+FpjsQ
         oGp0IIiD5uFg5j7YZjT8C4Gyiu1mo65VHYov7c7c=
Date:   Wed, 12 Jul 2023 22:39:36 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Message-ID: <a00284a6-54b1-498c-92aa-44997fa78403@t-8ch.de>
References: <cover.1689150149.git.falcon@tinylab.org>
 <ef5b9900a84bdbbc59eb4319e3260a6e29d24f68.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef5b9900a84bdbbc59eb4319e3260a6e29d24f68.1689150149.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-12 17:17:39+0800, Zhangjin Wu wrote:
> As the environ and _auxv support added for nolibc, the assembly _start
> function becomes more and more complex and therefore makes the porting
> of nolibc to new architectures harder and harder.
> 
> To simplify portability, this C version of _start_c() is added to do
> most of the assembly start operations in C, which reduces the complexity
> a lot and will eventually simplify the porting of nolibc to the new
> architectures.
> 
> The new _start_c() only requires a stack pointer argument, it will find
> argv, envp and _auxv for us, and then call main(), finally, it exit()
> with main's return status. With this new _start_c(), the future new
> architectures only require to add very few assembly instructions.
> 
> As suggested by Thomas, users may use a different signature of main
> (e.g. void main(void)), a _nolibc_main alias is added for main to
> silence the warning about potential conflicting types.
> 
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/lkml/90fdd255-32f4-4caf-90ff-06456b53dac3@t-8ch.de/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/Makefile |  1 +
>  tools/include/nolibc/crt.h    | 59 +++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 tools/include/nolibc/crt.h
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index 64d67b080744..909b6eb500fe 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -27,6 +27,7 @@ nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
>  arch_file := arch-$(nolibc_arch).h
>  all_files := \
>  		compiler.h \
> +		crt.h \
>  		ctype.h \
>  		errno.h \
>  		nolibc.h \
> diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> new file mode 100644
> index 000000000000..f9db2389acd2
> --- /dev/null
> +++ b/tools/include/nolibc/crt.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * C Run Time support for NOLIBC
> + * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
> + */
> +
> +#ifndef _NOLIBC_CRT_H
> +#define _NOLIBC_CRT_H
> +
> +char **environ __attribute__((weak));
> +const unsigned long *_auxv __attribute__((weak));
> +
> +typedef int (_nolibc_main_fn)(int, char **, char **);

What's the advantage of the typedef over using the pointer type inline?

> +static void exit(int);
> +
> +void _start_c(long *sp)
> +{
> +	int argc, i;
> +	char **argv;
> +	char **envp;
> +	/* silence potential warning: conflicting types for 'main' */
> +	_nolibc_main_fn _nolibc_main __asm__ ("main");

What about the stackprotector initialization?
It would really fit great into this series.

> +
> +	/*
> +	 * sp  :  argc          <-- argument count, required by main()
> +	 * argv:  argv[0]       <-- argument vector, required by main()
> +	 *        argv[1]
> +	 *        ...
> +	 *        argv[argc-1]
> +	 *        null
> +	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
> +	 *        envp[1]
> +	 *        ...
> +	 *        null
> +	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
> +	 *        auxv[1]
> +	 *        ...
> +	 *        null
> +	 */
> +
> +	/* assign argc and argv */
> +	argc = sp[0];
> +	argv = (void *)(sp + 1);

Bit of a weird mismatch between array syntax and pointer arithmetic.

> +
> +	/* find envp */
> +	envp = argv + argc + 1;
> +	environ = envp;

Is envp really needed? Could just be assigned directly to environ.

> +
> +	/* find auxv */
> +	i = 0;
> +	while (envp[i])
> +		i++;
> +	_auxv = (void *)(envp + i + 1);

Could be simplified a bit:

_auxv = (void *) envp;
while (_auxv)
	_auxv++;

> +
> +	/* go to application */
> +	exit(_nolibc_main(argc, argv, envp));
> +}
> +
> +#endif /* _NOLIBC_CRT_H */
> -- 
> 2.25.1
> 
