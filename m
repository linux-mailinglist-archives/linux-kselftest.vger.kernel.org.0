Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8E216A0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgGGKWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 06:22:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30556 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728178AbgGGKTr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 06:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594117184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKELPRFoxGgyuUZOafxvI9pIPETA/6J9z4Rn+7yuGzw=;
        b=MkAYUGXzhvl2FMEqQHyPQfkMYV9eO1SO8jGiNDVDFMN/5aJv1EJMeF2ucoNM+71HR9ZyYE
        PBjVPc8ZLg0Eys2IoY73unoCMd/YEwmW8ZGuoi3xZOYNCJVscJAvmeFYLe/kmwKxDUsHKz
        G37hxjp55hYhvAr07V6OxgZs+TfGisg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-zlBFzUn5Pmi-U7tEuLX47A-1; Tue, 07 Jul 2020 06:19:39 -0400
X-MC-Unique: zlBFzUn5Pmi-U7tEuLX47A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BB6D18A8221;
        Tue,  7 Jul 2020 10:19:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8CF4275E3E;
        Tue,  7 Jul 2020 10:19:37 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org
Subject: [PATCH v3 1/2] selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
Date:   Tue,  7 Jul 2020 06:19:35 -0400
Message-Id: <20200707101936.12052-2-pbonzini@redhat.com>
In-Reply-To: <20200707101936.12052-1-pbonzini@redhat.com>
References: <20200707101936.12052-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
than planned.  Use ksft_test_result_skip instead.

The plan passed to ksft_set_plan was wrong, too, so fix it while at it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200623001547.22255-5-pbonzini@redhat.com>
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


