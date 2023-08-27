Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9440789C22
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjH0IdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjH0Icx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 04:32:53 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB11C121;
        Sun, 27 Aug 2023 01:32:48 -0700 (PDT)
X-QQ-mid: bizesmtp75t1693125151t58h728m
Received: from linux-lab-host.localdomain ( [116.30.127.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Aug 2023 16:32:30 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: k0mQ4ihyJQPOdSn7dTAaVLBa7NqkFcrJ34wVkvTNsdtNa88dEEAJ2cwCQF/hC
        SiRr0vUWgzEAc1+oOUlteiVH2abPI6prbg6lFUGGzvLl/6In7zMRBuRk7NEQ2lxGJ0Y2QeG
        F71lMpy8ZqUQoLdDnXpvpjbZ8WpZ48zsp2Wpk39KKR4RHlLllEqYV9Vgi5t4tTwdXpp48Ff
        HQatNTyBrHeileClzp9zdOvq++4GU5sYRh+cLaRruTXa+62BZ4A3Hal2RXmMuA10dZXvYvU
        +VVFnkQcO3Pg1HV0W32C1cpRN0PBOJTF9BRuQ0swgoPG1DOmcPsmP6lBoxjq+7mjl4Kf/Jh
        BO1NKR0qRwkgyqsuNBvG4oMpVly9T2Gj6Bs2wgYev8VvKiwek+nShd46MR8WBW+oB+1qSZU
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11048618283240064082
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de, tanyuan@tinylab.org
Subject: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single -ENOSYS return
Date:   Sun, 27 Aug 2023 16:32:25 +0800
Message-Id: <20230827083225.7534-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Since we have already finished the size inflate regression task [1], to share
and discuss the progress about the -ENOSYS return work, here launchs a new
thread, it is split from [2].

[1]: https://lore.kernel.org/lkml/ZNtszQeigYuItaKA@1wt.eu/
[2]: https://lore.kernel.org/lkml/20230814172233.225944-1-falcon@tinylab.org/#R

This is only for brain storming, it is far from a solution ;-)

> 
> > [...]
> > > > 
> > > >     /* __systry2() is used to select one of two provided low level syscalls */
> > > >     #define __systry2(a, sys_a, sys_b) \
> > > >     	((NOLIBC__NR_##a != NOLIBC__NR_NOSYS) ? (sys_a) : (sys_b))
> > > 
> > > But this supposes that all of them are manually defined as you did above.
> > > I'd rather implement an ugly is_numeric() macro based on argument
> > > resolution. I've done it once in another project, I don't remember
> > > precisely where it is but I vaguely remember that it used to check
> > > that the string resolution of the argument gave a letter (when it
> > > does not exist) or a digit (when it does). I can look into that later
> > > if needed. But please avoid extra macro definitions as much as possible,
> > > they're a real pain to handle in the code. There's no error when one is
> > > missing or has a typo, it's difficult to follow them and they don't
> > > appear in the debugger.
> > >
> > 
> > Yeah, your reply inspired me to look into the IS_ENABLED() from
> > ../include/linux/kconfig.h macro again, there was a __is_defined() there, let's
> > throw away the ugly sysnr.h. I thought of IS_ENABLED() was only for y/n/m
> > before, but it does return 0 when the macro is not defined, it uses the same
> > trick in syscall() to calculate the number of arguments, if the macro is not
> > defined, then, 0 "argument".
> >
> 
> The above trick is only for ""#define something 1" ;-)
>

Here shares a little progress on this, I have found it is easy to implement an
ugly is_numeric() like macro as following:

    /* Imported from include/linux/stringify.h */
    #define __stringify_1(x...)     #x
    #define __stringify(x...)       __stringify_1(x)

    /*
     * Check __NR_* definition by stringizing
     *
     * - The stringizing is to silence compile error about undefined macro
     * - If defined, the result looks like "3", "(4000 + 168)", not begin with '_'
     * - If not defined, the result looks like "__NR_read", begins with '_'
     */

    #define __is_nr_defined(nr)     ___is_nr_defined(__stringify(nr))
    #define ___is_nr_defined(str)   (str[0] != '_')

__is_nr_defined() is able to check if __NR_xxx is defined, but the harder part
is getting the number of defined __NR_* without the error about undefined
macro.

Of course, we can also use the __stringify() trick to do so, but it is
expensive (bigger size, worse performance) to unstringify and get the number
again, the expensive atoi() 'works' for the numeric __NR_*, but not work for
(__NR_*_base + offset) like __NR_* definitions (used by ARM and MIPS), a simple
interpreter is required for such cases and it is more expensive than atoi().

    /* not for ARM and MIPS */

    static int atoi(const char *s);
    #define __get_nr(name)          __nr_atoi(__stringify(__NR_##name))
    #define __nr_atoi(str)          (str[0] == '_' ? -1L : ___nr_atoi(str))
    #define ___nr_atoi(str)         (str[0] == '(' ? -1L : atoi(str))

Welcome more discussion or let's simply throw away this direction ;-)

But it may really help us to drop tons of duplicated code pieces like this:

    #ifdef __NR_xxxx
    ...
    #else
        return -ENOSYS;
    #endif

David, Thomas and Arnd, any inspiration on this, or is this really impossible
(or make things worse) in language level? ;-)

What I'm thinking about is something like this or similar (As Willy commented
before, the __sysdef() itself is not that good, please ignore itself, the core
target here is using a single -ENOSYS return for all of the undefined
branches):

    #define __sysdef(name, ...)     \
    	(__is_nr_defined(__NR_##name) ? my_syscall(__get_nr(name), ##__VA_ARGS__) : (long)-ENOSYS)

Or as Arnd replied in an old email thread before, perhaps the whole #ifdef's
code piece (and even the input types and return types of sys_*) above can be
generated from .tbl or the generic unistd.h automatically in the sysroot
installation stage?

BR,
Zhangjin
