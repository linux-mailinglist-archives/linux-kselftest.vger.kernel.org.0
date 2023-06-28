Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D217418A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjF1THI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 15:07:08 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:53345 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232160AbjF1THG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 15:07:06 -0400
X-QQ-mid: bizesmtp79t1687979217ti593xid
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 03:06:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: D2GZf6M6C/jblY5+ez24uRSJrc6onlFKbVGlqPu9gz4C5VaEsHfPYV/+NbYNT
        M1xzvZvpUGVdU4m30V11Y032mXFLtuUBz/mtlNUDT78V8fQ/lc5cTGseyv0F/f0q/eI4FDb
        B2FbUnR/M5UMRVoi8g9xzAxpolnLJoudK9vMmMuJQ7xcbx68I+AHVvjOFo7ArkDBmY72K17
        WpFiuGChYRn7DpN7ps7SrQCzwKzxAB0mOSMBUknzBEI0mP+u/OoB2NsfF4nMJXSIwPhcSgK
        uX/3Z74F0cX7AiF4lVQeTGYbg+K8doDPqbNQ/9SiL4iEP7soaPyeIgLaT2FvFSs8jnE9qSo
        Xd1YNJ9b6NQ4Od4okJQhNXhT4z0+qHgCdh0Nj/WbL1NR+KM2wI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18249731880678126887
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 11/11] tools/nolibc: s390: shrink _start with _start_c
Date:   Thu, 29 Jun 2023 03:06:44 +0800
Message-Id: <2a63942b938ce0f016f3411f7c0d4b0c0d512e74.1687976753.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687976753.git.falcon@tinylab.org>
References: <cover.1687976753.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-s390.h | 35 ++++----------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 5139e0e37e56..a28f94aa28ca 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -137,41 +137,14 @@
 	_arg1;									\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
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
+		"lgr	%r2, %r15\n"		/* initialize stack protector	*/
+		"aghi	%r15, -160\n"		/* allocate new stackframe	*/
+		"xc	0(8,%r15), 0(%r15)\n"	/* clear backchain		*/
+		"brasl	%r14, _start_c\n"	/* transfer to c runtime	*/
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

