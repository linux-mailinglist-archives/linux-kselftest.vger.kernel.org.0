Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F7750306
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjGLJ0g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGLJ0f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:26:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2CE139;
        Wed, 12 Jul 2023 02:26:33 -0700 (PDT)
X-QQ-mid: bizesmtp65t1689153983tfw3ppgx
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:26:22 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: J5JfekO1WsgRU4ygyCVjfG7z8UE8RA1iZUoq0kLH35rSYGgxoEMOUOGjZ5p1S
        EdO21pohjNWgfdEETq7vfqSMT1owM1Rdi71J+ZJmkdlGW/Zz7Jt3AGGIB+RqUQf4j5RjjKu
        eLb1toMwR1qyBM+Esohypdl02V/1Px26IX0V46DbxxPteDN9pkG7DD4HD1uMibcVipDMiZD
        KuVDwTCTzF5hoSD3L4JYMfAz2qMwXk3Gw/wA9yV4Dn3zLL/BtMg6s7QMqfS+Blz46X9Tzha
        G2XBXoqtkHyTf/2s5ehE+oBn/4VSqRAaangw7FZjoa7u+NswjcyWmHj12xiCIG5bfjlXokA
        ZJa70BSv2jwFF8eIFar5bHpaFvFdCRgsJjZWI24y7kwnZCpKwKCAPPobMppDeQoi+xoecy1
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17537015007484594219
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 10/11] tools/nolibc: s390: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:26:21 +0800
Message-Id: <fae6e54154d67e1dbec5f0ebc7958476a4ca1129.1689150149.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689150149.git.falcon@tinylab.org>
References: <cover.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-s390.h | 36 +++++---------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index a40424ba043e..051f3f4ed19b 100644
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
+		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _start_c */
+		"aghi	%r15, -160\n"         /* allocate new stackframe                        */
+		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                                */
+		"brasl	%r14, _start_c\n"     /* transfer to c runtime                          */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

