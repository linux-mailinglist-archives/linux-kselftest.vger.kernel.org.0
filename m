Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CD20451D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgFWAQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 20:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731542AbgFWAP4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1lLIJ0cCWWPfmSXCSyECLoLdAvobJtTbw4S3xAekBQ=;
        b=EG1u6SPG0la5Htr3xl+HclMOyUEyhI+c4nBO4AuAocoEGKB7Ll3r7+8Kk6BqOnkMm6wk2Q
        QJNaSThlJdO3hFChY4RtJ+n7bJG2CJhQzhE+16vb9aJ9rqjIwtNa6cutUgkImPdHLbI4K5
        pqfGS9SzYZoOfLHKJ2FL4ERSdn/1u6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Ikyc-M39OL6VNejlDLltCA-1; Mon, 22 Jun 2020 20:15:51 -0400
X-MC-Unique: Ikyc-M39OL6VNejlDLltCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC76801503;
        Tue, 23 Jun 2020 00:15:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1F2C60BEC;
        Tue, 23 Jun 2020 00:15:49 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/6] selftests: breakpoints: do not use ksft_exit_skip after ksft_set_plan
Date:   Mon, 22 Jun 2020 20:15:44 -0400
Message-Id: <20200623001547.22255-4-pbonzini@redhat.com>
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
than planned.  Use ksft_test_result_skip for the individual tests.
The call in suspend() is fine, but ksft_set_plan should be after it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../breakpoints/step_after_suspend_test.c     | 45 +++++++++++--------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 983ee6182e25..2cf6f10ab7c4 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -47,7 +47,7 @@ void child(int cpu)
 	_exit(0);
 }
 
-bool run_test(int cpu)
+int run_test(int cpu)
 {
 	int status;
 	pid_t pid = fork();
@@ -55,7 +55,7 @@ bool run_test(int cpu)
 
 	if (pid < 0) {
 		ksft_print_msg("fork() failed: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (pid == 0)
 		child(cpu);
@@ -63,67 +63,68 @@ bool run_test(int cpu)
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
 		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (!WIFSTOPPED(status)) {
 		ksft_print_msg("child did not stop: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (WSTOPSIG(status) != SIGSTOP) {
 		ksft_print_msg("child did not stop with SIGSTOP: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	if (ptrace(PTRACE_SINGLESTEP, pid, NULL, NULL) < 0) {
 		if (errno == EIO) {
-			ksft_exit_skip(
+			ksft_print_msg(
 				"ptrace(PTRACE_SINGLESTEP) not supported on this architecture: %s\n",
 				strerror(errno));
+			return KSFT_SKIP;
 		}
 		ksft_print_msg("ptrace(PTRACE_SINGLESTEP) failed: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
 		ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (WIFEXITED(status)) {
 		ksft_print_msg("child did not single-step: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (!WIFSTOPPED(status)) {
 		ksft_print_msg("child did not stop: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (WSTOPSIG(status) != SIGTRAP) {
 		ksft_print_msg("child did not stop with SIGTRAP: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
 		ksft_print_msg("ptrace(PTRACE_CONT) failed: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
 		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (!WIFEXITED(status)) {
 		ksft_print_msg("child did not exit after PTRACE_CONT: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
-	return true;
+	return KSFT_PASS;
 }
 
 void suspend(void)
@@ -192,23 +193,29 @@ int main(int argc, char **argv)
 			continue;
 		tests++;
 	}
-	ksft_set_plan(tests);
 
 	if (do_suspend)
 		suspend();
 
+	ksft_set_plan(tests);
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
-		bool test_success;
+		int test_success;
 
 		if (!CPU_ISSET(cpu, &available_cpus))
 			continue;
 
 		test_success = run_test(cpu);
-		if (test_success) {
+		switch (test_success) {
+		case KSFT_PASS:
 			ksft_test_result_pass("CPU %d\n", cpu);
-		} else {
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("CPU %d\n", cpu);
+			break;
+		case KSFT_FAIL:
 			ksft_test_result_fail("CPU %d\n", cpu);
 			succeeded = false;
+			break;
 		}
 	}
 
-- 
2.26.2


