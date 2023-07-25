Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860237620D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjGYSBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjGYSBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 14:01:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCA2115;
        Tue, 25 Jul 2023 11:01:38 -0700 (PDT)
X-QQ-mid: bizesmtp62t1690308093t9wenc48
Received: from localhost.localdomain ( [42.242.128.198])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 02:01:32 +0800 (CST)
X-QQ-SSF: 01200000000000403000B00A0000000
X-QQ-FEAT: hoArX50alxGfKCqcoJrDpBOVNpOBAj8Euz2UJh6j3yf0pnrWIamc1qk6NJsZy
        ZPdG6F8iyNMtFTdqKUKL/Y80gyczqCycfftYBrPWMlKrVYIJUsBXBCwq4dUDN9P/gRGQ6MX
        5v25aVNj8TMCLPo2SaYhIll5Zlpo/tzxtqGCtW+EvmEfl+bowYQeHhK06ZkQGRojxoMsHfg
        MqDHWHmeJCKE0avHl7btJ2zcdw0ZpQYhMGYIfLkonv5xzILyLqC5SGFCNe5IWZOyxn6z4Po
        ldkvveqgISSqk/h/KcsH8ZmcYKQNEg/GrmvqFlrnIlsXP1TvwXRssxHReSNcT3OpPUS3rSb
        WI54hW64St4bxdwyT/GZd0Tt13b2WiJypbOQ+ol1nT5mO47I77QYh81YNn2RQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4769715897786675155
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH 2/2] selftests/nolibc: add testcase for pipe.
Date:   Tue, 25 Jul 2023 14:01:30 -0400
Message-Id: <160ddef0313e11085ee906144d6d9678b8156171.1690307717.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690307717.git.tanyuan@tinylab.org>
References: <cover.1690307717.git.tanyuan@tinylab.org>
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

Add a testcase of pipe that child process sends message to parent process.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..43ba2884fd1e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -767,6 +767,39 @@ int test_mmap_munmap(void)
 	return ret;
 }
 
+int test_pipe(void)
+{
+	int pipefd[2];
+	char buf[32];
+	pid_t pid;
+	char *msg = "hello, nolibc";
+
+	if (pipe(pipefd) == -1)
+		return 1;
+
+	pid = fork();
+
+	switch (pid) {
+	case -1:
+		return 1;
+
+	case 0:
+		close(pipefd[0]);
+		write(pipefd[1], msg, strlen(msg));
+		close(pipefd[1]);
+		exit(EXIT_SUCCESS);
+
+	default:
+		close(pipefd[1]);
+		read(pipefd[0], buf, 32);
+		close(pipefd[0]);
+		wait(NULL);
+
+		if (strcmp(buf, msg))
+			return 1;
+		return 0;
+	}
+}
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
@@ -851,6 +884,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
-- 
2.39.2

