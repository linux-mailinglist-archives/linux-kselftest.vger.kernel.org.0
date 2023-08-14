Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA077B6FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 12:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjHNKnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjHNKms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 06:42:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1A10E5;
        Mon, 14 Aug 2023 03:42:45 -0700 (PDT)
X-QQ-mid: bizesmtp82t1692009749t6dd27s6
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 14 Aug 2023 18:42:28 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: +ynUkgUhZJknQdj8DNcL8wEKEtNPTYnb07ez8yhdA/ljS+eSnoGafWyzB0ous
        sbjfQXJjkmG33nL9S4Xdcj6T0ZCDxgsVxNR8nDwSTZWsPROEaNw1ziRaRMLf8DuOKZOMH9N
        WwsUakGydtVhfo8gS+F04I/4T3j2mEGlosJ3KoXUy9sTZFOpZ78Mt4VjJuNxxI0eOD5xndt
        s87l5U8plLodJ5Je4YM+credxGkai6iwLkMfWWMzZKTRE5Iw/V51jT/9gpdH3fpLeBiTr3m
        da3luEvPFx84dZtv7KFqSld7UFA+RoIh6a7EBcwu1CEdF2hUp3S2QC5cNq/OIIYOUZoYUIf
        y3/oab7dmlXvvbOGC9FnjkBeHe/96+xlep/oO6k+GMt9D86/EE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17076142804648514617
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Date:   Mon, 14 Aug 2023 18:42:26 +0800
Message-Id: <20230814104226.7094-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814082224.GA16761@1wt.eu>
References: <20230814082224.GA16761@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sun, Aug 13, 2023 at 09:26:20PM +0800, Zhangjin Wu wrote:
> [...]
> > With this exception, s390 no long need to provide its own mmap
> > definition, it (seems i386 too, but it uses mmap2 currently) can simply
> > define '__ARCH_WANT_SYS_OLD_MMAP' as the '__ARCH_WANT_SYS_OLD_SELECT' we
> > are using for old_select.
> > 
> > The same method applies to the selection of the different backward
> > version of the sys_clone() syscall (from kernel/fork.c):
> (...)
> 
> >     #ifdef __NR_clone
> >     #undef sys_clone
> >     #define __sys_clone(...) __sysdef(clone, __VA_ARGS__)
> >     
> >     static __attribute__((unused))
> >     int sys_clone(unsigned long clone_flags, unsigned long newsp,
> >                   int __attribute__((unused)) stack_size,
> >                   int parent_tidptr, int child_tidptr, unsigned long tls)
> >     {
> >             long ret;
> >     #ifdef __ARCH_WANT_SYS_CLONE_BACKWARDS
> >             ret = __sys_clone(clone_flags, newsp, parent_tidptr, tls, child_tidptr);
> >     #elif defined(__ARCH_WANT_SYS_CLONE_BACKWARDS2)
> >             ret = __sys_clone(newsp, clone_flags, parent_tidptr, child_tidptr, tls);
> >     #elif defined(__ARCH_WANT_SYS_CLONE_BACKWARDS3)
> >             ret = __sys_clone(clone_flags, newsp, stack_size, parent_tidptr, child_tidptr, tls);
> >     #else
> >             ret = __sys_clone(clone_flags, newsp, parent_tidptr, child_tidptr, tls);
> >     #endif
> >             return ret;
> >     }
> >     #endif /* __NR_clone */
> > 
> > s390 only requires to define '__ARCH_WANT_SYS_CLONE_BACKWARDS2', no need
> > to provide its own sys_fork() version, in the __NR_clone branch of
> > fork(), __ARCH_WANT_SYS_CLONE_BACKWARDS2 can directly select the right
> > version of sys_clone() for s390).
> 
> Maybe but with much less #define indirections it would be significantly
> better.
> 
> (...)
> > We only have these three exceptions currently, with this normalization,
> > the library routines from sys.h can directly think sys_* macros are
> > generic, if not, let syscall.h take care of the right exceptions.
> 
> I see the point. But that doesn't remove the need to write the exported
> function itself. I'm not saying there's nothing to save here, I see your
> point, I'm just wondering if we really gain something in terms of ease
> of declaring new syscalls especially for first-time contributors and if
> we're not losing in maintenance. If at least it's easy enough to implement
> exceptions, maybe it could be worth further investigating.
>

I will delay the whole work about __sysdef(), but work on some more generic
parts (like the exceptions above) at first.

> > > >     static __attribute__((unused))
> > > >     int dup2(int old, int new)
> > > >     {
> > > > 	int ret = sys_dup3(old, new, 0);
> > > > 
> > > > 	if (ret == -ENOSYS)
> > > > 		ret = sys_dup2(old, new);
> > > > 
> > > > 	return __sysret(ret);
> > > >     }
> > > 
> > > But this will add a useless test after all such syscalls, we'd rather
> > > not do that!
> > >
> > 
> > Indeed, I found this issue too, when __NR_dup3 not defined, it returns
> > -ENOSYS, than, no size issue, otherwise, the compiler will not be able
> > to learn what the ret of sys_dup3() will be, so, it can not optimize the
> > second call to sys_dup2().
> > 
> > So, the '#ifdef' logic must be used like we did in sys_* functions, but
> > it is really not that meaningful (no big gain as you mentioned above) if
> > we only move them from the sys_* functions to the library routines.
> > 
> > At last, I found the ternary operation together with the initialization
> > of the not-defined __NR_* as NOLIBC__NR_NOSYS help this a lot, at last,
> > we get something like this:
> > 
> >     /* __systry2() is used to select one of two provided low level syscalls */
> >     #define __systry2(a, sys_a, sys_b) \
> >     	((NOLIBC__NR_##a != NOLIBC__NR_NOSYS) ? (sys_a) : (sys_b))
> 
> But this supposes that all of them are manually defined as you did above.
> I'd rather implement an ugly is_numeric() macro based on argument
> resolution. I've done it once in another project, I don't remember
> precisely where it is but I vaguely remember that it used to check
> that the string resolution of the argument gave a letter (when it
> does not exist) or a digit (when it does). I can look into that later
> if needed. But please avoid extra macro definitions as much as possible,
> they're a real pain to handle in the code. There's no error when one is
> missing or has a typo, it's difficult to follow them and they don't
> appear in the debugger.
>

Yeah, your reply inspired me to look into the IS_ENABLED() from
../include/linux/kconfig.h macro again, there was a __is_defined() there, let's
throw away the ugly sysnr.h. I thought of IS_ENABLED() was only for y/n/m
before, but it does return 0 when the macro is not defined, it uses the same
trick in syscall() to calculate the number of arguments, if the macro is not
defined, then, 0 "argument".

> > It can eliminate all of the '#ifdef' stuffs, using the chmod example you
> > mentioned above, it becomes something like this:
> > 
> >     /*
> >      * int chmod(const char *path, mode_t mode);
> >      */
> >     
> >     static __attribute__((unused))
> >     int chmod(const char *path, mode_t mode)
> >     {
> >     	return __sysret(__systry2(chmod, sys_chmod(path, mode), sys_fchmodat(AT_FDCWD, path, mode, 0)));
> >     }
> > 
> > Purely clean and clear.
> 
> That's a matter of taste and it may explain why we often disagree. For me
> it's horrid. If I'm the one implementing chmod for my platform and it does
> not work, what should I do when facing that, except want to cry ? Think
> that right now we have this:
> 
>   static __attribute__((unused))
>   int sys_chmod(const char *path, mode_t mode)
>   {
>   #ifdef __NR_fchmodat
>           return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
>   #elif defined(__NR_chmod)
>           return my_syscall2(__NR_chmod, path, mode);
>   #else
>           return -ENOSYS;
>   #endif
>   }
> 
> Sure it can be called not pretty, but I think it has the merit of being
> totally explicit, and whoever sees chmod() fail can quickly check based
> on the test in what situation they're supposed to be and what to check.
> 
> One thing I'm worried about also regarding using my_syscall() without the
> number is that it's easy to miss an argument and have random values taken
> from registers (or the stack) passed as argument. For example above we can
> see that the flags part is 0 in fchmodat(). It's easy to miss themn and
> while the syscall4() will complain, syscall() will silently turn that
> into syscall3(). That's not necessarily a big deal, but we've seen during
> the development that it's easy to make mistakes and they're not trivial
> to spot. So again I'm really wondering about the benefits in such a case.
> 
> This is well illustrated in your example below:
> 
> >     	return __sysret(__systry2(newselect, sys_newselect(nfds, rfds, wfds, efds, timeout),
> >     					     sys_pselect6(nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL)));
> 
> How many attempts to get it right ? Just skip one NULL and you don't
> see it.

Yeah, seems we have missed the last 0 in ppoll() before and the test may not
report about it either.

[...]
> > > Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
> > > honest, because we're there just because of the temptation to remove
> > > lines that were not causing any difficulties :-/
> > >
> > > I think we can do something in-between and deal only with signed returns,
> > > and explicitly place the test for MAX_ERRNO on the two unsigned ones
> > > (brk and mmap). It should look approximately like this:
> > > 
> > >  #define __sysret(arg)                                                \
> > >  ({                                                                   \
> > >  	__typeof__(arg) __sysret_arg = (arg);                           \
> > >  	(__sysret_arg < 0) ? ({           /* error ? */                 \
> > >  		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
> > >  		((__typeof__(arg)) -1);   /*      return -1 */          \
> > >  	}) : __sysret_arg;                /* return original value */   \
> > >  })
> > >
> > 
> > I like this one very much, a simple test shows, it saves one more byte.
> 
> I'm going to do that and revert the 3 affected syscalls.
>

Ok.
 
> > Only a quesiton, why 'errno != -ret' has a '!'? and we have post-tab in
> > above two lines of __sysret() too, I have changed them to whitespaces.
> 
[...]
> 
> > But let them align with the others may be better, so, most of the sys_*
> > macros can be simply mapped with a simple line (all of them are
> > generated automatically), without the care of the return types changing.
> > 
> > So, Willy, as a summary:
> > 
> > - one solution is your new __sysret() + restore the original SET_ERRNO
> >   for mmap and brk [1].
> > 
> > - another solution is your new __sysret() + my patch [2] to let mmap and brk
> >   return 'long' as the other sys_* function does.
> 
> No, because it will completely break them when they'll need to access the
> second half of the memory, as I already explained somewhere else in one
> of these numerous discussions. 
>

Sorry, will recheck this part later, please ignore it.

[...]
> 
> > I will resell my proposed patchset above, at
> > least a RFC patchset, please ignore this currently ;-) 
> 
> Please allow me to breathe a little bit. Really I mean, I'm already worn
> by having to constantly review breaking changes that either introduce
> bugs or break maintainability, and to have to justify myself for things
> that I thought would be obvious to anyone. Massive changes are extremely
> time consuming to review, and trying to figure subtle breakage in such
> low-level stuff is even harder. I simply can't assign more time to this,
> particularly for the expected gains which for me or often perceived as
> losses of maintainability instead :-/
>

Take a rest, I will delay the whole __sysdef() stuff and continue to work on
the last tinyconfig patchset after v6.5, it is the last one before our early
rv32 work ;-)

Thanks,
Zhangjin

> Thanks,
> Willy
