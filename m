Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB69C520B9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiEJDEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 23:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiEJDEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 23:04:15 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD92878C4
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 20:00:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c13-20020a170903234d00b0015eee4c8ca3so5999923plh.6
        for <linux-kselftest@vger.kernel.org>; Mon, 09 May 2022 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DVOA1HWoo1xAq42eK94cnyQwLywIDvR1bD4VuJZi5js=;
        b=aeumVFAeovTeBq/VEg4tfDKCF6fMQ1t6TdeJRMNC9XG/pCoX4IKrBBUuBKC7essrdM
         xaQntmkvQauUlJzB30tqRxOBxi5H6dLwNHLJGngdDd6DsCIxqECmPSdFb1ogrYsIGfoM
         qHtLUDtdeVuJL6hj9Evd2QIKlCfYt3+CBsHD/ydwPp31U+6TbXJ3W3Q1P9h20lh+b+Pd
         dMvRmB1AbU9PG5NHV6k+LSt8C00ytOZHl4x8wgy6/v0LdP0KDfvzwuEZt+0wmZbyzVAB
         aYvyzXQeLhb1TRQB3ar28rLR4YqbGKxpNY29XGu8AVBd7T5g/fideFxVJMYo6VgrtBCl
         /yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DVOA1HWoo1xAq42eK94cnyQwLywIDvR1bD4VuJZi5js=;
        b=HrFcD7KRNuwANuNhR6/v7D0ubHnJTDXL61+W5+j/mjaGmoyaq5X/KrfVOmx1ivo8l8
         uAVXs77Ol0Gea1g2ymcVHjYdIe6P8CniBHlh6rmd5z7f1KMnEGG4yC5gxPz7DHGx5v0h
         vxRqTGDsq8mdC8TfS5lAkENCuV4G1YffTGRKv4R+RkR82w2+LXyvifsSSkSrweVeqcgZ
         +juNPwmepIa9BXaadVhnQsXU0XN/VT4EZPqbH7a0uD71Q3WRwGfX4rafBhdEjAowITea
         xAQvW1OzXFyTDZfai6eemdwgdW2qDTkyx47KAeRPef3OgAryDoEM0SQeuCresDEFIn+b
         mTXQ==
X-Gm-Message-State: AOAM533tkIXfGH0fAVyXyWQ4ydz8axFmBZd8d4es6hPUPjqWOkX4cWKn
        HEfgrHZWVKbQtJ+Uz4h4W1+Rfld70gM=
X-Google-Smtp-Source: ABdhPJwonbf0F08sh6730vpp1nM889khfj0HOKvD6Nl6PbNjOrRXYNoFe/OL7vCiBBCEWFm2QZ/mKO2DMts=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c861:f04:adab:761b])
 (user=surenb job=sendgmr) by 2002:a17:90a:930b:b0:1d5:684b:8e13 with SMTP id
 p11-20020a17090a930b00b001d5684b8e13mr21049188pjo.153.1652151619049; Mon, 09
 May 2022 20:00:19 -0700 (PDT)
Date:   Mon,  9 May 2022 20:00:12 -0700
Message-Id: <20220510030014.3842475-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 1/3] selftests: vm: add process_mrelease tests
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

Introduce process_mrelease syscall sanity tests. They include tests of
invalid pidfd and flags inputs, attempting to call process_mrelease
with a live process and a valid usage of process_mrelease. Because
process_mrelease has to be used against a process with a pending SIGKILL,
it's possible that the process exits before process_mrelease gets called.
In such cases we retry the test with a victim that allocates twice more
memory up to 1GB. This would require the victim process to spend more
time during exit and process_mrelease has a better chance of catching
the process before it exits.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/mrelease_test.c | 176 +++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
 3 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mrelease_test.c

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
index 000000000000..a61061bf8433
--- /dev/null
+++ b/tools/testing/selftests/vm/mrelease_test.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Google LLC
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "util.h"
+
+static inline int pidfd_open(pid_t pid, unsigned int flags)
+{
+#ifdef __NR_pidfd_open
+	return syscall(__NR_pidfd_open, pid, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+static inline int process_mrelease(int pidfd, unsigned int flags)
+{
+#ifdef __NR_process_mrelease
+	return syscall(__NR_process_mrelease, pidfd, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
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
+	int ppid = getppid();
+	void *buf;
+
+	buf = mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, 0, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+
+	write_fault_pages((char *)buf, nr_pages);
+
+	/* Signal the parent that the child is ready */
+	if (write(pipefd, "", 1) < 0) {
+		perror("write");
+		return 1;
+	}
+
+	/* Wait to be killed (when reparenting happens) */
+	while (getppid() == ppid)
+		sleep(1);
+
+	munmap(buf, nr_pages * PAGE_SIZE);
+
+	return 0;
+}
+
+
+#define MB(x) (x << 20)
+#define MAX_SIZE_MB 1024
+
+int main(void)
+{
+	int res;
+	int pipefd[2], pidfd;
+	pid_t pid;
+	char byte;
+	size_t size;
+	int negative_tests_done = 0;
+
+	/* Test a wrong pidfd */
+	if (!process_mrelease(-1, 0) || errno != EBADF) {
+		perror("process_mrelease with wring pidfd");
+		exit(1);
+	}
+
+	/*
+	 * Start the test with 1MB allocation and double every time
+	 * process_mrelease fails
+	 */
+	for (size = 1; size <= MAX_SIZE_MB; size *= 2) {
+		/*
+		 * Pipe for the child to signal when it's done allocating
+		 * memory
+		 */
+		if (pipe(pipefd)) {
+			perror("pipe");
+			exit(1);
+		}
+		pid = fork();
+		if (pid < 0) {
+			perror("fork");
+			exit(1);
+		}
+
+		if (pid == 0) {
+			close(pipefd[0]);
+			res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
+			close(pipefd[1]);
+			exit(res);
+		}
+
+		close(pipefd[1]);
+		/* Block until the child is ready */
+		res = read(pipefd[0], &byte, 1);
+		close(pipefd[0]);
+		if (res < 0) {
+			perror("read");
+			exit(1);
+		}
+
+		pidfd = pidfd_open(pid, 0);
+		if (pidfd < 0) {
+			perror("pidfd_open");
+			exit(1);
+		}
+
+		/* Run negative tests which require a valid child only once */
+		if (!negative_tests_done) {
+			/* Test invalid flags */
+			if (!process_mrelease(pidfd, (unsigned int)-1) ||
+			    errno != EINVAL) {
+				perror("process_mrelease with wrong flags");
+				exit(1);
+			}
+			/* Test reapling while process is still alive */
+			if (!process_mrelease(pidfd, 0) ||
+			    errno != EINVAL) {
+				perror("process_mrelease on a live process");
+				exit(1);
+			}
+			negative_tests_done = 1;
+		}
+
+		if (kill(pid, SIGKILL)) {
+			perror("kill");
+			exit(1);
+		}
+
+		if (!process_mrelease(pidfd, 0)) {
+			/* Terminate the test once process_mrelease succeeds */
+			return 0;
+		}
+
+		/*
+		 * Ignore the failure if the child exited before mrelease got
+		 * called, increase allocation size and retry the test
+		 */
+		if (errno != ESRCH) {
+			perror("process_mrelease");
+			exit(1);
+		}
+
+		if (waitpid(pid, NULL, 0) < 0) {
+			perror("waitpid");
+			exit(1);
+		}
+		close(pidfd);
+	}
+
+	printf("All process_mrelease attempts failed!\n");
+	exit(1);
+}
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
2.36.0.512.ge40c2bad7a-goog

