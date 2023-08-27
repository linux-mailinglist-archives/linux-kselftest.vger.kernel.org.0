Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE5789C8E
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjH0JRg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjH0JRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:17:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1DD8;
        Sun, 27 Aug 2023 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1693127840; bh=aRJKFd9sKgnazdGKOyVd+fvtS1NGVQjpl7eMhYJHOl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWhIIEAzWfF2tU6/PXNoIogAPSl1nFXssAgehfs+D1V4g+H5KD70UXFXav4eyxhcL
         8TZqS7ZvbsyK8X/BvcokWf4RnN20Llw6jOq4fTjqsKA4AKtKznZYTRJNVKk2yomxwl
         6snoWQIpWgzSsAxTqEL37DNmMcRsVMwPnw6Ni/R0=
Date:   Sun, 27 Aug 2023 11:17:19 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org
Subject: Re: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Message-ID: <1ffa33a8-dd97-480f-b8f4-2ce49c60cabb@t-8ch.de>
References: <20230827083225.7534-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827083225.7534-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

thanks for the RFC discussion!

On 2023-08-27 16:32:25+0800, Zhangjin Wu wrote:
> Since we have already finished the size inflate regression task [1], to share
> and discuss the progress about the -ENOSYS return work, here launchs a new
> thread, it is split from [2].
> 
> [1]: https://lore.kernel.org/lkml/ZNtszQeigYuItaKA@1wt.eu/
> [2]: https://lore.kernel.org/lkml/20230814172233.225944-1-falcon@tinylab.org/#R
> 
> This is only for brain storming, it is far from a solution ;-)
> 
> > 
> > > [...]
> > > > > 
> > > > >     /* __systry2() is used to select one of two provided low level syscalls */
> > > > >     #define __systry2(a, sys_a, sys_b) \
> > > > >     	((NOLIBC__NR_##a != NOLIBC__NR_NOSYS) ? (sys_a) : (sys_b))
> > > > 
> > > > But this supposes that all of them are manually defined as you did above.
> > > > I'd rather implement an ugly is_numeric() macro based on argument
> > > > resolution. I've done it once in another project, I don't remember
> > > > precisely where it is but I vaguely remember that it used to check
> > > > that the string resolution of the argument gave a letter (when it
> > > > does not exist) or a digit (when it does). I can look into that later
> > > > if needed. But please avoid extra macro definitions as much as possible,
> > > > they're a real pain to handle in the code. There's no error when one is
> > > > missing or has a typo, it's difficult to follow them and they don't
> > > > appear in the debugger.
> > > >
> > > 
> > > Yeah, your reply inspired me to look into the IS_ENABLED() from
> > > ../include/linux/kconfig.h macro again, there was a __is_defined() there, let's
> > > throw away the ugly sysnr.h. I thought of IS_ENABLED() was only for y/n/m
> > > before, but it does return 0 when the macro is not defined, it uses the same
> > > trick in syscall() to calculate the number of arguments, if the macro is not
> > > defined, then, 0 "argument".
> > >
> > 
> > The above trick is only for ""#define something 1" ;-)
> >
> 
> Here shares a little progress on this, I have found it is easy to implement an
> ugly is_numeric() like macro as following:
> 
>     /* Imported from include/linux/stringify.h */
>     #define __stringify_1(x...)     #x
>     #define __stringify(x...)       __stringify_1(x)
> 
>     /*
>      * Check __NR_* definition by stringizing
>      *
>      * - The stringizing is to silence compile error about undefined macro
>      * - If defined, the result looks like "3", "(4000 + 168)", not begin with '_'
>      * - If not defined, the result looks like "__NR_read", begins with '_'
>      */
> 
>     #define __is_nr_defined(nr)     ___is_nr_defined(__stringify(nr))
>     #define ___is_nr_defined(str)   (str[0] != '_')
> 
> __is_nr_defined() is able to check if __NR_xxx is defined, but the harder part
> is getting the number of defined __NR_* without the error about undefined
> macro.
> 
> Of course, we can also use the __stringify() trick to do so, but it is
> expensive (bigger size, worse performance) to unstringify and get the number
> again, the expensive atoi() 'works' for the numeric __NR_*, but not work for
> (__NR_*_base + offset) like __NR_* definitions (used by ARM and MIPS), a simple
> interpreter is required for such cases and it is more expensive than atoi().
> 
>     /* not for ARM and MIPS */
> 
>     static int atoi(const char *s);
>     #define __get_nr(name)          __nr_atoi(__stringify(__NR_##name))
>     #define __nr_atoi(str)          (str[0] == '_' ? -1L : ___nr_atoi(str))
>     #define ___nr_atoi(str)         (str[0] == '(' ? -1L : atoi(str))
> 
> Welcome more discussion or let's simply throw away this direction ;-)
> 
> But it may really help us to drop tons of duplicated code pieces like this:
> 
>     #ifdef __NR_xxxx
>     ...
>     #else
>         return -ENOSYS;
>     #endif
> 
> David, Thomas and Arnd, any inspiration on this, or is this really impossible
> (or make things worse) in language level? ;-)
> 
> What I'm thinking about is something like this or similar (As Willy commented
> before, the __sysdef() itself is not that good, please ignore itself, the core
> target here is using a single -ENOSYS return for all of the undefined
> branches):
> 
>     #define __sysdef(name, ...)     \
>     	(__is_nr_defined(__NR_##name) ? my_syscall(__get_nr(name), ##__VA_ARGS__) : (long)-ENOSYS)
> 
> Or as Arnd replied in an old email thread before, perhaps the whole #ifdef's
> code piece (and even the input types and return types of sys_*) above can be
> generated from .tbl or the generic unistd.h automatically in the sysroot
> installation stage?

To be honest I don't see a problem with the current aproach.
It is very obvious what is going on, the same pattern is used by other
projects and the "overhead" is very small.


It seems the macros will only work for simple cases which only test the
availability of a single syscall number.

Of these we currently only have:
gettimeofday(), lseek(), statx(), wait4()

So in it's current form we save 4 * 4 = 16 lines of code.
The proposed solution introduces 14 + 2 (empty) = 16 lines of new code,
and a bunch of mental overhead.

In case multiple underlying syscalls can be used these take different
arguments which a simple macro won't be able to encode sanely.

Thomas
