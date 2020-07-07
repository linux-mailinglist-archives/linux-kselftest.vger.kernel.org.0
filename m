Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7596821729C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgGGPjd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 11:39:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728232AbgGGPjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 11:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594136371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlOZSSxOOYz0pi2dPi4vceNaQebvzKF/tonJVsBBDWg=;
        b=X09FarlcoUILVFVEJ/gtGkhVQLxrKlTeIkRhkbR2w4SjDdTa9//VW6VvP5nOKmT8FkMds4
        PIPMkeSh9n/dnOAq2Nua8zZFubL3zpYuyfll3DdM7/gnripheyMr+0vIZ6lcoIp85vg03L
        Ls1XUcaJu27hKjj96h/qykeOweLimZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-WMjqKfuXOi-R8ZWqqFtPbQ-1; Tue, 07 Jul 2020 11:39:29 -0400
X-MC-Unique: WMjqKfuXOi-R8ZWqqFtPbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A976E80183C;
        Tue,  7 Jul 2020 15:39:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20D4D10013D7;
        Tue,  7 Jul 2020 15:39:28 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 1/2] selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
Date:   Tue,  7 Jul 2020 11:39:26 -0400
Message-Id: <20200707153927.12802-2-pbonzini@redhat.com>
In-Reply-To: <20200707153927.12802-1-pbonzini@redhat.com>
References: <20200707153927.12802-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
than planned.  Use ksft_test_result_skip instead.

The plan passed to ksft_set_plan was wrong, too, so fix it while at it.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 34 +++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7aff2d3b42c0..f65ad4e32353 100644
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
 
+static bool have_pidfd_send_signal;
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
@@ -325,15 +349,17 @@ static int test_pidfd_send_signal_syscall_support(void)
 
 	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
 	if (ret < 0) {
-		if (errno == ENOSYS)
-			ksft_exit_skip(
+		if (errno == ENOSYS) {
+			ksft_test_result_skip(
 				"%s test: pidfd_send_signal() syscall not supported\n",
 				test_name);
-
+			return 0;
+		}
 		ksft_exit_fail_msg("%s test: Failed to send signal\n",
 				   test_name);
 	}
 
+	have_pidfd_send_signal = true;
 	close(pidfd);
 	ksft_test_result_pass(
 		"%s test: pidfd_send_signal() syscall is supported. Tests can be executed\n",
@@ -521,7 +547,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(4);
+	ksft_set_plan(8);
 
 	test_pidfd_poll_exec(0);
 	test_pidfd_poll_exec(1);
-- 
2.26.2


