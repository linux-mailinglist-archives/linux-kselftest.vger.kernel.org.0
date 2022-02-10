Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66F24B16E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiBJU1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 15:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbiBJU1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 15:27:43 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFAFE
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 12:27:43 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d188so8884279iof.7
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=NzNvLrkSs3YqxRMnqPdQ4UfEJXA9/DD8nG9AuK5quGE=;
        b=QVV7CXuOkO9zBAjqnuZzRuaMF/BqO5lfw93aYNEF5KbWdUAWci9neIcVK9sMAxPIxZ
         x54p7YqlUtihjq1USASn1TOqIklOXz81TftVd4CrGeIVyhrw+pwDUvIx/rs7+KeJVr00
         /qkCZkSbNlhdiGlQhNaGUpwHY9VwoPJqQnmY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=NzNvLrkSs3YqxRMnqPdQ4UfEJXA9/DD8nG9AuK5quGE=;
        b=1sVGX5eUsFavreIc7yuq9BQal78uAE3QRFxYR+EOWF4dfRM/8zYeygxD1sXrVecp3V
         G+2ZsG9ExDaIN07ZSMv7RnssKd6x8Pk80sL8mLOF/rXmkpz4lSfTSJ50qGrIP+/STZIF
         LzPZquV1cuFjokCOLUCgfhHwlhmwiTLMobaRyXSKL5wzOtG0t4vZtWFIPDnBLnF735IP
         TH0bbweYxD5g/wdiUjdvt62/BOZrt4U5WuIqRNzp01K1FeLLgT9J+pvt1rYDH5F1CR3X
         YsbYeLwC4nqQkzI70tdDnhCLmfo4AQvqbC6rgVJ62svDL6lJz+aqD/oBn7ZqC0oVFxPO
         jVHw==
X-Gm-Message-State: AOAM530TEjVDqFJOmKmQQDepNtQf3jq9n+4EBg16K5BfyffYR0PCZ+D7
        WD+W8n65oYPyHXK0exkDp41g/GNK86Ec8g==
X-Google-Smtp-Source: ABdhPJxG32IFBHFVA9SO8KRp8vyxb7SZ62A/dy1WVyrB4J83iwVxNcSLQ/5+TlMe9817ISgsZiqeKw==
X-Received: by 2002:a05:6638:2645:: with SMTP id n5mr4302401jat.230.1644524862877;
        Thu, 10 Feb 2022 12:27:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b14sm4986163ilf.45.2022.02.10.12.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 12:27:42 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.17-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <30ab6598-a653-7c63-c8ee-728c780f47d3@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 13:27:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------854F92A65C897DD4F813626C"
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------854F92A65C897DD4F813626C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.17-rc4

This Kselftest fixes updated for Linux 5.17-rc4 consists of build and
run-time fixes to pidfd, clone3, and ir tests.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ec049891b2dc16591813eacaddc476b3d27c8c14:

   kselftest: Fix vdso_test_abi return status (2022-01-31 10:35:14 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc4

for you to fetch changes up to 183f80fd72db42c9cc483aa7a5e8e881355d0b03:

   selftests/ir: fix build with ancient kernel headers (2022-02-04 13:14:41 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.17-rc4

This Kselftest fixes updated for Linux 5.17-rc4 consists of build and
run-time fixes to pidfd, clone3, and ir tests.

----------------------------------------------------------------
Axel Rasmussen (2):
       pidfd: fix test failure due to stack overflow on some arches
       selftests: fixup build warnings in pidfd / clone3 tests

Sean Young (1):
       selftests/ir: fix build with ancient kernel headers

  tools/testing/selftests/clone3/clone3.c           |  2 --
  tools/testing/selftests/ir/ir_loopback.c          | 10 ++++++++++
  tools/testing/selftests/pidfd/pidfd.h             | 13 ++++++++++---
  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 22 ++++++++++++++++++----
  tools/testing/selftests/pidfd/pidfd_test.c        |  6 +++---
  tools/testing/selftests/pidfd/pidfd_wait.c        |  5 ++---
  6 files changed, 43 insertions(+), 15 deletions(-)
----------------------------------------------------------------

--------------854F92A65C897DD4F813626C
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.17-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.17-rc4.diff"

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 076cf4325f78..cd4582129c7d 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -126,8 +126,6 @@ static void test_clone3(uint64_t flags, size_t size, int expected,
 
 int main(int argc, char *argv[])
 {
-	pid_t pid;
-
 	uid_t uid = getuid();
 
 	ksft_print_header();
diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 06256c96df12..f4a15cbdd5ea 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -29,6 +29,16 @@
 #define SYSFS_PATH_MAX 256
 #define DNAME_PATH_MAX 256
 
+/*
+ * Support ancient lirc.h which does not have these values. Can be removed
+ * once RHEL 8 is no longer a relevant testing platform.
+ */
+#if RC_PROTO_MAX < 26
+#define RC_PROTO_RCMM12 24
+#define RC_PROTO_RCMM24 25
+#define RC_PROTO_RCMM32 26
+#endif
+
 static const struct {
 	enum rc_proto proto;
 	const char *name;
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 01f8d3c0cf2c..6922d6417e1c 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -68,7 +68,7 @@
 #define PIDFD_SKIP 3
 #define PIDFD_XFAIL 4
 
-int wait_for_pid(pid_t pid)
+static inline int wait_for_pid(pid_t pid)
 {
 	int status, ret;
 
@@ -78,13 +78,20 @@ int wait_for_pid(pid_t pid)
 		if (errno == EINTR)
 			goto again;
 
+		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
 		return -1;
 	}
 
-	if (!WIFEXITED(status))
+	if (!WIFEXITED(status)) {
+		ksft_print_msg(
+		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
+		       WIFSIGNALED(status), WTERMSIG(status));
 		return -1;
+	}
 
-	return WEXITSTATUS(status);
+	ret = WEXITSTATUS(status);
+	ksft_print_msg("waitpid WEXITSTATUS=%d\n", ret);
+	return ret;
 }
 
 static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 22558524f71c..3fd8e903118f 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <syscall.h>
 #include <sys/wait.h>
+#include <sys/mman.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
@@ -80,7 +81,10 @@ static inline int error_check(struct error *err, const char *test_name)
 	return err->code;
 }
 
+#define CHILD_STACK_SIZE 8192
+
 struct child {
+	char *stack;
 	pid_t pid;
 	int   fd;
 };
@@ -89,17 +93,22 @@ static struct child clone_newns(int (*fn)(void *), void *args,
 				struct error *err)
 {
 	static int flags = CLONE_PIDFD | CLONE_NEWPID | CLONE_NEWNS | SIGCHLD;
-	size_t stack_size = 1024;
-	char *stack[1024] = { 0 };
 	struct child ret;
 
 	if (!(flags & CLONE_NEWUSER) && geteuid() != 0)
 		flags |= CLONE_NEWUSER;
 
+	ret.stack = mmap(NULL, CHILD_STACK_SIZE, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (ret.stack == MAP_FAILED) {
+		error_set(err, -1, "mmap of stack failed (errno %d)", errno);
+		return ret;
+	}
+
 #ifdef __ia64__
-	ret.pid = __clone2(fn, stack, stack_size, flags, args, &ret.fd);
+	ret.pid = __clone2(fn, ret.stack, CHILD_STACK_SIZE, flags, args, &ret.fd);
 #else
-	ret.pid = clone(fn, stack + stack_size, flags, args, &ret.fd);
+	ret.pid = clone(fn, ret.stack + CHILD_STACK_SIZE, flags, args, &ret.fd);
 #endif
 
 	if (ret.pid < 0) {
@@ -129,6 +138,11 @@ static inline int child_join(struct child *child, struct error *err)
 	else if (r > 0)
 		error_set(err, r, "child %d reported: %d", child->pid, r);
 
+	if (munmap(child->stack, CHILD_STACK_SIZE)) {
+		error_set(err, -1, "munmap of child stack failed (errno %d)", errno);
+		r = -1;
+	}
+
 	return r;
 }
 
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 529eb700ac26..9a2d64901d59 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -441,7 +441,6 @@ static void test_pidfd_poll_exec(int use_waitpid)
 {
 	int pid, pidfd = 0;
 	int status, ret;
-	pthread_t t1;
 	time_t prog_start = time(NULL);
 	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
 
@@ -500,13 +499,14 @@ static int child_poll_leader_exit_test(void *args)
 	 */
 	*child_exit_secs = time(NULL);
 	syscall(SYS_exit, 0);
+	/* Never reached, but appeases compiler thinking we should return. */
+	exit(0);
 }
 
 static void test_pidfd_poll_leader_exit(int use_waitpid)
 {
 	int pid, pidfd = 0;
-	int status, ret;
-	time_t prog_start = time(NULL);
+	int status, ret = 0;
 	const char *test_name = "pidfd_poll check for premature notification on non-empty"
 				"group leader exit";
 
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index be2943f072f6..17999e082aa7 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -39,7 +39,7 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
 
 TEST(wait_simple)
 {
-	int pidfd = -1, status = 0;
+	int pidfd = -1;
 	pid_t parent_tid = -1;
 	struct clone_args args = {
 		.parent_tid = ptr_to_u64(&parent_tid),
@@ -47,7 +47,6 @@ TEST(wait_simple)
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
 		.exit_signal = SIGCHLD,
 	};
-	int ret;
 	pid_t pid;
 	siginfo_t info = {
 		.si_signo = 0,
@@ -88,7 +87,7 @@ TEST(wait_simple)
 
 TEST(wait_states)
 {
-	int pidfd = -1, status = 0;
+	int pidfd = -1;
 	pid_t parent_tid = -1;
 	struct clone_args args = {
 		.parent_tid = ptr_to_u64(&parent_tid),

--------------854F92A65C897DD4F813626C--
