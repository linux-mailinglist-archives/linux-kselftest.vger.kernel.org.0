Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0C754AB7
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGOScc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOScb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:32:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C3128;
        Sat, 15 Jul 2023 11:32:29 -0700 (PDT)
X-QQ-mid: bizesmtp81t1689445940t49g9iqv
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:32:19 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: cbck7jzG4wYaptTQhwzZFthYKAzk5jPcBUHuTClY8xYh5acSDs8WuXVfLRvL+
        /avhl2UfJP/XzZsUK1omAOUr5CrMEao6kdRmxzPsY1s70sGqwxUZcPyk6zU9OKyczEwxiM6
        g3I132Lkvu/9eVk/zoMaY4pUcjAxwHJLUnLC2oiD1q3XcsC1M5VOFsY6f2brfAfzBZtGgLB
        1td7aXmrQvNBx9A+Ii+eRlhenUpi9SZPPaDjkc8DIdCReqVvFzbtqXYkDEtqK4e7fdACpzZ
        VwTUEB/fgbaj4B+bSPhYBnbIRIU3ll5m2A34dYZVWxw13GhL4rq2qqu7KgRkGXROuCwEYTU
        NVKbwR5vwz7MAdF1l+Yn8unvNpBFSBnQDgQoSSeUvK1F9wexsB8ikB0bQLoF/xDFTTuNZ3T
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18280837454231615752
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 14/18] tools/nolibc: s390: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:32:19 +0800
Message-Id: <2d87c72b6957f678944b858f6f1fc703cf18d5fa.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c(), include the
stackprotector initialization.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-s390.h | 36 +++++---------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 3b94ae0cb1d1..5d60fd43f883 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -9,6 +9,7 @@
 #include <asm/unistd.h>
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for s390:
  *   - registers are 64-bit
@@ -137,41 +138,14 @@
 	_arg1;								\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-		"lg	%r2,0(%r15)\n"		/* argument count */
-		"la	%r3,8(%r15)\n"		/* argument pointers */
-
-		"xgr	%r0,%r0\n"		/* r0 will be our NULL value */
-		/* search for envp */
-		"lgr	%r4,%r3\n"		/* start at argv */
-		"0:\n"
-		"clg	%r0,0(%r4)\n"		/* entry zero? */
-		"la	%r4,8(%r4)\n"		/* advance pointer */
-		"jnz	0b\n"			/* no -> test next pointer */
-						/* yes -> r4 now contains start of envp */
-		"larl	%r1,environ\n"
-		"stg	%r4,0(%r1)\n"
-
-		/* search for auxv */
-		"lgr	%r5,%r4\n"		/* start at envp */
-		"1:\n"
-		"clg	%r0,0(%r5)\n"		/* entry zero? */
-		"la	%r5,8(%r5)\n"		/* advance pointer */
-		"jnz	1b\n"			/* no -> test next pointer */
-		"larl	%r1,_auxv\n"		/* yes -> store value in _auxv */
-		"stg	%r5,0(%r1)\n"
-
-		"aghi	%r15,-160\n"		/* allocate new stackframe */
-		"xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
-		"brasl	%r14,main\n"		/* ret value of main is arg to exit */
-		"lghi	%r1,1\n"		/* __NR_exit */
-		"svc	0\n"
+		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _start_c */
+		"aghi	%r15, -160\n"         /* allocate new stackframe                        */
+		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                                */
+		"brasl	%r14, _start_c\n"     /* transfer to c runtime                          */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

