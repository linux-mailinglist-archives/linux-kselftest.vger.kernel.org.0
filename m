Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179957A94F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbiGSVr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbiGSVrL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:47:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB0FA64E1D;
        Tue, 19 Jul 2022 14:46:45 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj5Ag002589;
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
Subject: [PATCH 08/17] selftests/nolibc: exit with poweroff on success when getpid() == 1
Date:   Tue, 19 Jul 2022 23:44:40 +0200
Message-Id: <20220719214449.2520-10-w@1wt.eu>
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

The idea is to ease automated testing under qemu. If the test succeeds
while running as PID 1, indicating the system was booted with init=/test,
let's just power off so that qemu can exit with a successful code. In
other situations it will exit and provoke a panic, which may be caught
for example with CONFIG_PVPANIC.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index ab7c4cbdef9b..5f2173610d03 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -626,6 +626,20 @@ int main(int argc, char **argv, char **envp)
 	}
 
 	printf("Total number of errors: %d\n", ret);
+
+	if (getpid() == 1) {
+		/* we're running as init, there's no other process on the
+		 * system, thus likely started from a VM for a quick check.
+		 * Exiting will provoke a kernel panic that may be reported
+		 * as an error by Qemu or the hypervisor, while stopping
+		 * cleanly will often be reported as a success. This allows
+		 * to use the output of this program for bisecting kernels.
+		 */
+		printf("Leaving init with final status: %d\n", !!ret);
+		if (ret == 0)
+			reboot(LINUX_REBOOT_CMD_POWER_OFF);
+	}
+
 	printf("Exiting with status %d\n", !!ret);
 	return !!ret;
 }
-- 
2.17.5

