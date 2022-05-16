Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA72D527EEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbiEPHzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbiEPHzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 03:55:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32B12DD5
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 00:55:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f8398e99dcso123788597b3.9
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nls1ipV7o0vzNb1ozLEmPzAs9CB/LFf/eWtp8VPOgXE=;
        b=J1yiqXWn6H7p8VLpM6YiXjAP9lSGbg7GUNoxaiBGUUsUViBJ7Lw8zjED+KxgNJ8Joc
         0BXbaW8wQRhhy8NXe7mFuZDIxDb2XIHyNqV7CFhZfOszLLzDWHIfF1cLJEEjLvc127gI
         t8e3Ul+dM/ctEYY66TOpUx1YZmPjhSO3oHCsCk19BwXceuKqvH2noERzOMywYPmAGNF2
         4i2oAMEz3Q82G874jn3G7z/EbltQFAFgBzV55JE0reQQrBV14rNCBHfERz8oYwk1YdfY
         x1BW/P/GhyAmiXbSUTh6Lw9KOBNSOKi4QW5oBKJGkOktbLNx8Ty1uYVM/GO6aWnLY2xA
         /TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nls1ipV7o0vzNb1ozLEmPzAs9CB/LFf/eWtp8VPOgXE=;
        b=2cGS9xIa/azjb39I6q2oq+ChGeBvwDYaYTmEg3wwRzkgCA22gVR++gLl859TxU9I1F
         SB9cBlh5zQU6G+xy1hVgMzyH8Ic+AmCmTPwWkQONomwncm4gtLkZjytTc2Z950VYt9FB
         C6jTbyZWULJqJP6d1+cnKGhdaJjBG6TpjTzpGDxc45ZK8BJ/AmCPTRGNfH/iAylksefU
         ftsR4a8wfTAPUXUtNSRYezzWCzWL3YaKJ6aHImsdt6VL6V6yNnPe1gS5KSITqtTGuT/9
         w8dx1oTb59U1UzzWEzmW2pfaMFnGbP8u/i/nS6smAKU84th3sdFm0TrE5orZU1c3myMm
         MRTg==
X-Gm-Message-State: AOAM532L0jnO8zrmLhSe4UJMIb15foRonIGscwtU802Lh+Ia0ou7er6I
        0ioogP49l/PoNcH8GRTeewdD29n24/s=
X-Google-Smtp-Source: ABdhPJwUxhjBsKTYGPRnVik+FciFSFVM9xgSMyKWD4cMJt3VGO1QYFvhM6Y6klcbT9DvWdU90S2muCFYfhY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:97b7:3e1e:26a3:690f])
 (user=surenb job=sendgmr) by 2002:a25:e093:0:b0:64d:6c85:6bc6 with SMTP id
 x141-20020a25e093000000b0064d6c856bc6mr8173741ybg.500.1652687744095; Mon, 16
 May 2022 00:55:44 -0700 (PDT)
Date:   Mon, 16 May 2022 00:55:38 -0700
Message-Id: <20220516075538.1276644-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
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
        autolearn=ham autolearn_force=no version=3.4.6
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
    Success reaping a child with 1MB of memory allocations

On failure the test reports the failure. Sample outputs:
    All process_mrelease attempts failed!
    process_mrelease: Invalid argument

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/mrelease_test.c | 214 +++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
 4 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mrelease_test.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index d7507f3c7c76..c019e53f24f9 100644
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
index 04a49e876a46..733fccbff0ef 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -43,6 +43,7 @@ TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += memfd_secret
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
+TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += on-fault-limit
diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/vm/mrelease_test.c
new file mode 100644
index 000000000000..99680676069b
--- /dev/null
+++ b/tools/testing/selftests/vm/mrelease_test.c
@@ -0,0 +1,214 @@
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
+#if defined(__NR_pidfd_open) && defined(__NR_process_mrelease)
+
+static inline int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static inline int process_mrelease(int pidfd, unsigned int flags)
+{
+	return syscall(__NR_process_mrelease, pidfd, flags);
+}
+
+static void write_fault_pages(char *addr, unsigned long nr_pages)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++)
+		*((unsigned long *)(addr + (i * PAGE_SIZE))) = i;
+}
+
+static int alloc_noexit(unsigned long nr_pages, int pipefd)
+{
+	int timeout = 10; /* 10sec timeout to get killed */
+	int ppid = getppid();
+	void *buf;
+
+	buf = mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, 0, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap failed, halting the test");
+		return KSFT_FAIL;
+	}
+
+	write_fault_pages((char *)buf, nr_pages);
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
+void run_negative_tests(int pidfd)
+{
+	/* Test invalid flags. Expect to fail with EINVAL error code. */
+	if (!process_mrelease(pidfd, (unsigned int)-1) || errno != EINVAL) {
+		perror("process_mrelease with wrong flags");
+		exit(KSFT_FAIL);
+	}
+	/*
+	 * Test reaping while process is alive with no pending SIGKILL.
+	 * Expect to fail with EINVAL error code.
+	 */
+	if (!process_mrelease(pidfd, 0) || errno != EINVAL) {
+		perror("process_mrelease on a live process");
+		exit(KSFT_FAIL);
+	}
+}
+
+#define MB(x) (x << 20)
+#define MAX_SIZE_MB 1024
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
+	if (!process_mrelease(-1, 0) || errno != EBADF) {
+		perror("process_mrelease with wrong pidfd");
+		exit(KSFT_FAIL);
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
+		/*
+		 * Child main routine:
+		 * Allocate and fault-in memory and wait to be killed
+		 */
+		close(pipefd[0]);
+		res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
+		close(pipefd[1]);
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
+	pidfd = pidfd_open(pid, 0);
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
+		exit(KSFT_FAIL);
+	}
+
+	success = (process_mrelease(pidfd, 0) == 0);
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
+			exit(KSFT_FAIL);
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
+
+#else /* defined(__NR_pidfd_open) && defined(__NR_process_mrelease) */
+
+int main(int argc, char *argv[])
+{
+	printf("skip: skipping process_mrelease test " \
+	       "(missing __NR_pidfd_open and/or __NR_process_mrelease)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* defined(__NR_pidfd_open) && defined(__NR_process_mrelease) */
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 352ba00cf26b..1986162fea39 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -287,6 +287,22 @@ else
 	echo "[PASS]"
 fi
 
+echo "---------------------"
+echo "running mrelease_test"
+echo "---------------------"
+./mrelease_test
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
 echo "-------------------"
 echo "running mremap_test"
 echo "-------------------"
-- 
2.36.0.550.gb090851708-goog

