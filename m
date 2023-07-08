Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3474BE44
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGHPjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGHPjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:39:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39524B8;
        Sat,  8 Jul 2023 08:39:03 -0700 (PDT)
X-QQ-mid: bizesmtp71t1688830733tbhmnxv4
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:38:52 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ILHsT53NKPj1pTbEW3cPZlkLOwrV+fGbJKEBPIc2JzMF7eUUvTSN4H7yOyRW/
        q6dpW6rJNwJNf6fmcyoIOQnxkgBR3KRPHTMICJC0Nn4SxSx1dsTKJM9saahEdexOS7Q4RP2
        AdpI0AOV2AnDC+HkYFWOI8R8GuGkUy4WN/taowligDlWKPNmCR3RebTa6KnFNI8qi302goO
        UzODrofo+Ge7Ow8LVLD2biPRl0ab1hJsTD60f/XnYKVh08+Bf1FlzFpGFcMS5ByfBSsNUgc
        GvN1FlIT3K8LZDaJAYIXdBereDfuOYXH4LwEEikTXV5bV159dtfc5CgRF/i+Im/KzVI/Tdw
        bKAUK9jk2e9N/zwm8TZayklWGlcXsTsQqrbgxQlbw3ehK21FFADWMfmGLA9Og==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13069921436544709072
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 12/12] tools/nolibc: s390/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:38:48 +0800
Message-Id: <7246cc6042073168817a6fe36d8ff3c0c508e684.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/s390/crt.h | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/tools/include/nolibc/s390/crt.h b/tools/include/nolibc/s390/crt.h
index 8580f615d525..e247b8a37475 100644
--- a/tools/include/nolibc/s390/crt.h
+++ b/tools/include/nolibc/s390/crt.h
@@ -10,34 +10,10 @@
 void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
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

