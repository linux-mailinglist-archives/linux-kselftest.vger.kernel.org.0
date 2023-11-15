Return-Path: <linux-kselftest+bounces-124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66457EBCD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 06:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B790A1C204F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2C7E;
	Wed, 15 Nov 2023 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C43C0F
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 05:45:10 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18561DB
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 21:45:07 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee365545ae16a5-d6e94;
	Wed, 15 Nov 2023 13:45:05 +0800 (CST)
X-RM-TRANSID:2ee365545ae16a5-d6e94
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea65545ae0a67-6b4e8;
	Wed, 15 Nov 2023 13:45:05 +0800 (CST)
X-RM-TRANSID:2eea65545ae0a67-6b4e8
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: cyphar@cyphar.com,
	zhujun2@cmss.chinamobile.com,
	dverkamp@chromium.org,
	keescook@chromium.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	jeffxu@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/memfd: fix a memleak
Date: Tue, 14 Nov 2023 21:45:03 -0800
Message-Id: <20231115054503.10403-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The memory allocated within a function should be released
before the function return,otherwise memleak will occur.

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/memfd/fuse_test.c  |  3 +++
 tools/testing/selftests/memfd/memfd_test.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index 93798c8c5d54..f302294a9001 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -205,6 +205,7 @@ static pid_t spawn_sealing_thread(void)
 	stack = malloc(STACK_SIZE);
 	if (!stack) {
 		printf("malloc(STACK_SIZE) failed: %m\n");
+		free(stack);
 		abort();
 	}
 
@@ -214,9 +215,11 @@ static pid_t spawn_sealing_thread(void)
 		    NULL);
 	if (pid < 0) {
 		printf("clone() failed: %m\n");
+		free(stack);
 		abort();
 	}
 
+	free(stack);
 	return pid;
 }
 
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 3df008677239..917ffc210723 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -658,15 +658,18 @@ static void mfd_assert_grow_write(int fd)
 	buf = malloc(mfd_def_size * 8);
 	if (!buf) {
 		printf("malloc(%zu) failed: %m\n", mfd_def_size * 8);
+		free(buf);
 		abort();
 	}
 
 	l = pwrite(fd, buf, mfd_def_size * 8, 0);
 	if (l != (mfd_def_size * 8)) {
 		printf("pwrite() failed: %m\n");
+		free(buf);
 		abort();
 	}
 
+	free(buf);
 	mfd_assert_size(fd, mfd_def_size * 8);
 }
 
@@ -682,14 +685,18 @@ static void mfd_fail_grow_write(int fd)
 	buf = malloc(mfd_def_size * 8);
 	if (!buf) {
 		printf("malloc(%zu) failed: %m\n", mfd_def_size * 8);
+		free(buf);
 		abort();
 	}
 
 	l = pwrite(fd, buf, mfd_def_size * 8, 0);
 	if (l == (mfd_def_size * 8)) {
 		printf("pwrite() didn't fail as expected\n");
+		free(buf);
 		abort();
 	}
+
+	free(buf);
 }
 
 static void mfd_assert_mode(int fd, int mode)
@@ -771,15 +778,18 @@ static pid_t spawn_thread(unsigned int flags, int (*fn)(void *), void *arg)
 	stack = malloc(STACK_SIZE);
 	if (!stack) {
 		printf("malloc(STACK_SIZE) failed: %m\n");
+		free(stack);
 		abort();
 	}
 
 	pid = clone(fn, stack + STACK_SIZE, SIGCHLD | flags, arg);
 	if (pid < 0) {
 		printf("clone() failed: %m\n");
+		free(stack);
 		abort();
 	}
 
+	free(stack);
 	return pid;
 }
 
-- 
2.17.1




