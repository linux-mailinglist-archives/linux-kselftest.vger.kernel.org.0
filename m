Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5569249D26A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbiAZTUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 14:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiAZTUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 14:20:22 -0500
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jan 2022 11:20:21 PST
Received: from forward100p.mail.yandex.net (forward100p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C04C06161C;
        Wed, 26 Jan 2022 11:20:21 -0800 (PST)
Received: from sas8-f59b707a6213.qloud-c.yandex.net (sas8-f59b707a6213.qloud-c.yandex.net [IPv6:2a02:6b8:c1b:2988:0:640:f59b:707a])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id E23424F084E8;
        Wed, 26 Jan 2022 22:15:07 +0300 (MSK)
Received: from sas1-1f4a002bb12a.qloud-c.yandex.net (sas1-1f4a002bb12a.qloud-c.yandex.net [2a02:6b8:c14:3908:0:640:1f4a:2b])
        by sas8-f59b707a6213.qloud-c.yandex.net (mxback/Yandex) with ESMTP id OBXQNSJXHT-F7ceDiV4;
        Wed, 26 Jan 2022 22:15:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1643224507;
        bh=zLeZmkjXMX4QGgo+p8ULrLuMnXfwNEKNKqAejmSl4JA=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=FE/E9DkbiFchtfGTJo6E5X1aT4FmOFITOX7bHqo203nNKoriI3+qlA4ihs6nM5C71
         bb22j5jRk27jHZ4nsoIVPnAaHd2mAA7Hlpo8O+vVqa07q1M+4ipkuGdBcoluyCqUDw
         +mPUv6HuPmSEA+JPI4/c9eKjK+UTLda0U2dT398g=
Authentication-Results: sas8-f59b707a6213.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-1f4a002bb12a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id vdrU00sr04-F6IGOf7G;
        Wed, 26 Jan 2022 22:15:07 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Stas Sergeev <stsp2@yandex.ru>
Cc:     Stas Sergeev <stsp2@yandex.ru>, Shuah Khan <shuah@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: sigaltstack: add new SS_DISABLE test
Date:   Wed, 26 Jan 2022 22:14:41 +0300
Message-Id: <20220126191441.3380389-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126191441.3380389-1-stsp2@yandex.ru>
References: <20220126191441.3380389-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test makes sure that when SS_DISABLE is used, all other flags
are ignored.

Also remove unneeded exit()s after ksft_exit_fail_msg(). That function
exits by itself.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
CC: Shuah Khan <shuah@kernel.org>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: Borislav Petkov <bp@suse.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Len Brown <len.brown@intel.com>
CC: linux-kselftest@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/sigaltstack/sas.c | 48 ++++++++++++-----------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index c53b070755b6..7be377e84aa0 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -119,7 +119,7 @@ int main(void)
 	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
 
 	ksft_print_header();
-	ksft_set_plan(3);
+	ksft_set_plan(4);
 
 	sigemptyset(&act.sa_mask);
 	act.sa_flags = SA_ONSTACK | SA_SIGINFO;
@@ -129,24 +129,18 @@ int main(void)
 	sigaction(SIGUSR2, &act, NULL);
 	sstack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
-	if (sstack == MAP_FAILED) {
+	if (sstack == MAP_FAILED)
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
-		return EXIT_FAILURE;
-	}
 
 	err = sigaltstack(NULL, &stk);
-	if (err) {
+	if (err)
 		ksft_exit_fail_msg("sigaltstack() - %s\n", strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-	if (stk.ss_flags == SS_DISABLE) {
+	if (stk.ss_flags == SS_DISABLE)
 		ksft_test_result_pass(
 				"Initial sigaltstack state was SS_DISABLE\n");
-	} else {
+	else
 		ksft_exit_fail_msg("Initial sigaltstack state was %x; "
 		       "should have been SS_DISABLE\n", stk.ss_flags);
-		return EXIT_FAILURE;
-	}
 
 	stk.ss_sp = sstack;
 	stk.ss_size = stack_size;
@@ -167,16 +161,13 @@ int main(void)
 			ksft_exit_fail_msg(
 				"sigaltstack(SS_ONSTACK | SS_AUTODISARM)  %s\n",
 					strerror(errno));
-			return EXIT_FAILURE;
 		}
 	}
 
 	ustack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
-	if (ustack == MAP_FAILED) {
+	if (ustack == MAP_FAILED)
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
-		return EXIT_FAILURE;
-	}
 	getcontext(&uc);
 	uc.uc_link = NULL;
 	uc.uc_stack.ss_sp = ustack;
@@ -185,17 +176,28 @@ int main(void)
 	raise(SIGUSR1);
 
 	err = sigaltstack(NULL, &stk);
-	if (err) {
+	if (err)
 		ksft_exit_fail_msg("sigaltstack() - %s\n", strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-	if (stk.ss_flags != SS_AUTODISARM) {
-		ksft_exit_fail_msg("ss_flags=%x, should be SS_AUTODISARM\n",
+	if (stk.ss_flags != SS_AUTODISARM)
+		ksft_test_result_fail("ss_flags=%x, should be SS_AUTODISARM\n",
 				stk.ss_flags);
-		exit(EXIT_FAILURE);
-	}
-	ksft_test_result_pass(
+	else
+		ksft_test_result_pass(
 			"sigaltstack is still SS_AUTODISARM after signal\n");
+	/* We are done, disable SS and exit. */
+	stk.ss_flags = SS_DISABLE | SS_AUTODISARM;
+	err = sigaltstack(&stk, NULL);
+	if (err)
+		ksft_exit_fail_msg("sigaltstack() - %s\n", strerror(errno));
+	err = sigaltstack(NULL, &stk);
+	if (err)
+		ksft_exit_fail_msg("sigaltstack() - %s\n", strerror(errno));
+	if (stk.ss_flags != SS_DISABLE)
+		ksft_test_result_fail("ss_flags=%x, should be SS_DISABLE\n",
+				stk.ss_flags);
+	else
+		ksft_test_result_pass(
+			"sigaltstack disabled\n");
 
 	ksft_exit_pass();
 	return 0;
-- 
2.34.1

