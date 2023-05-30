Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872BC715CA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjE3LI7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE3LI5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:08:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB89115;
        Tue, 30 May 2023 04:08:51 -0700 (PDT)
X-QQ-mid: bizesmtp80t1685444926t3zkui9c
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 19:08:45 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3gelAiWP5RoGbm4vjCvwZfJGtFNG1quZBYLTu71sj9RkgohxK606
        a+q+BffDHTGq7hGQggq49Yc7b00q60k9Z0+rpko1hv5Qylsrh5Ru5dO7bo9KIloRo5ONmwQ
        GxwAFUFc1x9e2wF81rgdmybkUrKQU2849rW+NYEvCIxyaTAiLxdNDZOpLSFnXpfxH1KVTqA
        kWZIjSdm5YfAh46ijTIDBYTyYWqbWGo7WiVpC7CQnofDv7czmI4JoOidGAbFsd3/zSmwz2M
        FtPx6NDMyIuosDDfYQm61GFTCo77Rlg8fJ/j2ZP4WDsV+0lFlJ8ptgtuyJp1957ue6tLVJi
        LhH20tTwUUWtfUWeW8whrClc1ayhenyHlIvd/B9P/KKnGSV0gae3vPZ63kNu3sDlcC/m0Qm
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1574217579638465516
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 4/4] selftests/nolibc: add user-space efault restore test case
Date:   Tue, 30 May 2023 19:08:43 +0800
Message-Id: <69e9464e92fe8c60a421d6571a1139980103e8fd.1685443199.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685443199.git.falcon@tinylab.org>
References: <cover.1685443199.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

while the libc supports sigaction/sigsetjmp/siglongjump, it is able to
restore next test after an invalid data pointer access, add such a test
case for these libcs, otherwise, skip it.

With glibc/musl:

    29 efault_handler ! 11 SIGSEGV                                   [OK]

With current nolibc:

    29 efault_handler                                               [SKIPPED]

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 9f9a09529a4f..6b4ebe4be4d6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -248,6 +248,15 @@ static void register_trap_handler(void)
 	}
 }
 
+static int test_efault(void)
+{
+	char *addr = (void *)1;
+
+	*addr = 'a';
+
+	return -1;
+}
+
 #define has_user_space_efault() (1)
 #else
 #define record_test_context(idx, iteration, iterations) do { } while (0)
@@ -255,6 +264,7 @@ static void register_trap_handler(void)
 #define register_expect_trap(experr1, experr2) do { } while (0)
 #define register_trap_handler() do { } while (0)
 #define has_user_space_efault() (0)
+#define test_efault(addr) (-1)
 #endif
 
 static void putcharn(char c, size_t n)
@@ -690,6 +700,7 @@ int run_syscall(int min, int max)
 	struct stat stat_buf;
 	int euid0;
 	int proc;
+	int efault;
 	int test;
 	int tmp;
 	int ret = 0;
@@ -701,6 +712,9 @@ int run_syscall(int min, int max)
 	/* this will be used to skip certain tests that can't be run unprivileged */
 	euid0 = geteuid() == 0;
 
+	/* user-space efault handler support */
+	efault = has_user_space_efault();
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
 
@@ -737,6 +751,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup2_m1);           tmp = dup2(-1, 100); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(efault_handler);    EXPECT_SYSER(efault, test_efault(), -1, EFAULT); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
-- 
2.25.1

