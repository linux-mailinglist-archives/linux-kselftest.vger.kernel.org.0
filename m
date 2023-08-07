Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC97771BE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 09:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHGHz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 03:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjHGHzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 03:55:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978B2DD;
        Mon,  7 Aug 2023 00:55:13 -0700 (PDT)
X-QQ-mid: bizesmtp77t1691394885tju2pous
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 15:54:43 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 1fH6gRJ4X2KYo6S8RFhJ7dyJtT4AuywqyW3RGhFGExJ0qmLajUVclEjXNkEHX
        zrJdqB9/cEuJ9lB70Kquntruv1m+7fwYQK/m2qGWL6SkotABF9M9MWTBvd0dfLzLt60po14
        G59IyGqSNdXfls1bHywrU8KNJdySgX3Fcy5NhsZU8eRRpL7qYWZ8pqOUrsGWKRWPEkrJx9t
        m7UO5oN20IzY5aj2A3K9s1PfWGlS94SnRcnGJBhTrr2POYpoOPbEVrzaFAjv6gz3QNggrdq
        klDHgfe2gYuWW5g2Nh1bNNziWCivKhHqoFq0kuyEoteSf4XjAzso1cOkgEqQN8o30avfwyn
        UWhEiM+2XqEJrNob3vApfN3w2Ipt0o1JN5YbPKIWqnniYf7odaJ1WvyjjFjWvrBcEYSyJC4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 750520336660474344
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: [PATCH v4] tools/nolibc: fix up size inflate regression
Date:   Mon,  7 Aug 2023 15:54:42 +0800
Message-Id: <a4084f7fac7a89f861b5582774bc7a98634d1e76.1691392805.git.falcon@tinylab.org>
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
__sysret() be able to accept the (void *) type of argument:

    sysroot/powerpc/include/sys.h: In function 'sbrk':
    sysroot/powerpc/include/sys.h:104:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      104 |         return (void *)__sysret(-ENOMEM);

Fourthly, to further workaround the argument type with 'const', must use
__auto_type in a new enough version or use 'long' as before.

Here reports the size testing result of nolibc-test with gcc 13.2.0:

before:

    // ppc64le with powerpc64-linux-gcc
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      28004	      8	     80	  28092	   6dbc	nolibc-test

    // mips with mips64-linux-gcc (CFLAGS="-mabi=32 -EL")
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      23164	     64	     64	  23292	   5afc	nolibc-test

after:

    // ppc64le with powerpc64-linux-gcc
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      27828	      8	     80	  27916	   6d0c	nolibc-test

    // mips with mips64-linux-gcc (CFLAGS="-mabi=32 -EL")
    $ size nolibc-test
       text	   data	    bss	    dec	    hex	filename
      22924	     64	     64	  23052	   5a0c	nolibc-test

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/
Link: https://lore.kernel.org/lkml/20230806134348.GA19145@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---

Hi, Willy

v4 rebases on latest 20230806-for-6.6-1	and fixes up a warning reported
by the new -Wall -Wextra options.

Changes from v3 --> v4:

* fix up a new warning about 'ret < 0' when the input arg type is (void *)

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
index 833d6c5e86dc..565b4a295c11 100644
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
+		if ((long)__ret < 0) {                                   \
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

