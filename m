Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D502774810
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHHTZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjHHTZX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 15:25:23 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7A3C12C83;
        Tue,  8 Aug 2023 11:49:29 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 378In9WT005841;
        Tue, 8 Aug 2023 20:49:09 +0200
Date:   Tue, 8 Aug 2023 20:49:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Message-ID: <ZNKOJY+g66nkIyvv@1wt.eu>
References: <b6ff2684f557f6ce00151905990643e651391614.1691437328.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ff2684f557f6ce00151905990643e651391614.1691437328.git.falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Tue, Aug 08, 2023 at 04:04:05AM +0800, Zhangjin Wu wrote:
> As reported and suggested by Willy, the inline __sysret() helper
> introduces three types of conversions and increases the size:
> 
> (1) the "unsigned long" argument to __sysret() forces a sign extension
> from all sys_* functions that used to return 'int'
> 
> (2) the comparison with the error range now has to be performed on a
> 'unsigned long' instead of an 'int'
> 
> (3) the return value from __sysret() is a 'long' (note, a signed long)
> which then has to be turned back to an 'int' before being returned by the
> caller to satisfy the caller's prototype.
> 
> To fix up this, firstly, let's use macro instead of inline function to
> preserves the input type and avoids these useless conversions (1), (3).
> 
> Secondly, comparison to -MAX_ERRNO inflicts on all integer returns where
> we could previously keep a simple sign comparison, let's use a new
> __is_pointer() macro suggested by David Laight to limit the comparison
> to -MAX_ERRNO (2) only for pointer returns and preserve a simple sign
> comparison for integer returns as before. The __builtin_choose_expr()
> is suggested by David Laight to choose different comparisons based on
> the types to share code.
> 
> Thirdly, fix up the following warning by an explicit conversion and let
> __sysret() be able to accept the (void *) type of argument:
> 
>     sysroot/powerpc/include/sys.h: In function 'sbrk':
>     sysroot/powerpc/include/sys.h:104:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       104 |         return (void *)__sysret(-ENOMEM);
> 
> Fourthly, to further workaround the argument type with 'const' flag,
> must use __auto_type for gcc >= 11.0 and __typeof__((arg) + 0) suggested
> by David Laight for old gcc versions.
(...)
> tools/include/nolibc/sys.h | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
> 1 file changed, 59 insertions(+), 15 deletions(-)

Quite frankly, even if it can be looked at as a piece of art, I don't
like it. It's overkill for what we need and it brings in several tricky
macros that we don't need and that require a link to their analysis so
that nobody breaks them by accident. I mean, if one day we need them,
okay we know we can find them, they're perfect for certain use cases.
But all this just to avoid a ternary operation is far too much IMHO.
That's without counting on the compiler tricks to use the ugly
__auto_type when available, and the macro names which continue to
possibly interact with user code.

And if you remember, originally you proposed to factor the SET_ERRNO()
stuff in every syscall in order to "simplify the code and improve
maintainability". It's clear that we've long abandonned that goal here.
If we had no other choice, I'd rather roll back to the clean, readable
and trustable SET_ERRNO() in every syscall!

So I just restarted from what I proposed the other day, using a ternary
operator as I suggested in order to address the const case, and it gives
me the following patch, which is way simpler and still a bit readable.
It's made of two nested (?:) :
  - the first one to determine if we have to check for the sign or
    against -MAX_ERRNO to detect an error (depends on the arg's
    signedness)
  - the second one to return either the argument as-is or -1.

The only two tricks are that (typeof(arg))-1 is compared to 1 instead of
zero so that gcc doesn't complain that we're comparing against a null
pointer, and similarly we compare arg+1 to 1 instead of arg to 0 for the
negative case, and that's all. It gives me the expected code and output
from gcc-4.7 to 12.3, and clang-13.

I've checked against your version and it's always exactly the same (in
fact to be more precise sometimes it's 1-2 bytes smaller but that's only
due to the compiler taking liberties with the code ordering, it could as
well have done it the other way around, though it did not this time):

 26144 zhangjin-v5/nolibc-test--Os-arm64     | 26144 willy/nolibc-test--Os-arm64
 23340 zhangjin-v5/nolibc-test--Os-armv5     | 23340 willy/nolibc-test--Os-armv5
 23232 zhangjin-v5/nolibc-test--Os-armv7     | 23232 willy/nolibc-test--Os-armv7
 17508 zhangjin-v5/nolibc-test--Os-armv7t    | 17508 willy/nolibc-test--Os-armv7t
 19674 zhangjin-v5/nolibc-test--Os-i386      | 19673 willy/nolibc-test--Os-i386
 19821 zhangjin-v5/nolibc-test--Os-i586      | 19820 willy/nolibc-test--Os-i586
 23084 zhangjin-v5/nolibc-test--Os-loongarch | 23084 willy/nolibc-test--Os-loongarch
 23404 zhangjin-v5/nolibc-test--Os-mips      | 23404 willy/nolibc-test--Os-mips
 27108 zhangjin-v5/nolibc-test--Os-ppc32     | 27108 willy/nolibc-test--Os-ppc32
 27652 zhangjin-v5/nolibc-test--Os-ppc64     | 27652 willy/nolibc-test--Os-ppc64
 27652 zhangjin-v5/nolibc-test--Os-ppc64le   | 27652 willy/nolibc-test--Os-ppc64le
 19356 zhangjin-v5/nolibc-test--Os-riscv     | 19356 willy/nolibc-test--Os-riscv
 22152 zhangjin-v5/nolibc-test--Os-s390      | 22152 willy/nolibc-test--Os-s390
 22300 zhangjin-v5/nolibc-test--Os-x86_64    | 22299 willy/nolibc-test--Os-x86_64

Unless there's any objection, I'll queue this one. And if __sysret()
annoys us again in the future I might very well revert that simplification.

Any question about the patch ?

Thanks,
Willy

---

From 73dd63ed6666c6f212ba09247e68b6b5711ed6ec Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Tue, 8 Aug 2023 20:12:50 +0200
Subject: tools/nolibc: avoid undesired casts in the __sysret() macro

Having __sysret() as an inline function has the unfortunate effect of
adding casts and large constants comparisons after the syscall returns
that significantly inflate some light code that's otherwise syscall-
heavy. Even nolibc-test grew by ~1%.

Let's switch back to a macro for this, and apply the following rule:
  - if the argument (the local variable containing the syscall return
    value) is signed, any negative value is an error, so the check is
    performed compared to zero with the argument's type ;

  - otherwise if the argument is unsigned, only values >= -MAX_ERRNO
    indicate an error. That's what is used for mmap() for example.

The result is calculated using a ternary operator so that we don't need
to assign values to a temporary variable and that it does work fine with
const if needed.

The sbrk() and mmap() syscalls were also fixed to return the correct
type (they used to have double casts to hide the pointer and restore
it).

Fixes: 428905da6ec4 ("tools/nolibc: sys.h: add a syscall return helper")
Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/
Cc: Zhangjin Wu <falcon@tinylab.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 833d6c5e86dc..6b5f39fbf998 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -28,22 +28,25 @@
 #include "types.h"
 
 
-/* Syscall return helper for library routines, set errno as -ret when ret is in
- * range of [-MAX_ERRNO, -1]
- *
- * Note, No official reference states the errno range here aligns with musl
- * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
+/* Syscall return helper: takes the syscall value in argument and checks for an
+ * error in it. For unsigned returns, an error is within [-MAX_ERRNO, -1]. For
+ * signed returns, an error is any value < 0. When an error is encountered,
+ * -ret is set into errno and -1 is returned. Otherwise the returned value is
+ * passed as-is with its type preserved.
  */
 
-static __inline__ __attribute__((unused, always_inline))
-long __sysret(unsigned long ret)
-{
-	if (ret >= (unsigned long)-MAX_ERRNO) {
-		SET_ERRNO(-(long)ret);
-		return -1;
-	}
-	return ret;
-}
+#define __sysret(arg)								\
+({										\
+	__typeof__(arg) __sysret_arg = (arg);					\
+	((((__typeof__(arg)) -1) > (__typeof__(arg)) 1) ?   /* unsigned arg? */	\
+	 (uintptr_t)__sysret_arg >= (uintptr_t)-(MAX_ERRNO) :      /* errors */	\
+	 (__sysret_arg + 1) < ((__typeof__(arg))1)     /* signed: <0 = error */	\
+	) ? ({									\
+		SET_ERRNO(-(intptr_t)__sysret_arg);				\
+		((__typeof__(arg)) -1);              /* return -1 upon error */	\
+	}) : __sysret_arg;        /* return original value & type on success */	\
+})
+
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
@@ -94,7 +97,7 @@ void *sbrk(intptr_t inc)
 	if (ret && sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
 
-	return (void *)__sysret(-ENOMEM);
+	return __sysret((void *)-ENOMEM);
 }
 
 
@@ -682,7 +685,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
+	return __sysret(sys_mmap(addr, length, prot, flags, fd, offset));
 }
 
 static __attribute__((unused))
-- 
2.35.3

