Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2794557A94B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbiGSVrB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240343AbiGSVql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:46:41 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 067F862A54;
        Tue, 19 Jul 2022 14:46:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj5OT002590;
        Tue, 19 Jul 2022 23:45:05 +0200
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
Subject: [PATCH 09/17] selftests/nolibc: on x86, support exiting with isa-debug-exit
Date:   Tue, 19 Jul 2022 23:44:41 +0200
Message-Id: <20220719214449.2520-11-w@1wt.eu>
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

QEMU, when started with "-device isa-debug-exit -no-reboot" will exit
with status code 2N+1 when N is written to 0x501. This is particularly
convenient for automated tests but this is not portable. As such we
only enable this on x86_64 when pid==1. In addition, this requires an
ioperm() call but in order not to have to define arch-specific syscalls
we just perform the syscall by hand there.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 5f2173610d03..45793b6f2244 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -638,6 +638,15 @@ int main(int argc, char **argv, char **envp)
 		printf("Leaving init with final status: %d\n", !!ret);
 		if (ret == 0)
 			reboot(LINUX_REBOOT_CMD_POWER_OFF);
+#if defined(__x86_64__)
+		/* QEMU started with "-device isa-debug-exit -no-reboot" will
+		 * exit with status code 2N+1 when N is written to 0x501. We
+		 * hard-code the syscall here as it's arch-dependent.
+		 */
+		else if (my_syscall3(__NR_ioperm, 0x501, 1, 1) == 0)
+			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
+		/* if it does nothing, fall back to the regular panic */
+#endif
 	}
 
 	printf("Exiting with status %d\n", !!ret);
-- 
2.17.5

