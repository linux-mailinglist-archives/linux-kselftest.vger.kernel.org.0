Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6277A682
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHMN0l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMN0k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 09:26:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9B1710;
        Sun, 13 Aug 2023 06:26:39 -0700 (PDT)
X-QQ-mid: bizesmtp70t1691933183tv80oc58
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 13 Aug 2023 21:26:21 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4nWy5OiEGymuNWb45++td0gI4cWjLryCAwk0sAdfEnJhXY32zlwt
        CjUPyfJ9Uqzl04vegwRP2gHXt+9uTe2D6uLQR39DEOv8ZatfLUC3+9Pq9/gYXepzSIJwY+U
        7ZcPW3ruP0yihnt5JCKKcdbvSMSIq+AgyZdpCkfGvTS36Vx2xetTAangPU4xntvzZJ6lLiv
        CaIp1l6NVwVFUjSWa2t1M+2AMwxbVNk4aP7bouHUsAs00YMMzvuEl2ynNxI6pnX/ULBnEgo
        PEdKLKJRMlnQquMjGjGS7SnPxvtuA52ifJRD2xfjpHqCRt+RAm8bKxYWn4n/ueFJQUvbvJe
        kkJWHBMlYgmrf2OFWkuY9FnJ7aPJIPy8uDxvWR/XICI0NU+sl1d96i8EatMDA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7404548969867590745
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Date:   Sun, 13 Aug 2023 21:26:20 +0800
Message-Id: <20230813132620.19411-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230813085140.GD8237@1wt.eu>
References: <20230813085140.GD8237@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

> On Thu, Aug 10, 2023 at 06:17:43AM +0800, Zhangjin Wu wrote:
> [...]
> 
> > > And if you remember, originally you proposed to factor the SET_ERRNO()
> > > stuff in every syscall in order to "simplify the code and improve
> > > maintainability". It's clear that we've long abandonned that goal here.
> > > If we had no other choice, I'd rather roll back to the clean, readable
> > > and trustable SET_ERRNO() in every syscall!
> > >
> > 
> > Agree, or we simply use the original version without pointer returns support
> > (only sbrk and mmap currently) but convert it to the macro version.
> 
> I indeed think that's the cleanest approach. There will hardly be more
> than 2 syscalls returning pointers or unsigned values and all this extra
> complexity added just to avoid *two* SET_ERRNO() calls is totally
> pointless.
>

Agree.

> > Or, as the idea mentioned by Thomas in a reply: if we can let the sys_
> > functions use 'long' returns, or even further, we convert all of the sys_
> > functions to macros and let them preserve input types from library routines and
> > preserve return types from the my_syscall<N> macros.
> 
> It would be annoying because the sys_* implement some fallbacks, themselves
> based on #ifdef and such stuff.

Yeah, this is an issue we must solve, let's talk about it in the 'if
(ret == -ENOSYS)' part later. 

> Macros are really a pain when they're
> repeated. They're a pain to edit, to debug, to modify and you'll see that
> editors are even not good with them, you often end up modifying more than
> you want to try to keep trailing backslashes aligned.
>

Agree very much.

> > As we discussed in my our syscall.h proposal, if there is a common
> > my_syscall(), every sys_ function can be simply defined to something
> > like:
> > 
> >     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
> > 
> > In my_syscall(), it can even simply return -ENOSYS if the __NR_xxx is
> > not defined (we init such __NR_xxx to something like __NR_NOSYS):
> > 
> >     // sysnr.h
> > 
> >     // If worried about the applications use this macro, perhaps we can
> >     // use a different prefix, for example, NOLIBC_NR_xxx
> > 
> >     #define NOLIBC_NR_NOSYS (-1L)
> > 
> >     #ifndef __NR_xxx
> >     #define NOLIBC_NR_xxx NOLIBC_NR_NOSYS
> >     #else
> >     #define NOLIBC_NR_xxx __NR_xxx
> >     #endif
> > 
> >     // syscall.h
> > 
> >     // _my_syscall is similar to syscall() in unistd.h, but without the
> >     // __sysret normalization
> > 
> >     #define _my_syscalln(N, ...) my_syscall##N(__VA_ARGS__)
> >     #define _my_syscall_n(N, ...) _my_syscalln(N, __VA_ARGS__)
> >     #define _my_syscall(...) _my_syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
> > 
> >     #define my_syscall(name, ...)                                       \
> >     ({                                                                  \
> >            long _ret;                                                   \
> >            if (NOLIBC_NR_##name == NOLIBC_NR_NOSYS)                     \
> >                    _ret = -ENOSYS;                                      \
> >            else                                                         \
> >                    _ret = _my_syscall(NOLIBC_NR_##name, ##__VA_ARGS__); \
> >            _ret;                                                        \
> >     })
> > 
> >     // sys_<NAME> list, based on unistd.h
> > 
> >     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
> >     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
> >     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
> > 
> > With above conversions, we may be able to predefine all of the
> > sys_<NAME> functions to preserve the input types from library rountines
> > and return types from my_syscall<N> (by default, 'long'). This also
> > follows the suggestion from Arnd: let sys_ not use the other low level
> > syscalls, only use its own.
> 
> Maybe, but I'm not sure there is much to gain here, compared to the
> flexibility to map one to another (e.g. see sys_chmod()).
>

But we can do the mapping in library routines too (still need to solve
the #ifdef switch, let's talk later), and the sys_* macros will be purely a
user-space name for the kernel-side syscall (of course, this is really
the ideal status).

Sometimes, the __NR_mmap means old_map, the __NR_select means
old_select, and the __NR_clone means different backwards, we still need
to let architecture to select what they really want and use some macros
like '__ARCH_WANT_SYS_OLD_SELECT' to select the right kernel mmap
implementation.

From the sys.h side, we can assume every sys_* are just the one (with
the same name) provided by kernel side.

From the syscall.h side (**this new syscall.h completely differs from
the old one with reorg about the my_syscall<N>, it only adds a syscall()
like macros: my_syscall() and __sysdef()**), except the one by one
mapping:

    // sysnr.h
    #define NOLIBC__NR_NOSYS (-1L)
    
    #ifndef __NR_brk
    #define NOLIBC__NR_brk NOLIBC__NR_NOSYS
    #else
    #define NOLIBC__NR_brk __NR_brk
    #endif

    ...

    #ifndef __NR_write
    #define NOLIBC__NR_write NOLIBC__NR_NOSYS
    #else
    #define NOLIBC__NR_write __NR_write
    #endif

    // syscall.h

    #define _my_syscall(N, ...) my_syscall##N(__VA_ARGS__)
    #define _my_syscall_n(N, ...) _my_syscall(N, __VA_ARGS__)
    #define my_syscall(...) _my_syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
    
    /* syscall() is used from application with normalized error and return value */
    #define syscall(...) __sysret(my_syscall(__VA_ARGS__))
    
    /* __sysdef() is used to define sys_* macros with original return value */
    #define __sysdef(name, ...) \
    	((NOLIBC__NR_##name == NOLIBC__NR_NOSYS) ? (long)-ENOSYS : my_syscall(NOLIBC__NR_##name, ##__VA_ARGS__))

    /* sys_* macros */

    #define sys_brk(...)                       __sysdef(brk, __VA_ARGS__)
    #define sys_chdir(...)                     __sysdef(chdir, __VA_ARGS__)
    #define sys_chmod(...)                     __sysdef(chmod, __VA_ARGS__)
    #define sys_chown(...)                     __sysdef(chown, __VA_ARGS__)
    #define sys_chroot(...)                    __sysdef(chroot, __VA_ARGS__)
    #define sys_clone(...)                     __sysdef(clone, __VA_ARGS__)
    #define sys_close(...)                     __sysdef(close, __VA_ARGS__)
    #define sys_dup(...)                       __sysdef(dup, __VA_ARGS__)
    #define sys_dup2(...)                      __sysdef(dup2, __VA_ARGS__)
    #define sys_dup3(...)                      __sysdef(dup3, __VA_ARGS__)
    #define sys_execve(...)                    __sysdef(execve, __VA_ARGS__)
    ...
    #define sys_unlinkat(...)                  __sysdef(unlinkat, __VA_ARGS__)
    #define sys_wait4(...)                     __sysdef(wait4, __VA_ARGS__)
    #define sys_write(...)                     __sysdef(write, __VA_ARGS__)

We also add exceptions for the ones like old_select, old_mmap, and
backwards of clones, here use old_map as an example:

    /* sys_* exceptions */

    /* Some architectures' mmap() is implemented as old_mmap() in kernel side,
     * let's correct them
     */
    #ifdef __ARCH_WANT_SYS_OLD_MMAP
    #undef sys_mmap
    #define sys_old_mmap(...) __sysdef(mmap, __VA_ARGS__)
    static __attribute__((unused))
    long sys_mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
    {
           struct mmap_arg_struct args = {
                   .addr = (unsigned long)addr,
                   .len = (unsigned long)length,
                   .prot = prot,
                   .flags = flags,
                   .fd = fd,
                   .offset = (unsigned long)offset
           };
           return sys_old_mmap(&args);
    }
    #endif

With this exception, s390 no long need to provide its own mmap
definition, it (seems i386 too, but it uses mmap2 currently) can simply
define '__ARCH_WANT_SYS_OLD_MMAP' as the '__ARCH_WANT_SYS_OLD_SELECT' we
are using for old_select.

The same method applies to the selection of the different backward
version of the sys_clone() syscall (from kernel/fork.c):

    /*
     * Note: Different archs have a different API of the clone() syscall, let's
     * normalize sys_clone() for all of them and allow select a backward version by
     * architecture.
     */

    #ifdef __NR_clone
    #undef sys_clone
    #define __sys_clone(...) __sysdef(clone, __VA_ARGS__)
    
    static __attribute__((unused))
    int sys_clone(unsigned long clone_flags, unsigned long newsp,
                  int __attribute__((unused)) stack_size,
                  int parent_tidptr, int child_tidptr, unsigned long tls)
    {
            long ret;
    #ifdef __ARCH_WANT_SYS_CLONE_BACKWARDS
            ret = __sys_clone(clone_flags, newsp, parent_tidptr, tls, child_tidptr);
    #elif defined(__ARCH_WANT_SYS_CLONE_BACKWARDS2)
            ret = __sys_clone(newsp, clone_flags, parent_tidptr, child_tidptr, tls);
    #elif defined(__ARCH_WANT_SYS_CLONE_BACKWARDS3)
            ret = __sys_clone(clone_flags, newsp, stack_size, parent_tidptr, child_tidptr, tls);
    #else
            ret = __sys_clone(clone_flags, newsp, parent_tidptr, child_tidptr, tls);
    #endif
            return ret;
    }
    #endif /* __NR_clone */

s390 only requires to define '__ARCH_WANT_SYS_CLONE_BACKWARDS2', no need
to provide its own sys_fork() version, in the __NR_clone branch of
fork(), __ARCH_WANT_SYS_CLONE_BACKWARDS2 can directly select the right
version of sys_clone() for s390).

The one for old_select/select is more simple:

    /*
     * For historic reasons, the select() syscall on arm, powerpc and i386 is
     * old_select in kernel side, they all provide _newselect() syscall as the new
     * version (arm and powerpc from v2.6.27, i386 from v2.6.28) like the select()
     * syscall on the other architectures.
     *
     * To align with them, here defines a new NOLIBC__NR_newselect and map it to
     * __NR__newselect or __NR_select accordingly.
     *
     * Note, since the oldest stable branch is v4.14, it is fair to no long support
     * the versions older than v2.6.27.
     */

    #ifndef NOLIBC__NR_newselect
    #ifndef __NR__newselect
    #ifndef __NR_select
    #define NOLIBC__NR_newselect NOLIBC__NR_NOSYS
    #else  /* __NR_select */
    #define NOLIBC__NR_newselect __NR_select
    #endif
    #else  /* __NR__newselect */
    #define NOLIBC__NR_newselect __NR__newselect
    #endif /* __NR__newselect */
    #endif /* ! NOLIBC__NR_newselect */
    
    /*
     * sys_newselect is not used by any architecture currently, use it as the new
     * version of select, it is mapped to sys__newselect or sys_select by the above
     * definition of NOLIBC__NR_newselect
     */
    #define sys_newselect(...) __sysdef(newselect, __VA_ARGS__)

We only have these three exceptions currently, with this normalization,
the library routines from sys.h can directly think sys_* macros are
generic, if not, let syscall.h take care of the right exceptions.

> > This may also help us to remove all of the `#ifdef __NR_` wrappers, we
> > can directly check the -ENOSYS in the library routines and try another
> > sys_<NAME> if required, at last, call __sysret() to normalize the errors
> > and return value.
> > 
> > Use dup2 and dup3 as examples, with sysnr.h and syscall.h above, sys.h
> > will work like this, without any #ifdef's:
> > 
> >     /*
> >      * int dup2(int old, int new);
> >      */
> >    
> >     static __attribute__((unused))
> >     int dup2(int old, int new)
> >     {
> > 	int ret = sys_dup3(old, new, 0);
> > 
> > 	if (ret == -ENOSYS)
> > 		ret = sys_dup2(old, new);
> > 
> > 	return __sysret(ret);
> >     }
> 
> But this will add a useless test after all such syscalls, we'd rather
> not do that!
>

Indeed, I found this issue too, when __NR_dup3 not defined, it returns
-ENOSYS, than, no size issue, otherwise, the compiler will not be able
to learn what the ret of sys_dup3() will be, so, it can not optimize the
second call to sys_dup2().

So, the '#ifdef' logic must be used like we did in sys_* functions, but
it is really not that meaningful (no big gain as you mentioned above) if
we only move them from the sys_* functions to the library routines.

At last, I found the ternary operation together with the initialization
of the not-defined __NR_* as NOLIBC__NR_NOSYS help this a lot, at last,
we get something like this:

    /* __systry2() is used to select one of two provided low level syscalls */
    #define __systry2(a, sys_a, sys_b) \
    	((NOLIBC__NR_##a != NOLIBC__NR_NOSYS) ? (sys_a) : (sys_b))

It can eliminate all of the '#ifdef' stuffs, using the chmod example you
mentioned above, it becomes something like this:

    /*
     * int chmod(const char *path, mode_t mode);
     */
    
    static __attribute__((unused))
    int chmod(const char *path, mode_t mode)
    {
    	return __sysret(__systry2(chmod, sys_chmod(path, mode), sys_fchmodat(AT_FDCWD, path, mode, 0)));
    }

Purely clean and clear.

Even with the complex select, mmap and fork library routines, we get the same
result (we have moved the __ARCH_WANT_SYS_* to syscall.h to normalize sys_*
there):

    /*
     * int select(int nfds, fd_set *read_fds, fd_set *write_fds,
     *            fd_set *except_fds, struct timeval *timeout);
     */
    
    static __attribute__((unused))
    int select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
    {
    	struct timespec t;
    
    	if (timeout) {
    		t.tv_sec  = timeout->tv_sec;
    		t.tv_nsec = timeout->tv_usec * 1000;
    	}
    
    	return __sysret(__systry2(newselect, sys_newselect(nfds, rfds, wfds, efds, timeout),
    					     sys_pselect6(nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL)));
    }

    /*
     * void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
     * int munmap(void *addr, size_t length);
     */
    
    /* Note that on Linux, MAP_FAILED is -1 so we can use the generic __sysret()
     * which returns -1 upon error and still satisfy user land that checks for
     * MAP_FAILED.
     */
    
    static __attribute__((unused))
    void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
    {
    	return (void *)__sysret(__systry2(mmap2, sys_mmap2(addr, length, prot, flags, fd, offset >> 12),
    						 sys_mmap(addr, length, prot, flags, fd, offset)));
    }

    /*
     * pid_t fork(void);
     */
    
    static __attribute__((unused))
    pid_t fork(void)
    {
    	return __sysret(__systry2(fork, sys_fork(), sys_clone(SIGCHLD, 0, 0, 0, 0, 0)));
    }
    
Currently, except the select() library routine has used 3 sys_* before,
the other library routines have only used 2 sys_*, so, __systry2() is
enough to select one of two. If we really want to use the third one,
based on __systry2(), it is very easy to add __systry3() and even
__systry4():

    #define __systry3(a, b, sys_a, sys_b, sys_c) \
            __systry2(a, (sys_a), __systry2(b, (sys_b), (sys_c)))
    
    #define __systry4(a, b, c, sys_a, sys_b, sys_c, sys_d) \
            __systry3(a, b, (sys_a), (sys_b), __systry2(c, (sys_c), (sys_d)))

Perhaps the coming time64 ones may need __systry3(), not tested yet.

> > > -static __inline__ __attribute__((unused, always_inline))
> > > -long __sysret(unsigned long ret)
> > > -{
> > > -	if (ret >= (unsigned long)-MAX_ERRNO) {
> > > -		SET_ERRNO(-(long)ret);
> > > -		return -1;
> > > -	}
> > > -	return ret;
> > > -}
> > > +#define __sysret(arg)								\
> > > +({										\
> > > +	__typeof__(arg) __sysret_arg = (arg);					\
> > 
> > Here ignores the 'const' flag in input type?
> 
> Yes, as explained above, there's no issue with const. The issue
> that was met in the version I suggested in the message was that
> there was an assignment to the variable of value -1 to be returned,
> which is not permitted when it's const, and I said that it was not
> necessary, it was just a convenience, but that using "?:" does the
> job as well without having to do any assignment.

Sorry, I have mixed the 'assignment' in definition (no problem here) and
the 'assignment' in late change (__sysret_arg = -1). The ternary
operation here used is really a great idea ;-) 

> 
> > > +	((((__typeof__(arg)) -1) > (__typeof__(arg)) 1) ?   /* unsigned arg? */	\
> > > +	 (uintptr_t)__sysret_arg >= (uintptr_t)-(MAX_ERRNO) :      /* errors */	\
> > > +	 (__sysret_arg + 1) < ((__typeof__(arg))1)     /* signed: <0 = error */	\
> > > +	) ? ({									\
> > > +		SET_ERRNO(-(intptr_t)__sysret_arg);				\
> > > +		((__typeof__(arg)) -1);              /* return -1 upon error */	\
> > > +	}) : __sysret_arg;        /* return original value & type on success */	\
> > > +})
> > > +
> > >
> > 
> > To be honest, it is also a little complex when with one "?:" embedded in
> > another, I even don't understand how the 'unsigned arg' branch works,
> > sorry, is it dark magic like the __is_constexpr? ;-)
> 
> The thing is that we don't need to do anything specific for consts, we
> just need to check whether an argument is signed or unsigned. The test
> for unsigned is that all unsigned integers are positive, so
> ((unsigned)-1 > 0) is always true. We just compare it to 1 instead of
> 0 to shut up the compiler which was seeing a comparison against NULL.
> 
> The rest is just checking if arg < 0 if arg is signed, or
> arg >= -MAX_ERRNO if it's unsigned, and if so, assigns its negation to
> errno and returns -1 otherwise returns it as-is. So it's not dark magic,
> doesn't rely on compiler's behavior and does not require links to external
> books explaining why the macro works in modern compilers.

Yeah, I have mixed the outside '?:' with the inside '?:', now get it,
thanks a lot!

    ({                                                                             \
      (                                                                            \
        (((__typeof__(arg)) -1) > (__typeof__(arg)) 1)     ?   /* unsigned arg? */ \
        (uintptr_t)__sysret_arg >= (uintptr_t)-(MAX_ERRNO) :      /* errors */	   \
        (__sysret_arg + 1) < ((__typeof__(arg))1)     /* signed: <0 = error */	   \
      ) ? ({									   \
       		SET_ERRNO(-(intptr_t)__sysret_arg);				   \
       		((__typeof__(arg)) -1);              /* return -1 upon error */	   \
       	  })                                                                       \
        : __sysret_arg;        /* return original value & type on success */	   \
    })

This looks better although you have prepared a pretty one below ;-)

> Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
> honest, because we're there just because of the temptation to remove
> lines that were not causing any difficulties :-/
>
> I think we can do something in-between and deal only with signed returns,
> and explicitly place the test for MAX_ERRNO on the two unsigned ones
> (brk and mmap). It should look approximately like this:
> 
>  #define __sysret(arg)                                                \
>  ({                                                                   \
>  	__typeof__(arg) __sysret_arg = (arg);                           \
>  	(__sysret_arg < 0) ? ({           /* error ? */                 \
>  		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
>  		((__typeof__(arg)) -1);   /*      return -1 */          \
>  	}) : __sysret_arg;                /* return original value */   \
>  })
>

I like this one very much, a simple test shows, it saves one more byte.

Only a quesiton, why 'errno != -ret' has a '!'? and we have post-tab in
above two lines of __sysret() too, I have changed them to whitespaces.

For the brk and mmap part, it is ok to restore them as before, and it
also works with the new patchset we proposed above, only need such
tuning:

    #define sys_brk(...)                               __sysdef(brk, __VA_ARGS__)
    #define sys_mmap(...)                              __sysdef(mmap, __VA_ARGS__)
    #define sys_mmap2(...)                             __sysdef(mmap2, __VA_ARGS__)

    -->

    #define sys_brk(...)                       (void *)__sysdef(brk, __VA_ARGS__)
    #define sys_mmap(...)                      (void *)__sysdef(mmap, __VA_ARGS__)
    #define sys_mmap2(...)                     (void *)__sysdef(mmap2, __VA_ARGS__)

But let them align with the others may be better, so, most of the sys_*
macros can be simply mapped with a simple line (all of them are
generated automatically), without the care of the return types changing.

So, Willy, as a summary:

- one solution is your new __sysret() + restore the original SET_ERRNO
  for mmap and brk [1].

- another solution is your new __sysret() + my patch [2] to let mmap and brk
  return 'long' as the other sys_* function does.

Both of them are ok for me, but If we can apply the second one, the
proposed patchset above may be cleaner. The patch [2] is really a
prepare patch for the above proposed patchset, that is why I send it
before that patchset.

It is time to finish the size inflate regression issue, after you apply
any of the above solutions, I will resell my proposed patchset above, at
least a RFC patchset, please ignore this currently ;-) 

[1]: https://lore.kernel.org/lkml/20230813090037.GE8237@1wt.eu/#t
[2]: https://lore.kernel.org/lkml/82b584cbda5cee8d5318986644a2a64ba749a098.1691788036.git.falcon@tinylab.org/

Best regards,
Zhangjin

> Willy
