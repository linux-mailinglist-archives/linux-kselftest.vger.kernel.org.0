Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E9776C12
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHIWSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 18:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHIWSF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 18:18:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B3A8;
        Wed,  9 Aug 2023 15:18:03 -0700 (PDT)
X-QQ-mid: bizesmtp70t1691619465t6a4cedv
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Aug 2023 06:17:43 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: CR3LFp2JE4n8L+hdDjrrIQxHTA6lvmId3Epf/MLmAquPYJG3HQp6+7Vu30gmc
        gEAI8kmIR9pPYDeyXGIXZaKhvuIDiheWb9kIl4GY9v2lFpBJJ92RyneIIEYG/iroOTquKtO
        QDc89VCyyy3/JLebaZSOxQM7ceVsQWwSfA0xRdIRpphRGMWDxX4uEt0oNby/9CxBhOZ4HwZ
        v4Pet3iuiQoG66YcskBEc5UDdN0t4oSGziiUcYw6RLL1ZpyIwzp1kVWXoEdMguA7Ntm2+4g
        l8F4rsewg0i2GgQt4yarrpwalHaFI8EmI2pMu1sSaq2wQyWmhOML4Z+kjDzod1L9S9LhxTn
        KSnB787264NUwLRbaUUL2TVhUPMI2WeoBZ733xI
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2155024174687237353
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Date:   Thu, 10 Aug 2023 06:17:43 +0800
Message-Id: <20230809221743.83107-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZNKOJY+g66nkIyvv@1wt.eu>
References: <ZNKOJY+g66nkIyvv@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Tue, Aug 08, 2023 at 04:04:05AM +0800, Zhangjin Wu wrote:
> > As reported and suggested by Willy, the inline __sysret() helper
> > introduces three types of conversions and increases the size:
> > 
> > (1) the "unsigned long" argument to __sysret() forces a sign extension
> > from all sys_* functions that used to return 'int'
> > 
> > (2) the comparison with the error range now has to be performed on a
> > 'unsigned long' instead of an 'int'
> > 
> > (3) the return value from __sysret() is a 'long' (note, a signed long)
> > which then has to be turned back to an 'int' before being returned by the
> > caller to satisfy the caller's prototype.
> > 
> > To fix up this, firstly, let's use macro instead of inline function to
> > preserves the input type and avoids these useless conversions (1), (3).
> > 
> > Secondly, comparison to -MAX_ERRNO inflicts on all integer returns where
> > we could previously keep a simple sign comparison, let's use a new
> > __is_pointer() macro suggested by David Laight to limit the comparison
> > to -MAX_ERRNO (2) only for pointer returns and preserve a simple sign
> > comparison for integer returns as before. The __builtin_choose_expr()
> > is suggested by David Laight to choose different comparisons based on
> > the types to share code.
> > 
> > Thirdly, fix up the following warning by an explicit conversion and let
> > __sysret() be able to accept the (void *) type of argument:
> > 
> >     sysroot/powerpc/include/sys.h: In function 'sbrk':
> >     sysroot/powerpc/include/sys.h:104:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >       104 |         return (void *)__sysret(-ENOMEM);
> > 
> > Fourthly, to further workaround the argument type with 'const' flag,
> > must use __auto_type for gcc >= 11.0 and __typeof__((arg) + 0) suggested
> > by David Laight for old gcc versions.
> (...)
> > tools/include/nolibc/sys.h | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
> > 1 file changed, 59 insertions(+), 15 deletions(-)
> 
> Quite frankly, even if it can be looked at as a piece of art, I don't
> like it. It's overkill for what we need and it brings in several tricky
> macros that we don't need and that require a link to their analysis so
> that nobody breaks them by accident. I mean, if one day we need them,
> okay we know we can find them, they're perfect for certain use cases.
> But all this just to avoid a ternary operation is far too much IMHO.
> That's without counting on the compiler tricks to use the ugly
> __auto_type when available, and the macro names which continue to
> possibly interact with user code.
>

Agree, I don't like __auto_type too, although I have tried to find whether
there is a direct macro for it, but NO such one, and the __auto_type in some
older versions don't accept 'const' flag, so, I'm also worried about if gcc
will change it in the future ;-(

Seems __sysret() is mainly used by us in sys.h, perhaps we can simply
assume and guarantee nobody will use 'const' in such cases.

> And if you remember, originally you proposed to factor the SET_ERRNO()
> stuff in every syscall in order to "simplify the code and improve
> maintainability". It's clear that we've long abandonned that goal here.
> If we had no other choice, I'd rather roll back to the clean, readable
> and trustable SET_ERRNO() in every syscall!
>

Agree, or we simply use the original version without pointer returns support
(only sbrk and mmap currently) but convert it to the macro version.

Or, as the idea mentioned by Thomas in a reply: if we can let the sys_
functions use 'long' returns, or even further, we convert all of the sys_
functions to macros and let them preserve input types from library routines and
preserve return types from the my_syscall<N> macros.

As we discussed in my our syscall.h proposal, if there is a common
my_syscall(), every sys_ function can be simply defined to something
like:

    #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)

In my_syscall(), it can even simply return -ENOSYS if the __NR_xxx is
not defined (we init such __NR_xxx to something like __NR_NOSYS):

    // sysnr.h

    // If worried about the applications use this macro, perhaps we can
    // use a different prefix, for example, NOLIBC_NR_xxx

    #define NOLIBC_NR_NOSYS (-1L)

    #ifndef __NR_xxx
    #define NOLIBC_NR_xxx NOLIBC_NR_NOSYS
    #else
    #define NOLIBC_NR_xxx __NR_xxx
    #endif

    // syscall.h

    // _my_syscall is similar to syscall() in unistd.h, but without the
    // __sysret normalization

    #define _my_syscalln(N, ...) my_syscall##N(__VA_ARGS__)
    #define _my_syscall_n(N, ...) _my_syscalln(N, __VA_ARGS__)
    #define _my_syscall(...) _my_syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)

    #define my_syscall(name, ...)                                       \
    ({                                                                  \
           long _ret;                                                   \
           if (NOLIBC_NR_##name == NOLIBC_NR_NOSYS)                     \
                   _ret = -ENOSYS;                                      \
           else                                                         \
                   _ret = _my_syscall(NOLIBC_NR_##name, ##__VA_ARGS__); \
           _ret;                                                        \
    })

    // sys_<NAME> list, based on unistd.h

    #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
    #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)
    #define sys_<NAME>(...) my_syscall(<NAME>, __VA_ARGS__)

With above conversions, we may be able to predefine all of the
sys_<NAME> functions to preserve the input types from library rountines
and return types from my_syscall<N> (by default, 'long'). This also
follows the suggestion from Arnd: let sys_ not use the other low level
syscalls, only use its own.

This may also help us to remove all of the `#ifdef __NR_` wrappers, we
can directly check the -ENOSYS in the library routines and try another
sys_<NAME> if required, at last, call __sysret() to normalize the errors
and return value.

Use dup2 and dup3 as examples, with sysnr.h and syscall.h above, sys.h
will work like this, without any #ifdef's:

    /*
     * int dup2(int old, int new);
     */
   
    static __attribute__((unused))
    int dup2(int old, int new)
    {
	int ret = sys_dup3(old, new, 0);

	if (ret == -ENOSYS)
		ret = sys_dup2(old, new);

	return __sysret(ret);
    }
    
    /*
     * int dup3(int old, int new, int flags);
     */
    
    static __attribute__((unused))
    int dup3(int old, int new, int flags)
    {
    	return __sysret(sys_dup3(old, new, flags));
    }

If the above description is not clear enough, I have changed something for this
idea with more cleanups and have done some simple tests:

Compare with v5 --> v6 (with gcc-13.2.0):

     i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  19509 -> 19250
   x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  22012 -> 21758
    arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  25868 -> 25804
      arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  23112 -> 22828
     mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning  22924 -> 22740
      ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  26628 -> 26376
    ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  27204 -> 26756
  ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  27828 -> 27364
    riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning  21870 -> 21772
     s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning  22192 -> 21992

And now we get:

    $ wc -l tools/include/nolibc/sys.h
    746 tools/include/nolibc/sys.h

    $ wc -l tools/include/nolibc/sysnr.h 
    410 tools/include/nolibc/sysnr.h
    $ wc -l tools/include/nolibc/syscall.h 
    110 tools/include/nolibc/syscall.h

Before:

    $ wc -l tools/include/nolibc/sys.h 
    1222 tools/include/nolibc/sys.h

Most of the library routines become one line code.

The main size reduced may be the carefully tuned sys_ selection, for example,
linkat v.s. link,  the patchset still require some cleanups, will send v6 for
more discussion if you agree. 

> So I just restarted from what I proposed the other day, using a ternary
> operator as I suggested in order to address the const case, and it gives
> me the following patch, which is way simpler and still a bit readable.
> It's made of two nested (?:) :
>   - the first one to determine if we have to check for the sign or
>     against -MAX_ERRNO to detect an error (depends on the arg's
>     signedness)
>   - the second one to return either the argument as-is or -1.
> 
> The only two tricks are that (typeof(arg))-1 is compared to 1 instead of
> zero so that gcc doesn't complain that we're comparing against a null
> pointer, and similarly we compare arg+1 to 1 instead of arg to 0 for the
> negative case, and that's all. It gives me the expected code and output
> from gcc-4.7 to 12.3, and clang-13.
> 
> I've checked against your version and it's always exactly the same (in
> fact to be more precise sometimes it's 1-2 bytes smaller but that's only
> due to the compiler taking liberties with the code ordering, it could as
> well have done it the other way around, though it did not this time):
> 
>  26144 zhangjin-v5/nolibc-test--Os-arm64     | 26144 willy/nolibc-test--Os-arm64
>  23340 zhangjin-v5/nolibc-test--Os-armv5     | 23340 willy/nolibc-test--Os-armv5
[...]
> 
> Unless there's any objection, I'll queue this one. And if __sysret()
> annoys us again in the future I might very well revert that simplification.
> 
> Any question about the patch ?
> 
[...]
>  
> -/* Syscall return helper for library routines, set errno as -ret when ret is in
> - * range of [-MAX_ERRNO, -1]
> - *
> - * Note, No official reference states the errno range here aligns with musl
> - * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
> +/* Syscall return helper: takes the syscall value in argument and checks for an
> + * error in it. For unsigned returns, an error is within [-MAX_ERRNO, -1]. For
> + * signed returns, an error is any value < 0. When an error is encountered,
> + * -ret is set into errno and -1 is returned. Otherwise the returned value is
> + * passed as-is with its type preserved.
>   */
>  
> -static __inline__ __attribute__((unused, always_inline))
> -long __sysret(unsigned long ret)
> -{
> -	if (ret >= (unsigned long)-MAX_ERRNO) {
> -		SET_ERRNO(-(long)ret);
> -		return -1;
> -	}
> -	return ret;
> -}
> +#define __sysret(arg)								\
> +({										\
> +	__typeof__(arg) __sysret_arg = (arg);					\

Here ignores the 'const' flag in input type?

> +	((((__typeof__(arg)) -1) > (__typeof__(arg)) 1) ?   /* unsigned arg? */	\
> +	 (uintptr_t)__sysret_arg >= (uintptr_t)-(MAX_ERRNO) :      /* errors */	\
> +	 (__sysret_arg + 1) < ((__typeof__(arg))1)     /* signed: <0 = error */	\
> +	) ? ({									\
> +		SET_ERRNO(-(intptr_t)__sysret_arg);				\
> +		((__typeof__(arg)) -1);              /* return -1 upon error */	\
> +	}) : __sysret_arg;        /* return original value & type on success */	\
> +})
> +
>

To be honest, it is also a little complex when with one "?:" embedded in
another, I even don't understand how the 'unsigned arg' branch works,
sorry, is it dark magic like the __is_constexpr? ;-)

Thanks,
Zhangjin

>  /* Functions in this file only describe syscalls. They're declared static so
>   * that the compiler usually decides to inline them while still being allowed
> @@ -94,7 +97,7 @@ void *sbrk(intptr_t inc)
>  	if (ret && sys_brk(ret + inc) == ret + inc)
>  		return ret + inc;
>  
> -	return (void *)__sysret(-ENOMEM);
> +	return __sysret((void *)-ENOMEM);
>  }
>  
>  
> @@ -682,7 +685,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
>  static __attribute__((unused))
>  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
>  {
> -	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
> +	return __sysret(sys_mmap(addr, length, prot, flags, fd, offset));
>  }
>  
>  static __attribute__((unused))
> -- 
> 2.35.3
