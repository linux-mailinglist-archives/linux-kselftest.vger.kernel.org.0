Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715E74D9D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGJPYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGJPYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 11:24:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A0E0;
        Mon, 10 Jul 2023 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689002652; bh=gF6Cgjfm2RT/MVzn+Sfn38XhDQPM8dJ2IqE7l+3UyAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvJqikWWAeGiVgaKzmOJfTh9Q97CaqnMQuvhNg8IvqaNg1axxezRT8c6XcItgAzw4
         np/HIczAKRkJdo63g1HjovIcUNjBxpN4UlE7bboYMkWdeoAuThkTCJs90Zj4NGSw+4
         Cn7M7GueCiwf+USYIoDki6WuOq5Fzcfrba3YNxmc=
Date:   Mon, 10 Jul 2023 17:24:11 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 04/12] tools/nolibc: crt.h: add _start_c
Message-ID: <195a189b-b9d5-45a1-8901-c9bdb52da2f3@t-8ch.de>
References: <4e23cc1c-2fe0-413e-9fe1-a9428c0861b9@t-8ch.de>
 <20230710092643.19310-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710092643.19310-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-10 17:26:43+0800, Zhangjin Wu wrote:
> > On 2023-07-08 23:29:58+0800, Zhangjin Wu wrote:
> > > As the environ and _auxv support added for nolibc, the assembly _start
> > > function becomes more and more complex and therefore makes the porting
> > > of nolibc to new architectures harder and harder.
> > > 
> > > To simplify portability, this c version of _start_c() is added to do
> > > most of the assembly start operations in C, which reduces the complexity
> > > a lot and will eventually simplify the porting of nolibc to the new
> > > architectures.
> > > 
> > > The new _start_c() only requires a stack pointer argument, it will find
> > > argv, envp and _auxv for us, and then call main(), finally, it exit()
> > > with main's return status. With this new _start_c(), the future new
> > > architectures only require to add very few assembly instructions.
> > 
> > I like it!
> > 
> > A quick test indicates that the initialization of the stackprotectors
> > could also be moved into the C function.
> >
> 
> Cool, do you mean directly call __stack_chk_init() at the beginning of
> _start_c()?

Yes, exactly.

> > It also seems like a good opportunity to add some tests for
> > argv/environment variable passing.
> 
> Yes, and even further, we can do more on auxv, just like musl does in
> src/env/__libc_start_main.c, not that urgent currently:

With tests I mean nolibc-test.c to make sure we don't introduce any
regressions.
Only some tiny testcases to validate that argv and environ are picked
up correctly by the startup code on all arches.

> 
>     libc.auxv = auxv = (void *)(envp+i+1);
>     ...
>     __hwcap = aux[AT_HWCAP];
>     if (aux[AT_SYSINFO]) __sysinfo = aux[AT_SYSINFO];
>     ...
>     libc.page_size = aux[AT_PAGESZ];
> 
>     if (!pn) pn = (void*)aux[AT_EXECFN];
>     if (!pn) pn = "";
>     __progname = __progname_full = pn;
>     for (i=0; pn[i]; i++) if (pn[i]=='/') __progname = pn+i+1;
> 
>     __init_tls(aux);
>     __init_ssp((void *)aux[AT_RANDOM]);
> 
>     if (aux[AT_UID]==aux[AT_EUID] && aux[AT_GID]==aux[AT_EGID]
>             && !aux[AT_SECURE]) return;
> 
>     ...
>     libc.secure = 1;
> 
> > 
> > And as general note to the full series I think that splitting the arch
> > files is not necessary and confusing.
> >
> 
> Ok, welcome to discuss more in this thread:
> 
>     https://lore.kernel.org/lkml/20230710072340.10798-1-falcon@tinylab.org/
> 
> and let's choose a better method as possible as we can, Just replied Willy to
> explain more.

Will do.

> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/include/nolibc/crt.h | 44 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > > index 221b7c5346ca..b269294e9664 100644
> > > --- a/tools/include/nolibc/crt.h
> > > +++ b/tools/include/nolibc/crt.h
> > > @@ -13,4 +13,48 @@
> > >  char **environ __attribute__((weak));
> > 
> > The old code seems to avoid putting "environ" into the global symbol
> > namespace. Could this declaration be moved into the function like in
> > getenv()?
> >
> 
> ok, do you mean just move it to stdlib.h like this? I moved _auxv (used
> by getauxv()) to stdlib.h too:

Nevermind, I got confused by the in-function declaration of
"extern char **environ" inside "getenv()".
Actually this in-function declaration doesn't do anything and can be
dropped.

> 
>         tools/nolibc: move environ and _auxv from crt.h to stdlib.h
>         
>         Move the definitions of environ and _auxv from crt.h to stdlib.h, where
>         the place who uses those definitions.
>         
>         - getenv uses environ
>         - getauxv uses _auxcv
>         
>         Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
>     
>     diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
>     index b269294e9664..d2f84cbe73d0 100644
>     --- a/tools/include/nolibc/crt.h
>     +++ b/tools/include/nolibc/crt.h
>     @@ -10,14 +10,13 @@
>      #include "compiler.h"
>      #include "crt_arch.h"
>      
>     -char **environ __attribute__((weak));
>     -const unsigned long *_auxv __attribute__((weak));
>     -
>      int main(int argc, char *argv[], char **envp);
>      static void exit(int);
>      
>      void _start_c(long *sp)
>      {
>     +       extern char **environ;
>     +       extern const unsigned long *_auxv;
>             int argc, i;
>             char **argv;
>             char **envp;
>     diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
>     index 2f9b4b3c6d26..5eadadc2d0f5 100644
>     --- a/tools/include/nolibc/stdlib.h
>     +++ b/tools/include/nolibc/stdlib.h
>     @@ -14,6 +14,9 @@
>      #include "string.h"
>      #include <linux/auxvec.h>
>      
>     +char **environ __attribute__((weak));
>     +const unsigned long *_auxv __attribute__((weak));
>     +
>      struct nolibc_heap {
>             size_t  len;
>             char    user_p[] __attribute__((__aligned__));
> 
> > >  const unsigned long *_auxv __attribute__((weak));
> > >  
> > > +int main(int argc, char *argv[], char **envp);
> > 
> > This will lead to conflicting declarations if the users use a different
> > signature. I'm not (yet?) sure how to work around this.
> >
> 
> Ah yes, I forgot this critical case, people may use something like:
> 
>     int main(void)
>     int main(int argc, char *argv[])

> [..]

I thought about this general problem and it turns out that there is
nothing that any libc can do to distinguish these special cases.
So it has to be handled in the compiler and we do not have to care.

Thomas
