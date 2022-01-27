Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1C49ED64
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 22:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiA0VaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 16:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiA0VaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 16:30:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C64C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:30:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0ec4000000b00615dc8c1623so8409697ybs.17
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B95/GPrHL3ehKM8Rm7wgzd+5Hfg8Ho8he70Zk+Aj96g=;
        b=M5puYGiqOpDDdPdrv13u0tkUyLBdm15VQzzeJXFp1chap+jbhRRo7I0rcuDDzOxSjl
         3cL1m1qJNnLu9bKjOOptxas/2MITDJh5flskv42B0oepTyfabrKYJivvMGrjamvONs0o
         Qrp5dU++Y9TmLDmL1qqyxl2wXgca71IVhnAQvvQb48T9g4gG6YCElFD5FkRSnnJzLDvS
         xIEhtyAqcRpzfHhld5Bocs3GKyaFh5Vqx7Os2A0xBH2lm+GKomBuuLeSTJC2qf4A+AT0
         KV5fWQZ3ZSDQlIhD+C+2bjXZhTDzuRUY1yzudUK4UlrkmcAjFmoexk1kiQDNW+fKh5Jr
         wu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B95/GPrHL3ehKM8Rm7wgzd+5Hfg8Ho8he70Zk+Aj96g=;
        b=2BtYxZ5SNYEXV3r96v4xqfFodJPEZHBJlH2/RREKp/dRqIRHpkTi+XeF+CvPF0r6KY
         tl8wYQujSmKmPrGQJH9//jch6bb4AFUxYEj4FAzoXo5z5uVQcPtE9rnKBxWKJ0Q8jwpN
         bAEfIIDCNBuG8Ydx4q5XvMco6yU9MUq0WfLupjbGByDDQYsc5y84RdqUvsFeQX0zmacj
         dxv44YBTtPk8uJFPcjrkl4R7RegbNQzXFTKhdkmueUXVa3EHO17Ug0Z/PNLdtVZQYnEG
         0mi0q+/cOF8lkecpx1Fx5MED8zqAWHiXwo27ZGPx6G+WZHq/Uk4YEEylM7MRQPqP8bkr
         2TYw==
X-Gm-Message-State: AOAM531cenNKqxPsKa8N8/5bR3OZRJNycCf/YAgii5cVWHn7xktNaqDn
        z4Fi4sKM7CR0TCasekrdkrB9GL22M23RzOF3Uqb7
X-Google-Smtp-Source: ABdhPJz90vY8X1LcSRxAHAGv97T1CuywIIOQnBUF6s3pyOyCzGLxlxEu75zq+m942M4ZUYKJt/fKtHHa0YX0ApbvC3o+
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c864:1e56:28bc:526b])
 (user=axelrasmussen job=sendgmr) by 2002:a81:3dd7:: with SMTP id
 k206mr1ywa.56.1643319008177; Thu, 27 Jan 2022 13:30:08 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:29:51 -0800
Message-Id: <20220127212951.3604667-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] pidfd: fix test failure due to stack overflow on some arches
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running the pidfd_fdinfo_test on arm64, it fails for me. After some
digging, the reason is that the child exits due to SIGBUS, because it
overflows the 1024 byte stack we've reserved for it.

To fix the issue, increase the stack size to 8192 bytes (this number is
somewhat arbitrary, and was arrived at through experimentation -- I kept
doubling until the failure no longer occurred).

Also, let's make the issue easier to debug. wait_for_pid() returns an
ambiguous value: it may return -1 in all of these cases:

1. waitpid() itself returned -1
2. waitpid() returned success, but we found !WIFEXITED(status).
3. The child process exited, but it did so with a -1 exit code.

There's no way for the caller to tell the difference. So, at least log
which occurred, so the test runner can debug things.

While debugging this, I found that we had !WIFEXITED(), because the
child exited due to a signal. This seems like a reasonably common case,
so also print out whether or not we have WIFSIGNALED(), and the
associated WTERMSIG() (if any). This lets us see the SIGBUS I'm fixing
clearly when it occurs.

Finally, I'm suspicious of allocating the child's stack on our stack.
man clone(2) suggests that the correct way to do this is with mmap(),
and in particular by setting MAP_STACK. So, switch to doing it that way
instead.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/pidfd/pidfd.h         | 13 ++++++++---
 .../selftests/pidfd/pidfd_fdinfo_test.c       | 22 +++++++++++++++----
 2 files changed, 28 insertions(+), 7 deletions(-)

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
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

