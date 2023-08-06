Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0777153B
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjHFNTy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFNTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 09:19:53 -0400
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60794C2;
        Sun,  6 Aug 2023 06:19:48 -0700 (PDT)
X-QQ-mid: bizesmtp72t1691327963tr1qoydy
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 21:19:22 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: XBN7tc9DADJKBbB/ql4J8bBvYfS/azHKW14GrIV6vLK5ySQHWbnNnBacPvDLO
        ICwhImWR8bBZ1or77Lsl/kjVP8EFcLGvYdeJDKDif0vCa339U+RWYYTRYrNhZUQv33c3Lbg
        1BWBw1/MOWa63+wrTwizBYz5vTNFm3Fh9Bd6gomP82xMpocbreTrUiKL5GuQagQo9hotAK/
        6CTQJM2tZao5o6pRRPdyLlO1h0jE/EPxe6ofXiKZN+Q2trDR0MAlI/GI+UogqYJQ/4U0UOY
        LZopFgttnL463Y50MiCXRRYJDUa5ELgbZec4BUgAVaAnTIUyS3EYDh6LOruREFOdJpC9yIM
        CXwRV8BkzMIoe6UIbzE6SCufCDxpRQbytFtLwGHhExY2VaI3blmtWd8B1XWCBMcjVIFRI/h
        iz+NnCgRbyg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14233024139879409729
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: [PATCH] tools/nolibc: fix up size inflate regression
Date:   Sun,  6 Aug 2023 21:19:21 +0800
Message-Id: <20230806131921.52453-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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

Thirdly, fix up the following warning by an explicit conversion:

    sysroot/powerpc/include/sys.h: In function 'sbrk':
    sysroot/powerpc/include/sys.h:104:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      104 |         return (void *)__sysret(-ENOMEM);

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
Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/#R
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/compiler.h |  9 +++++++++
 tools/include/nolibc/sys.h      | 27 +++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index beddc3665d69..360dfc533814 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -22,4 +22,13 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* defined(__has_attribute) */
 
+/*
+ * from include/linux/compiler.h
+ *
+ * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
+ * bool and also pointer types.
+ */
+#define is_signed_type(type)   (((type)(-1)) < (type)1)
+#define is_unsigned_type(type) (!is_signed_type(type))
+
 #endif /* _NOLIBC_COMPILER_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 56f63eb48a1b..8271302f79c4 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -35,15 +35,22 @@
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
+#define __sysret(arg)                                                           \
+({                                                                              \
+	__typeof__(arg) __sysret_arg = (arg);                                   \
+	if (is_signed_type(__typeof__(arg))) {                                  \
+		if (__sysret_arg < 0) {                                         \
+			SET_ERRNO(-(int)__sysret_arg);                          \
+			__sysret_arg = -1L;                                     \
+		}                                                               \
+	} else {                                                                \
+		if ((unsigned long)__sysret_arg >= (unsigned long)-MAX_ERRNO) { \
+			SET_ERRNO(-(int)__sysret_arg);                          \
+			__sysret_arg = -1L;                                     \
+		}                                                               \
+	}                                                                       \
+	__sysret_arg;                                                           \
+})
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
@@ -94,7 +101,7 @@ void *sbrk(intptr_t inc)
 	if (ret && sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
 
-	return (void *)__sysret(-ENOMEM);
+	return (void *)__sysret((unsigned long)-ENOMEM);
 }
 
 
-- 
2.25.1

