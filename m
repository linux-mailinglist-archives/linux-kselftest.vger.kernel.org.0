Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589677161D
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHFQqm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 12:46:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68EAA;
        Sun,  6 Aug 2023 09:46:40 -0700 (PDT)
X-QQ-mid: bizesmtp80t1691340384tkhmz0x4
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 00:46:23 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: XBN7tc9DADLpWmDmi2gsNl7JvQU3ocDYarY5h+5hWukSr/P4x7ZhmnBjuZUSC
        V8oh+N330+lBQnkbjsPssDW+sMvv0pd6eJE3NkkylckHm1YLoHEbgOlJOKsFPOT3ZmbofV9
        8sDCWLjCq96KwXOW7tyJeNIIifqxUf2HAulWmd2O092WRKEQahBl/WeSTUqs6yaqGZk/Bhb
        Kfgn1vmbb0KA5D9RoAeg3Spl34TBqK4Ro4eg4End3oE9qkJibhCPAOYT6pw1yrAyHXz/2le
        v5khxFrip8zMFvxIzyytCOaAcio32Zu5mLBAs15huccjTxJGoE1aWe4dlllwW/sXCnGPSMR
        wf9acEaXspRsyeJm/n0YzI20InptrT/a+wLhAM6JsXGo1JIFJWbMT8TeLOB0Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11101439852272722352
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: [PATCH v2] tools/nolibc: fix up size inflate regression
Date:   Mon,  7 Aug 2023 00:46:22 +0800
Message-Id: <95fe3e732f455fab653fe1427118d905e4d04257.1691339836.git.falcon@tinylab.org>
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

v2 here is further fix up argument with 'const' in the type and also
support "void *" argument, v1 is [1].

Tested on many architectures (i386, x86_64, mips, ppc64) and gcc version
(from gcc 4.8-13.1.0), compiles well without any warning and errors and
also with smaller size.

[1]: https://lore.kernel.org/lkml/20230806131921.52453-1-falcon@tinylab.org/

---
 tools/include/nolibc/sys.h | 52 ++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 56f63eb48a1b..9c7448ae19e2 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -35,15 +35,45 @@
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
+ * the type, but __auto_type is a new feature from newer version and it only
+ * work with 'const' from gcc 11.0 (__GXX_ABI_VERSION = 1016)
+ * https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
+ */
+
+#if __GXX_ABI_VERSION < 1016
+#define __typeofdecl(arg) long
+#define __typeofconv1(arg) (long)
+#define __typeofconv2(arg) (long)
+#else
+#define __typeofdecl(arg) __auto_type
+#define __typeofconv1(arg)
+#define __typeofconv2(arg) (__typeof__(arg))
+#endif
+
+#define __sysret(arg)                                                           \
+({                                                                              \
+	__typeofdecl(arg) __sysret_arg = __typeofconv1(arg)(arg);               \
+	if (__is_signed_type(__typeof__(arg))) {                                \
+		if (__sysret_arg < 0) {                                         \
+			SET_ERRNO(-(long)__sysret_arg);                         \
+			__sysret_arg = __typeofconv2(arg)(-1L);                 \
+		}                                                               \
+	} else {                                                                \
+		if ((unsigned long)__sysret_arg >= (unsigned long)-MAX_ERRNO) { \
+			SET_ERRNO(-(long)__sysret_arg);                         \
+			__sysret_arg = __typeofconv2(arg)(-1L);                 \
+		}                                                               \
+	}                                                                       \
+	(__typeof__(arg))__sysret_arg;                                          \
+})
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
@@ -94,7 +124,7 @@ void *sbrk(intptr_t inc)
 	if (ret && sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
 
-	return (void *)__sysret(-ENOMEM);
+	return __sysret((void *)-ENOMEM);
 }
 
 
@@ -682,7 +712,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
+	return __sysret(sys_mmap(addr, length, prot, flags, fd, offset));
 }
 
 static __attribute__((unused))
-- 
2.25.1

