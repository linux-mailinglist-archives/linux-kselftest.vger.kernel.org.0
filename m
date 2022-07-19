Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398DD57A92C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiGSVpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiGSVpT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:19 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 371111120;
        Tue, 19 Jul 2022 14:45:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj3pg002581;
        Tue, 19 Jul 2022 23:45:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 01/17] tools/nolibc: make argc 32-bit in riscv startup code
Date:   Tue, 19 Jul 2022 23:44:32 +0200
Message-Id: <20220719214449.2520-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "ld a0, 0(sp)" instruction doesn't build on RISCV32 because that
would load a 64-bit value into a 32-bit register. But argc 32-bit,
not 64, so we ought to use "lw" here. Tested on both RISCV32 and
RISCV64.

Cc: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-riscv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 95e2b7924925..ba04771cb3a3 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -190,7 +190,7 @@ __asm__ (".section .text\n"
     ".option norelax\n"
     "lla   gp, __global_pointer$\n"
     ".option pop\n"
-    "ld    a0, 0(sp)\n"          // argc (a0) was in the stack
+    "lw    a0, 0(sp)\n"          // argc (a0) was in the stack
     "add   a1, sp, "SZREG"\n"    // argv (a1) = sp
     "slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
     "add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
-- 
2.17.5

