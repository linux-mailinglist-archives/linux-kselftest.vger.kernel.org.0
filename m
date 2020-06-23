Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24E3204517
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgFWAP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 20:15:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731534AbgFWAP4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkkQSPBNrpI2IxqYiVh2Iw1joFoBdbYBL6lvveSvkPc=;
        b=NAfAXsSVgJTdUPwELRiLw9W+5ETGfbtNr85nktt6zWZRtp0AI42J9BASqazs+2hJYMHeSD
        uPCPFDsk4dQIfhzBgD7n254xyks6xWly7/qAFW8FAF635rJPefhX0T6F39LvSg61cDSa+w
        /O2fXPXdVNcEiUhURz1SwQ/JvFbswi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-4kzhHYcoPZaa1qZAXt5OyA-1; Mon, 22 Jun 2020 20:15:52 -0400
X-MC-Unique: 4kzhHYcoPZaa1qZAXt5OyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F11AA464;
        Tue, 23 Jun 2020 00:15:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 833E060BEC;
        Tue, 23 Jun 2020 00:15:50 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
Date:   Mon, 22 Jun 2020 20:15:45 -0400
Message-Id: <20200623001547.22255-5-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
than planned.  Use ksft_test_result_skip instead.

The plan passed to ksft_set_plan was wrong, too, so fix it while at it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 39 ++++++++++++++++++----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7aff2d3b42c0..380c6314e6a2 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -8,6 +8,7 @@
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
@@ -27,6 +28,8 @@
 
 #define MAX_EVENTS 5
 
+static bool have_pidfd_send_signal = false;
+
 static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 {
 	size_t stack_size = 1024;
@@ -56,6 +59,13 @@ static int test_pidfd_send_signal_simple_success(void)
 	int pidfd, ret;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
 
+	if (!have_pidfd_send_signal) {
+		ksft_test_result_skip(
+			"%s test: pidfd_send_signal() syscall not supported\n",
+			test_name);
+		return 0;
+	}
+
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
@@ -86,6 +96,13 @@ static int test_pidfd_send_signal_exited_fail(void)
 	pid_t pid;
 	const char *test_name = "pidfd_send_signal signal exited process";
 
+	if (!have_pidfd_send_signal) {
+		ksft_test_result_skip(
+			"%s test: pidfd_send_signal() syscall not supported\n",
+			test_name);
+		return 0;
+	}
+
 	pid = fork();
 	if (pid < 0)
 		ksft_exit_fail_msg("%s test: Failed to create new process\n",
@@ -137,6 +154,13 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
 	pid_t pid1;
 	const char *test_name = "pidfd_send_signal signal recycled pid";
 
+	if (!have_pidfd_send_signal) {
+		ksft_test_result_skip(
+			"%s test: pidfd_send_signal() syscall not supported\n",
+			test_name);
+		return 0;
+	}
+
 	ret = unshare(CLONE_NEWPID);
 	if (ret < 0)
 		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
@@ -325,13 +349,16 @@ static int test_pidfd_send_signal_syscall_support(void)
 
 	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
 	if (ret < 0) {
-		if (errno == ENOSYS)
-			ksft_exit_skip(
+		if (errno == ENOSYS) {
+			ksft_test_result_skip(
 				"%s test: pidfd_send_signal() syscall not supported\n",
 				test_name);
-
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
-				   test_name);
+		} else {
+			ksft_exit_fail_msg("%s test: Failed to send signal\n",
+					   test_name);
+		}
+	} else {
+		have_pidfd_send_signal = true;
 	}
 
 	close(pidfd);
@@ -521,7 +548,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(4);
+	ksft_set_plan(8);
 
 	test_pidfd_poll_exec(0);
 	test_pidfd_poll_exec(1);
-- 
2.26.2


