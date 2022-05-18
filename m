Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1052C4B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 22:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbiERUnr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242762AbiERUnh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 16:43:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281FA8886
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 13:43:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fef32314f7so28615477b3.18
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CIr61HKlKWK8BgnDg7ZLMPTf6+BKTF/FV6epAVcSa/k=;
        b=oYScb9Tq2re7Q+570vAn+FAY8dEW4InJb7V4G9TlPme9NIh3kl07+hORXd26OP+Chm
         OevTtOQn+3PsbvIrUopd3zcgARQkqbwjk9KXW3IsJMVvFDBQDFoD/PGQpL3cbQ8QlOdz
         V6DTJvuRtqXPEZe792a+eemEvz4FdT9EA1CN7cc0CV1yjCOFqr2WkG1SJNXS08xTKatb
         +1WPUkJxRNzFuoGTcUlVWwvJyS16KxlSPB7mQbOQZlTb+8IqYBxi2f+Wc1bjUFDeQaFq
         HVztWTipQgBqjSOSLslEomu+FRtnfBD1C01yjYlIt2bQ2KlFCBPD1lxi2/b7W1c+lDSP
         qdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CIr61HKlKWK8BgnDg7ZLMPTf6+BKTF/FV6epAVcSa/k=;
        b=YoF0hEpSgwf2uPWCFzSqTJ8YWOzdTjTPE5aSRpXnje71kpuSK4zeeZYBa8a2JDXdKa
         42FtpcMPl68z5vqs6FgIlV9sxadpQn4C71t7kV6DaLi+K41wgGvg5s8Ftbcs0au3aKow
         9eOGOyA+YJpRbNeSAOaIMtV/yn6loVH6WCuHiTddByIcE4ahVxKOl7NdMZNbUvntmC+G
         IOEEydLZ4IwurRwefsiyJ2upIgsxmDFUtyGndC/fme1SXP7SMIzJ351gaN/YDFGbFkTt
         wYM2MeIa0qbnpNizt6MWZsYK5Ph7LV2bjCTv+LCMxAQZh0LfMuGmimax0Rh0lPZbgWvn
         Fmgg==
X-Gm-Message-State: AOAM533WRbzHhqbUGLoakdlzlUBEj5kR+TYCfpd93+H9bHFqVmyIs6Bv
        un1UjLbBhXS/8xAPIi7Ek3WqaM6Y3gk=
X-Google-Smtp-Source: ABdhPJzvX2KiGyXAwjO6xhBeIGYYfuEyPPUX/l1T4qTDcZeTAgBeusLO2vb0AjO9Q+gvfXqbEha7rFhNHoo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:88b3:2be3:5f71:58e2])
 (user=surenb job=sendgmr) by 2002:a25:d312:0:b0:64d:74b9:5caa with SMTP id
 e18-20020a25d312000000b0064d74b95caamr1476152ybf.37.1652906600500; Wed, 18
 May 2022 13:43:20 -0700 (PDT)
Date:   Wed, 18 May 2022 13:43:16 -0700
Message-Id: <20220518204316.13131-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v3 1/1] selftests: vm: add process_mrelease tests
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce process_mrelease syscall sanity tests which include tests
which expect to fail:
- process_mrelease with invalid pidfd and flags inputs
- process_mrelease on a live process with no pending signals
and valid process_mrelease usage which is expected to succeed.
Because process_mrelease has to be used against a process with a pending
SIGKILL, it's possible that the process exits before process_mrelease
gets called. In such cases we retry the test with a victim that allocates
twice more memory up to 1GB. This would require the victim process to
spend more time during exit and process_mrelease has a better chance of
catching the process before it exits and succeeding.

On success the test reports the amount of memory the child had to
allocate for reaping to succeed. Sample output:

$ mrelease_test
Success reaping a child with 1MB of memory allocations

On failure the test reports the failure. Sample outputs:

$ mrelease_test
All process_mrelease attempts failed!

$ mrelease_test
process_mrelease: Invalid argument

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes in v3:
- Applied on git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-stable,
per Andrew
- Fixed formatting for sample outputs in the description, per Shuah
- Removed pidfd_open, process_mrelease, write_fault_pages functions, per Shuah
- Moved child main routine into its own function, per Shuah
- Followed tools/testing/selftests/pidfd/pidfd.h as a model to deal with
undefined syscall numbers, per Shuah

 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/mrelease_test.c | 200 +++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh  |   2 +
 4 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mrelease_test.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 3cb4fa771ec2..6c2ac4208c27 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -10,6 +10,7 @@ map_populate
 thuge-gen
 compaction_test
 mlock2-tests
+mrelease_test
 mremap_dontunmap
 mremap_test
 on-fault-limit
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index f1228370e99b..8111a33e4824 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -44,6 +44,7 @@ TEST_GEN_FILES += memfd_secret
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
+TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += on-fault-limit
diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/vm/mrelease_test.c
new file mode 100644
index 000000000000..96671c2f7d48
--- /dev/null
+++ b/tools/testing/selftests/vm/mrelease_test.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Google LLC
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "util.h"
+
+#include "../kselftest.h"
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open -1
+#endif
+
+#ifndef __NR_process_mrelease
+#define __NR_process_mrelease -1
+#endif
+
+#define MB(x) (x << 20)
+#define MAX_SIZE_MB 1024
+
+static int alloc_noexit(unsigned long nr_pages, int pipefd)
+{
+	int ppid = getppid();
+	int timeout = 10; /* 10sec timeout to get killed */
+	unsigned long i;
+	char *buf;
+
+	buf = (char *)mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANON, 0, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap failed, halting the test");
+		return KSFT_FAIL;
+	}
+
+	for (i = 0; i < nr_pages; i++)
+		*((unsigned long *)(buf + (i * PAGE_SIZE))) = i;
+
+	/* Signal the parent that the child is ready */
+	if (write(pipefd, "", 1) < 0) {
+		perror("write");
+		return KSFT_FAIL;
+	}
+
+	/* Wait to be killed (when reparenting happens) */
+	while (getppid() == ppid && timeout > 0) {
+		sleep(1);
+		timeout--;
+	}
+
+	munmap(buf, nr_pages * PAGE_SIZE);
+
+	return (timeout > 0) ? KSFT_PASS : KSFT_FAIL;
+}
+
+/* The process_mrelease calls in this test are expected to fail */
+static void run_negative_tests(int pidfd)
+{
+	/* Test invalid flags. Expect to fail with EINVAL error code. */
+	if (!syscall(__NR_process_mrelease, pidfd, (unsigned int)-1) ||
+			errno != EINVAL) {
+		perror("process_mrelease with wrong flags");
+		exit(errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
+	}
+	/*
+	 * Test reaping while process is alive with no pending SIGKILL.
+	 * Expect to fail with EINVAL error code.
+	 */
+	if (!syscall(__NR_process_mrelease, pidfd, 0) || errno != EINVAL) {
+		perror("process_mrelease on a live process");
+		exit(errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
+	}
+}
+
+static int child_main(int pipefd[], size_t size)
+{
+	int res;
+
+	/* Allocate and fault-in memory and wait to be killed */
+	close(pipefd[0]);
+	res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
+	close(pipefd[1]);
+	return res;
+}
+
+int main(void)
+{
+	int pipefd[2], pidfd;
+	bool success, retry;
+	size_t size;
+	pid_t pid;
+	char byte;
+	int res;
+
+	/* Test a wrong pidfd */
+	if (!syscall(__NR_process_mrelease, -1, 0) || errno != EBADF) {
+		perror("process_mrelease with wrong pidfd");
+		exit(errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
+	}
+
+	/* Start the test with 1MB child memory allocation */
+	size = 1;
+retry:
+	/*
+	 * Pipe for the child to signal when it's done allocating
+	 * memory
+	 */
+	if (pipe(pipefd)) {
+		perror("pipe");
+		exit(KSFT_FAIL);
+	}
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		close(pipefd[0]);
+		close(pipefd[1]);
+		exit(KSFT_FAIL);
+	}
+
+	if (pid == 0) {
+		/* Child main routine */
+		res = child_main(pipefd, size);
+		exit(res);
+	}
+
+	/*
+	 * Parent main routine:
+	 * Wait for the child to finish allocations, then kill and reap
+	 */
+	close(pipefd[1]);
+	/* Block until the child is ready */
+	res = read(pipefd[0], &byte, 1);
+	close(pipefd[0]);
+	if (res < 0) {
+		perror("read");
+		if (!kill(pid, SIGKILL))
+			waitpid(pid, NULL, 0);
+		exit(KSFT_FAIL);
+	}
+
+	pidfd = syscall(__NR_pidfd_open, pid, 0);
+	if (pidfd < 0) {
+		perror("pidfd_open");
+		if (!kill(pid, SIGKILL))
+			waitpid(pid, NULL, 0);
+		exit(KSFT_FAIL);
+	}
+
+	/* Run negative tests which require a live child */
+	run_negative_tests(pidfd);
+
+	if (kill(pid, SIGKILL)) {
+		perror("kill");
+		exit(errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
+	}
+
+	success = (syscall(__NR_process_mrelease, pidfd, 0) == 0);
+	if (!success) {
+		/*
+		 * If we failed to reap because the child exited too soon,
+		 * before we could call process_mrelease. Double child's memory
+		 * which causes it to spend more time on cleanup and increases
+		 * our chances of reaping its memory before it exits.
+		 * Retry until we succeed or reach MAX_SIZE_MB.
+		 */
+		if (errno == ESRCH) {
+			retry = (size <= MAX_SIZE_MB);
+		} else {
+			perror("process_mrelease");
+			waitpid(pid, NULL, 0);
+			exit(errno == ENOSYS ? KSFT_SKIP : KSFT_FAIL);
+		}
+	}
+
+	/* Cleanup to prevent zombies */
+	if (waitpid(pid, NULL, 0) < 0) {
+		perror("waitpid");
+		exit(KSFT_FAIL);
+	}
+	close(pidfd);
+
+	if (!success) {
+		if (retry) {
+			size *= 2;
+			goto retry;
+		}
+		printf("All process_mrelease attempts failed!\n");
+		exit(KSFT_FAIL);
+	}
+
+	printf("Success reaping a child with %zuMB of memory allocations\n",
+	       size);
+	return KSFT_PASS;
+}
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index a2302b5faaf2..41fce8bea929 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -141,6 +141,8 @@ run_test ./mlock-random-test
 
 run_test ./mlock2-tests
 
+run_test ./mrelease_test
+
 run_test ./mremap_test
 
 run_test ./thuge-gen
-- 
2.36.1.124.g0e6072fb45-goog

