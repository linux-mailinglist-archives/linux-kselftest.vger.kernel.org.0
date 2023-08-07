Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281537719CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 07:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjHGF6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 01:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjHGF57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 01:57:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2C170B;
        Sun,  6 Aug 2023 22:57:55 -0700 (PDT)
X-QQ-mid: bizesmtp70t1691387853tz776qn7
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 13:57:32 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 7jw2iSiCazrDRCkOXuADr5FHLOFZXWkxZuDnONNhh+oqJ3Wt3OCZM/MgwcO+4
        SdEQqXlZfjCMNUfrOjH6EsTZNBaCEFYx3otcNH7v5TDzYW7FWNZWS261/ej8VXbXpYCCd1u
        Kw+KjhyW45sQPfcOrJvzb3X9Zco/k868fgrfmk2KKzl+dY/omThbOAgqqsUQ4DVUYkDWE9s
        j3pLbl3UNGMlO6CeOBQWyubYCqgdwfS4qkQcMxaH1Lq7uChjjUC632J8PR1sbXU82/v/4LT
        1RFhMtFgl1aK1kkzgn/Gc2jdODnpPOsXzNcQniiVjzpJC3GkYRnHrC3jxy1lZEQTtA/kPXi
        YG6EESBIXs5g/inWtWhT/oxSqvRQrGCypjQI3lblntTdTUtlNOiwiBz5Up/dzlwUSPg7nUb
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8095711180092042174
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: [PATCH v3] tools/nolibc: fix up size inflate regression
Date:   Mon,  7 Aug 2023 13:57:32 +0800
Message-Id: <8eaab5da2dcbba42e3f3efc2ae686a22c95f84f0.1691386601.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
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

As reported and suggested by Willy, the inline __sysret() helper
introduces three types of conversions and increases the size:

(1) the "unsigned long" argument to __sysret() forces a sign extension
from all sys_* functions that used to return 'int'

(2) the comparison with the error range now has to be performed on a
'unsigned long' instead of an 'int'

(3) the return value from __sysret() is a 'long' (note, a signed long)
which then has to be turned back to an 'int' before being returned by the
caller to satisfy the caller's prototype.

To fix up this, firstly, let's use macro instead of inline function to
preserves the input type and avoids these useless conversions (1), (3).

Secondly, comparison to -MAX_ERRNO inflicts on all integer returns where
we could previously keep a simple sign comparison, let's use a new
is_signed_type() macro from include/linux/compiler.h to limit the
comparision to -MAX_ERRNO (2) only on demand and preserves a simple sign
comparision for most of the cases as before.

Thirdly, fix up the following warning by an explicit conversion and let
__sysret() be able to accept the (void *) type of argument and return
value with the same (void *) type:

    sysroot/powerpc/include/sys.h: In function 'sbrk':
    sysroot/powerpc/include/sys.h:104:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      104 |         return (void *)__sysret(-ENOMEM);

Fourthly, to further workaround the argument type with 'const', must use
__auto_type for a new enough gcc versions and use 'long' for the old gcc
versions as before.

Here reports the size testing result with nolibc-test:

before:

    // ppc64le
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27916	      8	     80	  28004	   6d64	nolibc-test

    // mips
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      23276	     64	     64	  23404	   5b6c	nolibc-test

after:

    // ppc64le
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27736	      8	     80	  27824	   6cb0	nolibc-test

    // mips
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      23036	     64	     64	  23164	   5a7c	nolibc-test

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/
Link: https://lore.kernel.org/lkml/20230806134348.GA19145@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---

Hi, Willy

To increase readability, v3 further defines a
__GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT macro for gcc >= 11.0
(ABI_VERSION >= 1016) who has __auto_type with 'const' support.

When this macro is defined, provides a __sysret version with
__auto_type, otherwise, use a fixed 'long' type as a fallback.

Tested for all of the nolibc supported architectures with Arnd's
13.2.0 toolchains. and also for x86_64 with gcc-4.8 and gcc-9, no
compile failures, no compile warnings, no running failures.

Changes from v2 --> v3:

* define a __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT for gcc >= 11.0 (ABI_VERSION >= 1016)
* split __sysret() to two versions by the macro instead of a mixed unified and unreadable version
* use shorter __ret instead of __sysret_arg

Changes from v1 --> v2:

* fix up argument with 'const' in the type
* support "void *" argument

v2: https://lore.kernel.org/lkml/95fe3e732f455fab653fe1427118d905e4d04257.1691339836.git.falcon@tinylab.org/
v1: https://lore.kernel.org/lkml/20230806131921.52453-1-falcon@tinylab.org/

---
 tools/include/nolibc/sys.h | 66 +++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 56f63eb48a1b..b137f7771db9 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -35,15 +35,59 @@
  * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
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
+/*
+ * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
+ * bool and also pointer types. (from include/linux/compiler.h)
+ */
+#define __is_signed_type(type) (((type)(-1)) < (type)1)
+
+/* __auto_type is used instead of __typeof__ to workaround the build error
+ * 'error: assignment of read-only variable' when the argument has 'const' in
+ * the type, but __auto_type is a new feature from newer gcc version and it
+ * only works with 'const' from gcc 11.0 (__GXX_ABI_VERSION = 1016)
+ * https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
+ */
+
+#if __GXX_ABI_VERSION >= 1016
+#define __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT
+#endif
+
+#ifdef __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT
+#define __sysret(arg)                                                    \
+({                                                                       \
+	__auto_type __ret = (arg);                                       \
+	if (__is_signed_type(__typeof__(arg))) {                         \
+		if (__ret < 0) {                                         \
+			SET_ERRNO(-(long)__ret);                         \
+			__ret = (__typeof__(arg))(-1L);                  \
+		}                                                        \
+	} else {                                                         \
+		if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
+			SET_ERRNO(-(long)__ret);                         \
+			__ret = (__typeof__(arg))(-1L);                  \
+		}                                                        \
+	}                                                                \
+	__ret;                                                           \
+})
+
+#else  /* ! __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT */
+#define __sysret(arg)                                                    \
+({                                                                       \
+	long __ret = (long)(arg);                                        \
+	if (__is_signed_type(__typeof__(arg))) {                         \
+		if (__ret < 0) {                                         \
+			SET_ERRNO(-__ret);                               \
+			__ret = -1L;                                     \
+		}                                                        \
+	} else {                                                         \
+		if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
+			SET_ERRNO(-__ret);                               \
+			__ret = -1L;                                     \
+		}                                                        \
+	}                                                                \
+	(__typeof__(arg))__ret;                                          \
+})
+#endif /* ! __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT */
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
@@ -94,7 +138,7 @@ void *sbrk(intptr_t inc)
 	if (ret && sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
 
-	return (void *)__sysret(-ENOMEM);
+	return __sysret((void *)-ENOMEM);
 }
 
 
@@ -682,7 +726,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
+	return __sysret(sys_mmap(addr, length, prot, flags, fd, offset));
 }
 
 static __attribute__((unused))
-- 
2.25.1

