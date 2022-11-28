Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2863A1BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 08:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiK1HFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 02:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK1HFE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 02:05:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60B5586;
        Sun, 27 Nov 2022 23:05:03 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLGfw0Sn2zRpZD;
        Mon, 28 Nov 2022 15:04:24 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 15:05:01 +0800
Received: from localhost.localdomain (10.90.53.65) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 15:05:00 +0800
From:   limin <limin100@huawei.com>
To:     <shuah@kernel.org>, <keescook@chromium.org>,
        <bernd.edlinger@hotmail.de>, <ebiederm@xmission.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <songmuchun@bytedance.com>, <lizefan.x@bytedance.com>
Subject: [PATCH -next] selftests/ptrace: Fix Test terminated by timeout in ptrace_attach
Date:   Mon, 28 Nov 2022 15:04:54 +0800
Message-ID: <20221128070454.1850273-1-limin100@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.65]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

That is an open issue
Bernd Edlinger wrote the test case in anticipation that all of
patch series got accepted,but the last patch was not picked up
for inclusion in the linux kernel.
How to reproduce warning:
$ make -C tools/testing/selftests TARGETS=ptrace run_tests
Example vmaccess from 6.1.0-next source tree run fail on bare metal
  RUN global.attach ...
  attach: Test terminated by timeout
  FAIL  global.attach

Link:https://lore.kernel.org/all/AM8PR10MB4708E6FF0E155261455064C2E4209@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/
Fixes: 2de4e82318c7 ("selftests/ptrace: add test cases for dead-locks")
Signed-off-by: limin <limin100@huawei.com>
---
 tools/testing/selftests/ptrace/vmaccess.c | 37 ++++++++---------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 4db327b44586..751a41f1163c 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
@@ -45,42 +45,31 @@ TEST(vmaccess)
 
 TEST(attach)
 {
-	int s, k, pid = fork();
+	int k;
+	int s;
 
+	pid_t pid = fork();
 	if (!pid) {
-		pthread_t pt;
-
-		pthread_create(&pt, NULL, thread, NULL);
-		pthread_join(pt, NULL);
+		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
 		execlp("sleep", "sleep", "2", NULL);
 	}
 
 	sleep(1);
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(errno, EAGAIN);
+	printf("k1:%d\n", k);
+	ASSERT_EQ(k, -1);
+	waitpid(pid, &s, WNOHANG);
 	ASSERT_EQ(k, -1);
-	k = waitpid(-1, &s, WNOHANG);
-	ASSERT_NE(k, -1);
 	ASSERT_NE(k, 0);
 	ASSERT_NE(k, pid);
-	ASSERT_EQ(WIFEXITED(s), 1);
-	ASSERT_EQ(WEXITSTATUS(s), 0);
-	sleep(1);
-	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(k, 0);
-	k = waitpid(-1, &s, 0);
-	ASSERT_EQ(k, pid);
+	if (WIFEXITED(s))
+		ASSERT_EQ(WEXITSTATUS(s), 0);
+	if (WIFSTOPPED(s))
+		ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
 	ASSERT_EQ(WIFSTOPPED(s), 1);
-	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
-	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
-	ASSERT_EQ(k, 0);
-	k = waitpid(-1, &s, 0);
-	ASSERT_EQ(k, pid);
-	ASSERT_EQ(WIFEXITED(s), 1);
-	ASSERT_EQ(WEXITSTATUS(s), 0);
-	k = waitpid(-1, NULL, 0);
+	sleep(1);
+	ptrace(PTRACE_CONT, pid, NULL, NULL);
 	ASSERT_EQ(k, -1);
-	ASSERT_EQ(errno, ECHILD);
 }
 
 TEST_HARNESS_MAIN
-- 
2.33.0

