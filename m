Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3977A5A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjHMIv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjHMIvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 04:51:55 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20CEF170C;
        Sun, 13 Aug 2023 01:51:56 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D8peaY008548;
        Sun, 13 Aug 2023 10:51:40 +0200
Date:   Sun, 13 Aug 2023 10:51:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Message-ID: <20230813085140.GD8237@1wt.eu>
References: <ZNKOJY+g66nkIyvv@1wt.eu>
 <20230809221743.83107-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809221743.83107-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Thu, Aug 10, 2023 at 06:17:43AM +0800, Zhangjin Wu wrote:
> > Quite frankly, even if it can be looked at as a piece of art, I don't
> > like it. It's overkill for what we need and it brings in several tricky
> > macros that we don't need and that require a link to their analysis so
> > that nobody breaks them by accident. I mean, if one day we need them,
> > okay we know we can find them, they're perfect for certain use cases.
> > But all this just to avoid a ternary operation is far too much IMHO.
> > That's without counting on the compiler tricks to use the ugly
> > __auto_type when available, and the macro names which continue to
> > possibly interact with user code.
> >
> 
> Agree, I don't like __auto_type too, although I have tried to find whether
> there is a direct macro for it, but NO such one, and the __auto_type in some
> older versions don't accept 'const' flag, so, I'm also worried about if gcc
> will change it in the future ;-(

I mean, it's just that we do not need it at all.

> Seems __sysret() is mainly used by us in sys.h,

Sure, it was added not long ago by you to factor all the calls to
SET_ERRNO():

   428905da6ec4 ("tools/nolibc: sys.h: add a syscall return helper")

> perhaps we can simply
> assume and guarantee nobody will use 'const' in such cases.

There is absolutely *no* problem with const since the value is use by
a "return" statement.

> > And if you remember, originally you proposed to factor the SET_ERRNO()
> > stuff in every syscall in order to "simplify the code and improve
> > maintainability". It's clear that we've long abandonned that goal here.
> > If we had no other choice, I'd rather roll back to the clean, readable
> > and trustable SET_ERRNO() in every syscall!
> >
> 
> Agree, or we simply use the original version without pointer returns support
> (only sbrk and mmap currently) but convert it to the macro version.

I indeed think that's the cleanest approach. There will hardly be more
than 2 syscalls returning pointers or unsigned values and all this extra
complexity added just to avoid *two* SET_ERRNO() calls is totally
pointless.

> Or, as the idea mentioned by Thomas in a reply: if we can let the sys_
> functions use 'long' returns, or even further, we convert all of the sys_
> functions to macros and let them preserve input types from library routines and
> preserve return types from the my_syscall<N> macros.

It would be annoying because the sys_* implement some fallbacks, themselves
based on #ifdef and such stuff. Macros are really a pain when they're
repeated. They're a pain to edit, to debug, to modify and you'll see that
editors are even not good with them, you often end up modifying more than
you want to try to keep trailing backslashes aligned.

> As we discussed in my our syscall.h proposal, if there is a common
> my_syscall(), every sys_ function can be simply defined to something
> like:
> 
>     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
> 
> In my_syscall(), it can even simply return -ENOSYS if the __NR_xxx is
> not defined (we init such __NR_xxx to something like __NR_NOSYS):
> 
>     // sysnr.h
> 
>     // If worried about the applications use this macro, perhaps we can
>     // use a different prefix, for example, NOLIBC_NR_xxx
> 
>     #define NOLIBC_NR_NOSYS (-1L)
> 
>     #ifndef __NR_xxx
>     #define NOLIBC_NR_xxx NOLIBC_NR_NOSYS
>     #else
>     #define NOLIBC_NR_xxx __NR_xxx
>     #endif
> 
>     // syscall.h
> 
>     // _my_syscall is similar to syscall() in unistd.h, but without the
>     // __sysret normalization
> 
>     #define _my_syscalln(N, ...) my_syscall##N(__VA_ARGS__)
>     #define _my_syscall_n(N, ...) _my_syscalln(N, __VA_ARGS__)
>     #define _my_syscall(...) _my_syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
> 
>     #define my_syscall(name, ...)                                       \
>     ({                                                                  \
>            long _ret;                                                   \
>            if (NOLIBC_NR_##name == NOLIBC_NR_NOSYS)                     \
>                    _ret = -ENOSYS;                                      \
>            else                                                         \
>                    _ret = _my_syscall(NOLIBC_NR_##name, ##__VA_ARGS__); \
>            _ret;                                                        \
>     })
> 
>     // sys_<NAME> list, based on unistd.h
> 
>     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
>     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
>     #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
> 
> With above conversions, we may be able to predefine all of the
> sys_<NAME> functions to preserve the input types from library rountines
> and return types from my_syscall<N> (by default, 'long'). This also
> follows the suggestion from Arnd: let sys_ not use the other low level
> syscalls, only use its own.

Maybe, but I'm not sure there is much to gain here, compared to the
flexibility to map one to another (e.g. see sys_chmod()).

> This may also help us to remove all of the `#ifdef __NR_` wrappers, we
> can directly check the -ENOSYS in the library routines and try another
> sys_<NAME> if required, at last, call __sysret() to normalize the errors
> and return value.
> 
> Use dup2 and dup3 as examples, with sysnr.h and syscall.h above, sys.h
> will work like this, without any #ifdef's:
> 
>     /*
>      * int dup2(int old, int new);
>      */
>    
>     static __attribute__((unused))
>     int dup2(int old, int new)
>     {
> 	int ret = sys_dup3(old, new, 0);
> 
> 	if (ret == -ENOSYS)
> 		ret = sys_dup2(old, new);
> 
> 	return __sysret(ret);
>     }

But this will add a useless test after all such syscalls, we'd rather
not do that!

> > -static __inline__ __attribute__((unused, always_inline))
> > -long __sysret(unsigned long ret)
> > -{
> > -	if (ret >= (unsigned long)-MAX_ERRNO) {
> > -		SET_ERRNO(-(long)ret);
> > -		return -1;
> > -	}
> > -	return ret;
> > -}
> > +#define __sysret(arg)								\
> > +({										\
> > +	__typeof__(arg) __sysret_arg = (arg);					\
> 
> Here ignores the 'const' flag in input type?

Yes, as explained above, there's no issue with const. The issue
that was met in the version I suggested in the message was that
there was an assignment to the variable of value -1 to be returned,
which is not permitted when it's const, and I said that it was not
necessary, it was just a convenience, but that using "?:" does the
job as well without having to do any assignment.

> > +	((((__typeof__(arg)) -1) > (__typeof__(arg)) 1) ?   /* unsigned arg? */	\
> > +	 (uintptr_t)__sysret_arg >= (uintptr_t)-(MAX_ERRNO) :      /* errors */	\
> > +	 (__sysret_arg + 1) < ((__typeof__(arg))1)     /* signed: <0 = error */	\
> > +	) ? ({									\
> > +		SET_ERRNO(-(intptr_t)__sysret_arg);				\
> > +		((__typeof__(arg)) -1);              /* return -1 upon error */	\
> > +	}) : __sysret_arg;        /* return original value & type on success */	\
> > +})
> > +
> >
> 
> To be honest, it is also a little complex when with one "?:" embedded in
> another, I even don't understand how the 'unsigned arg' branch works,
> sorry, is it dark magic like the __is_constexpr? ;-)

The thing is that we don't need to do anything specific for consts, we
just need to check whether an argument is signed or unsigned. The test
for unsigned is that all unsigned integers are positive, so
((unsigned)-1 > 0) is always true. We just compare it to 1 instead of
0 to shut up the compiler which was seeing a comparison against NULL.

The rest is just checking if arg < 0 if arg is signed, or
arg >= -MAX_ERRNO if it's unsigned, and if so, assigns its negation to
errno and returns -1 otherwise returns it as-is. So it's not dark magic,
doesn't rely on compiler's behavior and does not require links to external
books explaining why the macro works in modern compilers.

Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
honest, because we're there just because of the temptation to remove
lines that were not causing any difficulties :-/

I think we can do something in-between and deal only with signed returns,
and explicitly place the test for MAX_ERRNO on the two unsigned ones
(brk and mmap). It should look approximately like this:

 #define __sysret(arg)							\
 ({									\
 	__typeof__(arg) __sysret_arg = (arg);				\
 	(__sysret_arg < 0) ? ({           /* error ? */                 \
 		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
 		((__typeof__(arg)) -1);   /*      return -1 */          \
 	}) : __sysret_arg;                /* return original value */   \
 })

Willy
