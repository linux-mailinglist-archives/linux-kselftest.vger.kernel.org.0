Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2C7518BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 08:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjGMGYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjGMGYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 02:24:11 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E0E74;
        Wed, 12 Jul 2023 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689229447; bh=a7APX/kSTGtDTOPilAbm4Krc1ZhrF3c7Z2w5GHNBF/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlYZ9cu3lJNU6d6HjadDVmng+zd8EEOo9c40+xTif8YrhEqLoyV/C6u1N/+VfrbM0
         JUunrQ4SBWZJIodbvTN/JBnVBzA2XKB8QfwHzViIJxrJlCv/XwrlIZN9kPQDd4kdVa
         xJ0k1G62zuF1QG9k5e+Lm2j/rc7h/bO22MWApcV0=
Date:   Thu, 13 Jul 2023 08:24:06 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Message-ID: <b76956bc-3292-4fc9-a37b-830951c27e2a@t-8ch.de>
References: <a00284a6-54b1-498c-92aa-44997fa78403@t-8ch.de>
 <20230713061227.43222-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713061227.43222-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-13 14:12:27+0800, Zhangjin Wu wrote:
> > On 2023-07-12 17:17:39+0800, Zhangjin Wu wrote:

> [..]

> > > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > > new file mode 100644
> > > index 000000000000..f9db2389acd2
> > > --- /dev/null
> > > +++ b/tools/include/nolibc/crt.h
> > > @@ -0,0 +1,59 @@
> > > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > > +/*
> > > + * C Run Time support for NOLIBC
> > > + * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
> > > + */
> > > +
> > > +#ifndef _NOLIBC_CRT_H
> > > +#define _NOLIBC_CRT_H
> > > +
> > > +char **environ __attribute__((weak));
> > > +const unsigned long *_auxv __attribute__((weak));
> > > +
> > > +typedef int (_nolibc_main_fn)(int, char **, char **);
> > 
> > What's the advantage of the typedef over using the pointer type inline?
> >
> 
> With the extra comment added, this is not required anymore, will remove
> this typedef.
> 
> > > +static void exit(int);
> > > +
> > > +void _start_c(long *sp)
> > > +{
> > > +	int argc, i;
> > > +	char **argv;
> > > +	char **envp;
> > > +	/* silence potential warning: conflicting types for 'main' */
> > > +	_nolibc_main_fn _nolibc_main __asm__ ("main");
> > 
> > What about the stackprotector initialization?
> > It would really fit great into this series.
> >
> 
> Ok, which gcc version supports stackprotector? seems the test even skip
> on gcc 10, I will find one to verify the code change.

For crosscompilation I use the crosstools from kernel.org at
https://mirrors.edge.kernel.org/pub/tools/crosstool/

It seems to be at least in their gcc 9.5.0.
And also in their 11.2 which I use mostly at the moment.

> > > +	/*
> > > +	 * sp  :  argc          <-- argument count, required by main()
> > > +	 * argv:  argv[0]       <-- argument vector, required by main()
> > > +	 *        argv[1]
> > > +	 *        ...
> > > +	 *        argv[argc-1]
> > > +	 *        null
> > > +	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
> > > +	 *        envp[1]
> > > +	 *        ...
> > > +	 *        null
> > > +	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
> > > +	 *        auxv[1]
> > > +	 *        ...
> > > +	 *        null
> > > +	 */
> > > +
> > > +	/* assign argc and argv */
> > > +	argc = sp[0];
> > > +	argv = (void *)(sp + 1);
> > 
> > Bit of a weird mismatch between array syntax and pointer arithmetic.
> >
> 
> This 'argc = *sp;' may be better ;-)
> 
> > > +
> > > +	/* find envp */
> > > +	envp = argv + argc + 1;
> > > +	environ = envp;
> > 
> > Is envp really needed? Could just be assigned directly to environ.
> >
> 
> Ok, let's save one variable, envp is used to be consistent with the
> frequenty declaration of main().
> 
> > > +
> > > +	/* find auxv */
> > > +	i = 0;
> > > +	while (envp[i])
> > > +		i++;
> > > +	_auxv = (void *)(envp + i + 1);
> > 
> > Could be simplified a bit:
> > 
> > _auxv = (void *) envp;
> > while (_auxv)
> > 	_auxv++;
> >
> 
> Yeah, it is better, but needs a little change.
> 
>     _auxv = (void *) envp;
>     while (*_auxv)
> 	_auxv++;
>     _auxv++;

Good catch, thanks.

> [..]

Thomas
