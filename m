Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3177B40E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjHNIZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjHNIZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:25:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FCDC1702;
        Mon, 14 Aug 2023 01:24:40 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37E8MO1X017163;
        Mon, 14 Aug 2023 10:22:24 +0200
Date:   Mon, 14 Aug 2023 10:22:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Message-ID: <20230814082224.GA16761@1wt.eu>
References: <20230813085140.GD8237@1wt.eu>
 <20230813132620.19411-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813132620.19411-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 09:26:20PM +0800, Zhangjin Wu wrote:
> > > With above conversions, we may be able to predefine all of the
> > > sys_<NAME> functions to preserve the input types from library rountines
> > > and return types from my_syscall<N> (by default, 'long'). This also
> > > follows the suggestion from Arnd: let sys_ not use the other low level
> > > syscalls, only use its own.
> > 
> > Maybe, but I'm not sure there is much to gain here, compared to the
> > flexibility to map one to another (e.g. see sys_chmod()).
> >
> 
> But we can do the mapping in library routines too (still need to solve
> the #ifdef switch, let's talk later), and the sys_* macros will be purely a
> user-space name for the kernel-side syscall (of course, this is really
> the ideal status).

"we can", sure, but should we ?

> Sometimes, the __NR_mmap means old_map, the __NR_select means
> old_select, and the __NR_clone means different backwards, we still need
> to let architecture to select what they really want and use some macros
> like '__ARCH_WANT_SYS_OLD_SELECT' to select the right kernel mmap
> implementation.

Yes but that's already what we have. I mean, we haven't invented these
macros, they're already used in the kernel itself to indicate what
variant of a syscall an arch depends on. The __NR_ thing doesn't imply
anything, at best its absence implies the syscall doesn't exist in this
form.

> >From the sys.h side, we can assume every sys_* are just the one (with
> the same name) provided by kernel side.
> 
> >From the syscall.h side (**this new syscall.h completely differs from
> the old one with reorg about the my_syscall<N>, it only adds a syscall()
> like macros: my_syscall() and __sysdef()**), except the one by one
> mapping:
> 
>     // sysnr.h
>     #define NOLIBC__NR_NOSYS (-1L)
>     
>     #ifndef __NR_brk
>     #define NOLIBC__NR_brk NOLIBC__NR_NOSYS
>     #else
>     #define NOLIBC__NR_brk __NR_brk
>     #endif
> 
>     ...
> 
>     #ifndef __NR_write
>     #define NOLIBC__NR_write NOLIBC__NR_NOSYS
>     #else
>     #define NOLIBC__NR_write __NR_write
>     #endif

I really don't like the idea of having to add code to redefine everything
that already exists for the purpose of removing code later. There might
be other solutions to this. If we had to go through this, at least I
would like to be sure that we only use the original __NR_xxx so that
nobody has to go through the pain of redefining them like this. Because
what's written above is work for a computer, not a human.

>     ...
>     #define sys_unlinkat(...)                  __sysdef(unlinkat, __VA_ARGS__)
>     #define sys_wait4(...)                     __sysdef(wait4, __VA_ARGS__)
>     #define sys_write(...)                     __sysdef(write, __VA_ARGS__)
> 
> We also add exceptions for the ones like old_select, old_mmap, and
> backwards of clones, here use old_map as an example:
> 
>     /* sys_* exceptions */
> 
>     /* Some architectures' mmap() is implemented as old_mmap() in kernel side,
>      * let's correct them
>      */
>     #ifdef __ARCH_WANT_SYS_OLD_MMAP
>     #undef sys_mmap

This one as well should be avoided. Undefining something already defined
is very brittle as it prevents any further code reorganization, and is
often confusing for those trying to follow the code.

>     #define sys_old_mmap(...) __sysdef(mmap, __VA_ARGS__)
>     static __attribute__((unused))
>     long sys_mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
>     {
>            struct mmap_arg_struct args = {
>                    .addr = (unsigned long)addr,
>                    .len = (unsigned long)length,
>                    .prot = prot,
>                    .flags = flags,
>                    .fd = fd,
>                    .offset = (unsigned long)offset
>            };
>            return sys_old_mmap(&args);
>     }
>     #endif

So that's the perfect example of adding unneeded obfuscation. From what
I understand it does nothing but:

    long sys_mmap(...)
    {
          struct ... args = {
          ...
          };
          return my_syscall(&args);
    }

Right ? If so better remove the unneeded #define.

> With this exception, s390 no long need to provide its own mmap
> definition, it (seems i386 too, but it uses mmap2 currently) can simply
> define '__ARCH_WANT_SYS_OLD_MMAP' as the '__ARCH_WANT_SYS_OLD_SELECT' we
> are using for old_select.
> 
> The same method applies to the selection of the different backward
> version of the sys_clone() syscall (from kernel/fork.c):
(...)

>     #ifdef __NR_clone
>     #undef sys_clone
>     #define __sys_clone(...) __sysdef(clone, __VA_ARGS__)
>     
>     static __attribute__((unused))
>     int sys_clone(unsigned long clone_flags, unsigned long newsp,
>                   int __attribute__((unused)) stack_size,
>                   int parent_tidptr, int child_tidptr, unsigned long tls)
>     {
>             long ret;
>     #ifdef __ARCH_WANT_SYS_CLONE_BACKWARDS
>             ret = __sys_clone(clone_flags, newsp, parent_tidptr, tls, child_tidptr);
>     #elif defined(__ARCH_WANT_SYS_CLONE_BACKWARDS2)
>             ret = __sys_clone(newsp, clone_flags, parent_tidptr, child_tidptr, tls);
>     #elif defined(__ARCH_WANT_SYS_CLONE_BACKWARDS3)
>             ret = __sys_clone(clone_flags, newsp, stack_size, parent_tidptr, child_tidptr, tls);
>     #else
>             ret = __sys_clone(clone_flags, newsp, parent_tidptr, child_tidptr, tls);
>     #endif
>             return ret;
>     }
>     #endif /* __NR_clone */
> 
> s390 only requires to define '__ARCH_WANT_SYS_CLONE_BACKWARDS2', no need
> to provide its own sys_fork() version, in the __NR_clone branch of
> fork(), __ARCH_WANT_SYS_CLONE_BACKWARDS2 can directly select the right
> version of sys_clone() for s390).

Maybe but with much less #define indirections it would be significantly
better.

(...)
> We only have these three exceptions currently, with this normalization,
> the library routines from sys.h can directly think sys_* macros are
> generic, if not, let syscall.h take care of the right exceptions.

I see the point. But that doesn't remove the need to write the exported
function itself. I'm not saying there's nothing to save here, I see your
point, I'm just wondering if we really gain something in terms of ease
of declaring new syscalls especially for first-time contributors and if
we're not losing in maintenance. If at least it's easy enough to implement
exceptions, maybe it could be worth further investigating.

> > >     static __attribute__((unused))
> > >     int dup2(int old, int new)
> > >     {
> > > 	int ret = sys_dup3(old, new, 0);
> > > 
> > > 	if (ret == -ENOSYS)
> > > 		ret = sys_dup2(old, new);
> > > 
> > > 	return __sysret(ret);
> > >     }
> > 
> > But this will add a useless test after all such syscalls, we'd rather
> > not do that!
> >
> 
> Indeed, I found this issue too, when __NR_dup3 not defined, it returns
> -ENOSYS, than, no size issue, otherwise, the compiler will not be able
> to learn what the ret of sys_dup3() will be, so, it can not optimize the
> second call to sys_dup2().
> 
> So, the '#ifdef' logic must be used like we did in sys_* functions, but
> it is really not that meaningful (no big gain as you mentioned above) if
> we only move them from the sys_* functions to the library routines.
> 
> At last, I found the ternary operation together with the initialization
> of the not-defined __NR_* as NOLIBC__NR_NOSYS help this a lot, at last,
> we get something like this:
> 
>     /* __systry2() is used to select one of two provided low level syscalls */
>     #define __systry2(a, sys_a, sys_b) \
>     	((NOLIBC__NR_##a != NOLIBC__NR_NOSYS) ? (sys_a) : (sys_b))

But this supposes that all of them are manually defined as you did above.
I'd rather implement an ugly is_numeric() macro based on argument
resolution. I've done it once in another project, I don't remember
precisely where it is but I vaguely remember that it used to check
that the string resolution of the argument gave a letter (when it
does not exist) or a digit (when it does). I can look into that later
if needed. But please avoid extra macro definitions as much as possible,
they're a real pain to handle in the code. There's no error when one is
missing or has a typo, it's difficult to follow them and they don't
appear in the debugger.

> It can eliminate all of the '#ifdef' stuffs, using the chmod example you
> mentioned above, it becomes something like this:
> 
>     /*
>      * int chmod(const char *path, mode_t mode);
>      */
>     
>     static __attribute__((unused))
>     int chmod(const char *path, mode_t mode)
>     {
>     	return __sysret(__systry2(chmod, sys_chmod(path, mode), sys_fchmodat(AT_FDCWD, path, mode, 0)));
>     }
> 
> Purely clean and clear.

That's a matter of taste and it may explain why we often disagree. For me
it's horrid. If I'm the one implementing chmod for my platform and it does
not work, what should I do when facing that, except want to cry ? Think
that right now we have this:

  static __attribute__((unused))
  int sys_chmod(const char *path, mode_t mode)
  {
  #ifdef __NR_fchmodat
          return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
  #elif defined(__NR_chmod)
          return my_syscall2(__NR_chmod, path, mode);
  #else
          return -ENOSYS;
  #endif
  }

Sure it can be called not pretty, but I think it has the merit of being
totally explicit, and whoever sees chmod() fail can quickly check based
on the test in what situation they're supposed to be and what to check.

One thing I'm worried about also regarding using my_syscall() without the
number is that it's easy to miss an argument and have random values taken
from registers (or the stack) passed as argument. For example above we can
see that the flags part is 0 in fchmodat(). It's easy to miss themn and
while the syscall4() will complain, syscall() will silently turn that
into syscall3(). That's not necessarily a big deal, but we've seen during
the development that it's easy to make mistakes and they're not trivial
to spot. So again I'm really wondering about the benefits in such a case.

This is well illustrated in your example below:

>     	return __sysret(__systry2(newselect, sys_newselect(nfds, rfds, wfds, efds, timeout),
>     					     sys_pselect6(nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL)));

How many attempts to get it right ? Just skip one NULL and you don't
see it.

>     static __attribute__((unused))
>     pid_t fork(void)
>     {
>     	return __sysret(__systry2(fork, sys_fork(), sys_clone(SIGCHLD, 0, 0, 0, 0, 0)));
>     }

I'd rather really write more explicit code.

> > > > -static __inline__ __attribute__((unused, always_inline))
> > > > -long __sysret(unsigned long ret)
> > > > -{
> > > > -	if (ret >= (unsigned long)-MAX_ERRNO) {
> > > > -		SET_ERRNO(-(long)ret);
> > > > -		return -1;
> > > > -	}
> > > > -	return ret;
> > > > -}
> > > > +#define __sysret(arg)								\
> > > > +({										\
> > > > +	__typeof__(arg) __sysret_arg = (arg);					\
> > > 
> > > Here ignores the 'const' flag in input type?
> > 
> > Yes, as explained above, there's no issue with const. The issue
> > that was met in the version I suggested in the message was that
> > there was an assignment to the variable of value -1 to be returned,
> > which is not permitted when it's const, and I said that it was not
> > necessary, it was just a convenience, but that using "?:" does the
> > job as well without having to do any assignment.
> 
> Sorry, I have mixed the 'assignment' in definition (no problem here) and
> the 'assignment' in late change (__sysret_arg = -1). The ternary
> operation here used is really a great idea ;-) 

But please do not call that an "idea", it's just one of many language
constructs, and precisely the one designed exactly for this. Use the
right tool for the job!

> > Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
> > honest, because we're there just because of the temptation to remove
> > lines that were not causing any difficulties :-/
> >
> > I think we can do something in-between and deal only with signed returns,
> > and explicitly place the test for MAX_ERRNO on the two unsigned ones
> > (brk and mmap). It should look approximately like this:
> > 
> >  #define __sysret(arg)                                                \
> >  ({                                                                   \
> >  	__typeof__(arg) __sysret_arg = (arg);                           \
> >  	(__sysret_arg < 0) ? ({           /* error ? */                 \
> >  		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
> >  		((__typeof__(arg)) -1);   /*      return -1 */          \
> >  	}) : __sysret_arg;                /* return original value */   \
> >  })
> >
> 
> I like this one very much, a simple test shows, it saves one more byte.

I'm going to do that and revert the 3 affected syscalls.

> Only a quesiton, why 'errno != -ret' has a '!'? and we have post-tab in
> above two lines of __sysret() too, I have changed them to whitespaces.

Just because I'm not good at writing illustrative code directly in e-mail,
which was warned against via "approximately like this". I do not even
expect it to compile since I'm not sure it has the right number of braces
and parenthesis but indent gives the idea.

> For the brk and mmap part, it is ok to restore them as before, and it
> also works with the new patchset we proposed above, only need such
> tuning:
> 
>     #define sys_brk(...)                               __sysdef(brk, __VA_ARGS__)
>     #define sys_mmap(...)                              __sysdef(mmap, __VA_ARGS__)
>     #define sys_mmap2(...)                             __sysdef(mmap2, __VA_ARGS__)
> 
>     -->
> 
>     #define sys_brk(...)                       (void *)__sysdef(brk, __VA_ARGS__)
>     #define sys_mmap(...)                      (void *)__sysdef(mmap, __VA_ARGS__)
>     #define sys_mmap2(...)                     (void *)__sysdef(mmap2, __VA_ARGS__)

I don't care what it implies for now. We're talking about fixing some
breakage, you'll have plenty of time later to see how to adapt your
future proposals to what is committed. We DO NOT adapt fixes to what's
expected to come later.

> But let them align with the others may be better, so, most of the sys_*
> macros can be simply mapped with a simple line (all of them are
> generated automatically), without the care of the return types changing.
> 
> So, Willy, as a summary:
> 
> - one solution is your new __sysret() + restore the original SET_ERRNO
>   for mmap and brk [1].
> 
> - another solution is your new __sysret() + my patch [2] to let mmap and brk
>   return 'long' as the other sys_* function does.

No, because it will completely break them when they'll need to access the
second half of the memory, as I already explained somewhere else in one
of these numerous discussions. 

> Both of them are ok for me, but If we can apply the second one, the
> proposed patchset above may be cleaner. The patch [2] is really a
> prepare patch for the above proposed patchset, that is why I send it
> before that patchset.
> 
> It is time to finish the size inflate regression issue, after you apply
> any of the above solutions,

I'll do, because this has lasted far too long and gone way too far for
what was supposed to be a trivial fix.


> I will resell my proposed patchset above, at
> least a RFC patchset, please ignore this currently ;-) 

Please allow me to breathe a little bit. Really I mean, I'm already worn
by having to constantly review breaking changes that either introduce
bugs or break maintainability, and to have to justify myself for things
that I thought would be obvious to anyone. Massive changes are extremely
time consuming to review, and trying to figure subtle breakage in such
low-level stuff is even harder. I simply can't assign more time to this,
particularly for the expected gains which for me or often perceived as
losses of maintainability instead :-/

Thanks,
Willy
