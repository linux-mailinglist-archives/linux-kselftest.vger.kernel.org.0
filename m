Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2A773019
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 22:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjHGUEh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHGUEg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 16:04:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161DEB1;
        Mon,  7 Aug 2023 13:04:33 -0700 (PDT)
X-QQ-mid: bizesmtp91t1691438647t4zdb9ni
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 08 Aug 2023 04:04:06 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: 90EFqYDyPxD3+sLbshWU2U7dnyvuq1IbEuoeERgw34fSNjGR16yp5HBwQ+TSj
        9K6shDeVXkc2VkizJ0+TQnqGpqjn1nQWY0Qbqxq9XMvB5HnYFY42l5sdwEKSyCv5D/y6kjM
        euzoSJc2+4GP+gv78sqvd/6Xth+94Hm/cKzvA9pG2IHXZU0q0HCbKpHqEu4u73oPaWltHWD
        HPc2CDdN0G/9fQwMJXvrhYqyicxJ3Q0Fu8COTXlochfK4r4BFhN2qdifl4X+XPjfmH2WG7g
        N21d5LClAUEvCmkfg2LjfPfwOaJet5FteH9O2Z+ea4ZHuKNSnIp3NkKCTlyPOlC1F6/xklU
        ANJe6rj+zJV8u1FZl6SHnmoJtSEG+YRBDE7rIXW
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5223824127262790404
From:   Zhangjin Wu <falcon@tinylab.org>
To:     david.laight@aculab.com, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v5] tools/nolibc: fix up size inflate regression
Date:   Tue,  8 Aug 2023 04:04:05 +0800
Message-Id: <b6ff2684f557f6ce00151905990643e651391614.1691437328.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
__is_pointer() macro suggested by David Laight to limit the comparison
to -MAX_ERRNO (2) only for pointer returns and preserve a simple sign
comparison for integer returns as before. The __builtin_choose_expr()
is suggested by David Laight to choose different comparisons based on
the types to share code.

Thirdly, fix up the following warning by an explicit conversion and let
__sysret() be able to accept the (void *) type of argument:

    sysroot/powerpc/include/sys.h: In function 'sbrk':
    sysroot/powerpc/include/sys.h:104:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      104 |         return (void *)__sysret(-ENOMEM);

Fourthly, to further workaround the argument type with 'const' flag,
must use __auto_type for gcc >= 11.0 and __typeof__((arg) + 0) suggested
by David Laight for old gcc versions.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/
Link: https://lore.kernel.org/lkml/20230806134348.GA19145@1wt.eu/
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Link: https://lore.kernel.org/lkml/f51e54bcf470451ea36f24640f000e61@AcuMS.aculab.com/
Link: https://lore.kernel.org/lkml/a1732bbffd1542d3b9dd34c92f45076c@AcuMS.aculab.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---

Hi, Willy, Hi, David

v5 applies suggestions from David Laight, it further drops the fixed
'long' conversion branch by using a __typeof__((arg) + 0) trick and also
merges the pointer type and integer type comparisons with
__bultin_choose_expr() and a new __is_pointer() macro, now, the code is
cleaner than before versions.

David, Thanks a lot!

Like before, tests run for all nolibc supported boards.

Changes from v4 --> v5:

* Use __typeof__((arg) + 0) to lose the 'const' flag for old gcc
  versions.

* Import the famous __is_constexpr() macro from kernel side and add a
  __is_pointer() macro based on it. (David, to avoid introduce extra
  discuss on the prove-in-use __is_constexpr macro, this patch uses the
  original version instead of your suggested version, more info here:
  https://lore.kernel.org/lkml/20220131204357.1133674-1-keescook@chromium.org/)

* Use __builtin_choose_expr() to merge two comparisons to share the same
  errno setting code and the -1L assignment code.

Changes from v3 --> v4:

* fix up a new warning about 'ret < 0' when the input arg type is (void *)

Changes from v2 --> v3:

* define a __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT for gcc >= 11.0 (ABI_VERSION >= 1016)
* split __sysret() to two versions by the macro instead of a mixed unified and unreadable version
* use shorter __ret instead of __sysret_arg

Changes from v1 --> v2:

* fix up argument with 'const' in the type
* support "void *" argument

Best regards,
Zhangjin
---

v4: https://lore.kernel.org/lkml/a4084f7fac7a89f861b5582774bc7a98634d1e76.1691392805.git.falcon@tinylab.org/
v3: https://lore.kernel.org/lkml/8eaab5da2dcbba42e3f3efc2ae686a22c95f84f0.1691386601.git.falcon@tinylab.org/
v2: https://lore.kernel.org/lkml/95fe3e732f455fab653fe1427118d905e4d04257.1691339836.git.falcon@tinylab.org/
v1: https://lore.kernel.org/lkml/20230806131921.52453-1-falcon@tinylab.org/

---
 tools/include/nolibc/sys.h | 74 ++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 833d6c5e86dc..6bdd18716e84 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -27,23 +27,67 @@
 #include "errno.h"
 #include "types.h"
 
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ * (from include/linux/const.h)
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+/*
+ * "(void *)0 isn't 'constant enough' for is_constexpr() - so
+ * is_constexpr((type)0) can be used to detect pointer types."
+ * (from David Laight <David.Laight@ACULAB.COM>)
+ */
+#define __is_pointer(x) (!__is_constexpr((__typeof__(x))0))
 
-/* Syscall return helper for library routines, set errno as -ret when ret is in
- * range of [-MAX_ERRNO, -1]
+/*
+ * To preserve the input type and workaround the 'error: assignment of
+ * read-only variable' when the input type has 'const' flag.
+ *
+ * For gcc >= 11.0 (__GXX_ABI_VERSION = 1016), use the new __auto_type keyword
+ * instead of __typeof__().
  *
- * Note, No official reference states the errno range here aligns with musl
- * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
+ * For old gcc versions, "use typeof((x) + 0) to lose the 'const' flag. The
+ * only downside is that char/short become int." (from David Laight
+ * <David.Laight@ACULAB.COM>)
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
+#if __GXX_ABI_VERSION >= 1016
+#define __typeofdecl(arg) __auto_type
+#else
+#define __typeofdecl(arg) __typeof__((arg) + 0)
+#endif
+
+/* Syscall return helper for library routines
+ *
+ * - for pointer returns, set errno as -ret when ret is in [-MAX_ERRNO, -1]
+ * - for integer returns, set errno as -ret when ret < 0
+ *
+ * Note,
+ *
+ * - No official reference states the errno range, here aligns with musl
+ *   (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h).
+ *
+ * - To reduce binary size by removing useless type conversions and sign
+ *   extensions, the helper is defined as a macro to preserve input type and
+ *   provide two comparisons for both pointer and integer types during the
+ *   compiling stage.
+ */
+
+#define __sysret(arg)                                                                              \
+({                                                                                                 \
+	__typeofdecl(arg) __ret = (arg);                                                           \
+	if (__builtin_choose_expr(__is_pointer(arg), (unsigned long)-(MAX_ERRNO + 1), (long)__ret) \
+		< __builtin_choose_expr(__is_pointer(arg), (unsigned long)__ret, 0)) {             \
+		SET_ERRNO(-(long)__ret);                                                           \
+		__ret = (__typeof__(arg))-1L;                                                      \
+	}                                                                                          \
+	__ret;                                                                                     \
+})
+
 
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

