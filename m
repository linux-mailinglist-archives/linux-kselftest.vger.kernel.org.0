Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF99738483
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFUNKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjFUNKr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:10:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAEDE57;
        Wed, 21 Jun 2023 06:10:40 -0700 (PDT)
X-QQ-mid: bizesmtp63t1687353031t44bo3k3
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:10:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8TmJPct4lgjZrwR2r9ifUIlt/ooF/BX9SyZKu13GRvTyl9GsqTST
        ltdyYZfK1hcYTSw2PtZ2cSsrutXtqrrH3wICe4sQVBMsvsqOyuB7dI4iFpVmLBze724lXru
        MrCOhErIOZL0iMGraRvDTOwXKXNRwTHqMxbFxAhdcOzLAE6urkKcn7OFGyK5Rr/QQ3Gi+O5
        5uVcyN5zxpJheUWjJWBCHlUkqOfvA50eoBqaZecRtTDbFslq8WkE3qHczh1ezZ9Ioa7rK+/
        zlHkifVvPodX7TZRCtuN2tansc3KrcXZ2e3GtT/Qg0KVnKjHg2RyqIOXmQVwFyud1pA3NG+
        XiNPe3DkQHD4hboBT2grmvA4AP6LZE9fF+QyhfjfFvLMKAG6JLghvxFqZcoZw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6653536713406143944
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 12/17] selftests/nolibc: rename chmod_net to chmod_good
Date:   Wed, 21 Jun 2023 21:09:24 +0800
Message-Id: <f8aacdf071153f3166df9c565d5ebc04290f0b10.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
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

When CONFIG_NET is not enabled, there would be no /proc/self/net, let's
use /tmp/blah in such case and rename chmod_net to chmod_good.

This allows to test chmod_good with tmpfs even when procfs is not there.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8b587961e46a..eca0070151b6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -550,10 +550,22 @@ int run_syscall(int min, int max)
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
+	int has_tmpdir = 0;
+	char *tmpdir = NULL;
 
 	/* <has_proc> indicates whether or not /proc is mounted */
 	has_proc = stat("/proc", &stat_buf) == 0;
 
+	/* <has_tmpdir> indicates whether or not /tmp/blah is there */
+	if (stat("/proc/self/net", &stat_buf) == 0) {
+		tmpdir = "/proc/self/net";
+		has_tmpdir = 1;
+	} else if (stat("/tmp/.", &stat_buf) == 0) {
+		tmpdir = "/tmp/blah";
+		if (mkdir(tmpdir, 0755) == 0)
+			has_tmpdir = 1;
+	}
+
 	/* this will be used to skip certain tests that can't be run unprivileged */
 	is_root = geteuid() == 0;
 
@@ -582,7 +594,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
-		CASE_TEST(chmod_net);         EXPECT_SYSZR(has_proc, chmod("/proc/self/net", 0555)); break;
+		CASE_TEST(chmod_good);        EXPECT_SYSZR(has_tmpdir, chmod(tmpdir, 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(has_proc, chmod("/proc/self", 0555), -1, EPERM); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(has_proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(is_root, chroot("/")); break;
-- 
2.25.1


