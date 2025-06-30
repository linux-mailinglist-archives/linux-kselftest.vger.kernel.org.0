Return-Path: <linux-kselftest+bounces-36104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCAAEE037
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 16:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423F93AAAB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD128BAA9;
	Mon, 30 Jun 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnO1DknL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F3217F29;
	Mon, 30 Jun 2025 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292619; cv=none; b=gpeUJ2XA+PZj6YssdybssRbgTXJHFafTbJhC7tn7tWsGjbVcbY8k5XDAqibG/JXA17qB8ebVZn5svX7axcjJVoqx2pmFTKjCUOci7q42x8jueyXk+dfwx4qiiE2oYeYpagZpQC6C9V+gxQkjvsfH3/fKzl4n4kNJeLHZobOm0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292619; c=relaxed/simple;
	bh=5tKaFFcXoZbtpZmLS+7PNGxDUW8DmVmZp33P/mhplWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXcEFTaHKOf2PeVSAsQIuLV20iS5hVCxCphUidE4VZ2LX+AgXHTw6h4qv9VW6EuCOM+sEfoAO8qCYBYqPbQmveHpdyFiNaK7nehrr/mgUC1enDeVkJ77fJVoB+5XcO4w2NPrh0JRd9Ysf+6/DaHGqOrP6Ybm8oxVgKew5ZDzj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnO1DknL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so4234429a91.1;
        Mon, 30 Jun 2025 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751292616; x=1751897416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=154As7BmSiUbALBUZN0p0GtUn9ct/952i1U7ZlcCLn8=;
        b=HnO1DknLfGpsMnW7BEI31/k+cxO5JgNRcS8Ifz2DGFKgmfFz9V5c1Mn/xj2y2CMt5I
         hr+5rsTKCjmd/ni7gIkWNrCOcHZ4eQlEe4fBnSFkoqoibIl4zVnSO0qVPZWliLQrs1Yo
         orqweYkhHN8rzvhrm0gmjJ928XDkM6RZu+umUu1KSasTO86O7bhQlfWnDLg03zp6dG5y
         2DYrwMq7NgECCQuikxRl9MsdQcFQP8paUfFetNArZfc2KwHcgcqk/5IUXcBxlyRMjAv8
         fQssDeqTDouH35iUe7tkfiQjsucSrrNKIKuestBRmDk5KPsZXE7MdUMr1fTt7WgATv+r
         6tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751292616; x=1751897416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=154As7BmSiUbALBUZN0p0GtUn9ct/952i1U7ZlcCLn8=;
        b=fwocQHb2X4vKqfx81MlYUfoIqYclYDS4WN+/xrBXFXLuqutjYOgljgQLKegWAV5vk6
         jY2cogLFUo0GjMNlXRmWrBsuNbWJ+IvVKQWW7ZgO+1i9GFcO0QGYA8eoguwK/IFdwFCu
         4X0ng48epKpOT6AZfvxnSs38Zr7+p5C/ixFgLLHf0RaBmxBv/Y5OUbvOHUBQAOZFmUCt
         SDduJr3Rn6eMaJG7LRlD+tA2hpyYAqlZjzWxKAE9CIJriQ64OasZKH6hpDjWNaZdToqI
         dkfAYFHD1UdUncBqVGJg8nZGQLPybjTfyedNqFpQSKq9qx9ftFZJCzBfS9jeiqaj4i9d
         qkwA==
X-Forwarded-Encrypted: i=1; AJvYcCUPuR73lU4QLkKewafhrg/xHxSAMtCyu5fMgxBcATPqKBTRZTSfyD1vMLIz0lAYryosLljLPjIesQBl6W0=@vger.kernel.org, AJvYcCXp3jLq6+3ao2v4IcbRaSwql9aRlOVMhsXz/GpUzQB3Po1Hyr9rr63WO5b5vsfZcwtcuodeVYXdkfKfhQWq4NLd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5/mYykcWbHsnohkqPZzfYZtv/YC77MTXHOqe1ZYljjDwaNvY
	djhnIRIXHmwWTyksP3Lr4QaqxBUKrjEW7uOpxoApZq7CDkOLDqfpDaO5
X-Gm-Gg: ASbGnctBItA8etDijKQd9It0gpq1yOyQzHLaPoqu9ABvgKBO4Pf+x05iqOVIXT4Xfdf
	Kl1Cv0doT2//xI/9wzAyoBWoGq8L/jvGebL/jBkutsNnAQRh9Ns9UpVnbLpG3CuciZb6AvzdWLm
	8nw7+y0rsURC3UfWwd4Fopr6bzJexKjINIdjT3BfPxCYxd8U5QAD1oqiMNyWu2tLMIYrkpbAV3z
	A8etWUh/a/WNu20l2bOqL7Svra5YqDwHgOLJ/ek7Q6cLoUdQDiZ48NuJNir3G/pQUt2GzqMH2dr
	Y2TqU5OZdxEAmxxcMikH2k8lZwyT9Le8oXWaJphbMkCkja4hBQMIMQ1Fy4+0iHZlD8EQdtE9Q3M
	u+aL8XsI=
X-Google-Smtp-Source: AGHT+IFwKYvLFuriop4wZWaL2oIKvCI+fhmxEl3/Lyg8JmXkpXEoz7SyBFFu8nXx13dxuc64yHQjXw==
X-Received: by 2002:a17:90b:1c09:b0:311:c1ec:7d05 with SMTP id 98e67ed59e1d1-318c93274fdmr19365892a91.35.1751292616189;
        Mon, 30 Jun 2025 07:10:16 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([223.104.40.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f543791dsm13899096a91.36.2025.06.30.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:10:15 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: david@redhat.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Cc: lianux.mm@gmail.com,
	Liam.Howlett@oracle.com,
	brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: [PATCH v2] selftests/mm: Add process_madvise() tests
Date: Mon, 30 Jun 2025 22:09:57 +0800
Message-ID: <20250630140957.4000-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds tests for the process_madvise(), focusing on
verifying behavior under various conditions including valid
usage and error cases.

Signed-off-by: wang lian<lianux.mm@gmail.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---

Changelog v2:
- Drop MADV_DONTNEED tests based on feedback
- Focus solely on process_madvise() syscall
- Improve error handling and structure
- Add future-proof flag test
- Style and comment cleanups

 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   1 +
 tools/testing/selftests/mm/process_madv.c | 414 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   5 +
 4 files changed, 421 insertions(+)
 create mode 100644 tools/testing/selftests/mm/process_madv.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 911f39d634be..a8c3be02188c 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -42,6 +42,7 @@ memfd_secret
 hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
+process_madv
 soft-dirty
 split_huge_page_test
 ksm_tests
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 2352252f3914..725612e09582 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -86,6 +86,7 @@ TEST_GEN_FILES += mseal_test
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += pfnmap
+TEST_GEN_FILES += process_madv
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
new file mode 100644
index 000000000000..73999c8e3570
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <errno.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/pidfd.h>
+#include "vm_util.h"
+
+#include "../pidfd/pidfd.h"
+
+/*
+ * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
+ *
+ * "If the signal occurs other than as the result of calling the abort or raise
+ *  function, the behavior is undefined if the signal handler refers to any
+ *  object with static storage duration other than by assigning a value to an
+ *  object declared as volatile sig_atomic_t"
+ */
+static volatile sig_atomic_t signal_jump_set;
+static sigjmp_buf signal_jmp_buf;
+
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
+
+static void handle_fatal(int c)
+{
+	if (!signal_jump_set)
+		return;
+
+	siglongjmp(signal_jmp_buf, c);
+}
+
+FIXTURE(process_madvise)
+{
+	int pidfd;
+	int flag;
+};
+
+static void setup_sighandler(void)
+{
+	struct sigaction act = {
+		.sa_handler = &handle_fatal,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGSEGV, &act, NULL))
+		ksft_exit_fail_perror("sigaction");
+}
+
+static void teardown_sighandler(void)
+{
+	struct sigaction act = {
+		.sa_handler = SIG_DFL,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	sigaction(SIGSEGV, &act, NULL);
+}
+
+FIXTURE_SETUP(process_madvise)
+{
+	self->pidfd = PIDFD_SELF;
+	self->flag = 0;
+	setup_sighandler();
+};
+
+FIXTURE_TEARDOWN_PARENT(process_madvise)
+{
+	teardown_sighandler();
+}
+
+static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
+				   size_t vlen, int advice, unsigned int flags)
+{
+	return syscall(__NR_process_madvise, pidfd, iovec, vlen, advice, flags);
+}
+
+/*
+ * Enable our signal catcher and try to read/write the specified buffer. The
+ * return value indicates whether the read/write succeeds without a fatal
+ * signal.
+ */
+static bool try_access_buf(char *ptr, bool write)
+{
+	bool failed;
+
+	/* Tell signal handler to jump back here on fatal signal. */
+	signal_jump_set = true;
+	/* If a fatal signal arose, we will jump back here and failed is set. */
+	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
+
+	if (!failed) {
+		if (write)
+			*ptr = 'x';
+		else
+			FORCE_READ(ptr);
+	}
+
+	signal_jump_set = false;
+	return !failed;
+}
+
+/* Try and read from a buffer, return true if no fatal signal. */
+static bool try_read_buf(char *ptr)
+{
+	return try_access_buf(ptr, false);
+}
+
+TEST_F(process_madvise, basic)
+{
+	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
+	const int madvise_pages = 4;
+	char *map;
+	ssize_t ret;
+	struct iovec vec[madvise_pages];
+
+	/*
+	 * Create a single large mapping. We will pick pages from this
+	 * mapping to advise on. This ensures we test non-contiguous iovecs.
+	 */
+	map = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(map, MAP_FAILED);
+
+	/* Fill the entire region with a known pattern. */
+	memset(map, 'A', pagesize * 10);
+
+	/*
+	 * Setup the iovec to point to 4 non-contiguous pages
+	 * within the mapping.
+	 */
+	vec[0].iov_base = &map[0 * pagesize];
+	vec[0].iov_len = pagesize;
+	vec[1].iov_base = &map[3 * pagesize];
+	vec[1].iov_len = pagesize;
+	vec[2].iov_base = &map[5 * pagesize];
+	vec[2].iov_len = pagesize;
+	vec[3].iov_base = &map[8 * pagesize];
+	vec[3].iov_len = pagesize;
+
+	ret = sys_process_madvise(PIDFD_SELF, vec, madvise_pages, MADV_DONTNEED,
+				  0);
+	if (ret == -1 && errno == EPERM)
+		ksft_exit_skip(
+			"process_madvise() unsupported or permission denied, try running as root.\n");
+	else if (errno == EINVAL)
+		ksft_exit_skip(
+			"process_madvise() unsupported or parameter invalid, please check arguments.\n");
+
+	/* The call should succeed and report the total bytes processed. */
+	ASSERT_EQ(ret, madvise_pages * pagesize);
+
+	/* Check that advised pages are now zero. */
+	for (int i = 0; i < madvise_pages; i++) {
+		char *advised_page = (char *)vec[i].iov_base;
+
+		/* Access should be successful (kernel provides a new page). */
+		ASSERT_TRUE(try_read_buf(advised_page));
+		/* Content must be 0, not 'A'. */
+		ASSERT_EQ(*advised_page, 0);
+	}
+
+	/* Check that an un-advised page in between is still 'A'. */
+	char *unadvised_page = &map[1 * pagesize];
+
+	ASSERT_TRUE(try_read_buf(unadvised_page));
+	ASSERT_EQ(*unadvised_page, 'A');
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(map, pagesize * 10), 0);
+}
+
+static long get_smaps_anon_huge_pages(pid_t pid, void *addr)
+{
+	char smaps_path[64];
+	char *line = NULL;
+	unsigned long start, end;
+	long anon_huge_kb;
+	size_t len;
+	FILE *f;
+	bool in_vma;
+
+	in_vma = false;
+	sprintf(smaps_path, "/proc/%d/smaps", pid);
+	f = fopen(smaps_path, "r");
+	if (!f)
+		return -1;
+
+	while (getline(&line, &len, f) != -1) {
+		/* Check if the line describes a VMA range */
+		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
+			if ((unsigned long)addr >= start &&
+			    (unsigned long)addr < end)
+				in_vma = true;
+			else
+				in_vma = false;
+			continue;
+		}
+
+		/* If we are in the correct VMA, look for the AnonHugePages field */
+		if (in_vma &&
+		    sscanf(line, "AnonHugePages: %ld kB", &anon_huge_kb) == 1)
+			break;
+	}
+
+	free(line);
+	fclose(f);
+
+	return (anon_huge_kb > 0) ? (anon_huge_kb * 1024) : 0;
+}
+
+/**
+ * TEST_F(process_madvise, remote_collapse)
+ *
+ * This test deterministically validates process_madvise() with MADV_COLLAPSE
+ * on a remote process, other advices are difficult to verify reliably.
+ *
+ * The test verifies that a memory region in a child process, initially
+ * backed by small pages, can be collapsed into a Transparent Huge Page by a
+ * request from the parent. The result is verified by parsing the child's
+ * /proc/<pid>/smaps file.
+ */
+TEST_F(process_madvise, remote_collapse)
+{
+	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
+	pid_t child_pid;
+	int pidfd;
+	long huge_page_size;
+	int pipe_info[2];
+	ssize_t ret;
+	struct iovec vec;
+
+	struct child_info {
+		pid_t pid;
+		void *map_addr;
+	} info;
+
+	huge_page_size = default_huge_page_size();
+	if (huge_page_size <= 0)
+		ksft_exit_skip("Could not determine a valid huge page size.\n");
+
+	ASSERT_EQ(pipe(pipe_info), 0);
+
+	child_pid = fork();
+	ASSERT_NE(child_pid, -1);
+
+	if (child_pid == 0) {
+		char *map;
+		size_t map_size = 2 * huge_page_size;
+
+		close(pipe_info[0]);
+
+		map = mmap(NULL, map_size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		ASSERT_NE(map, MAP_FAILED);
+
+		/* Fault in as small pages */
+		for (size_t i = 0; i < map_size; i += pagesize)
+			map[i] = 'A';
+
+		/* Send info and pause */
+		info.pid = getpid();
+		info.map_addr = map;
+		ret = write(pipe_info[1], &info, sizeof(info));
+		ASSERT_EQ(ret, sizeof(info));
+		close(pipe_info[1]);
+
+		pause();
+		exit(0);
+	}
+
+	close(pipe_info[1]);
+
+	/* Receive child info */
+	ret = read(pipe_info[0], &info, sizeof(info));
+	if (ret <= 0) {
+		waitpid(child_pid, NULL, 0);
+		ksft_exit_skip("Failed to read child info from pipe.\n");
+	}
+	ASSERT_EQ(ret, sizeof(info));
+	close(pipe_info[0]);
+	child_pid = info.pid;
+
+	pidfd = pidfd_open(child_pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	/* Baseline Check from Parent's perspective */
+	ASSERT_EQ(get_smaps_anon_huge_pages(child_pid, info.map_addr), 0);
+
+	vec.iov_base = info.map_addr;
+	vec.iov_len = huge_page_size;
+	ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
+	if (ret == -1) {
+		if (errno == EINVAL)
+			ksft_exit_skip(
+				"PROCESS_MADV_ADVISE is not supported.\n");
+		else if (errno == EPERM)
+			ksft_exit_skip(
+				"No process_madvise() permissions, try running as root.\n");
+		goto cleanup;
+	}
+	ASSERT_EQ(ret, huge_page_size);
+
+	ASSERT_EQ(get_smaps_anon_huge_pages(child_pid, info.map_addr),
+		  huge_page_size);
+
+	ksft_test_result_pass(
+		"MADV_COLLAPSE successfully verified via smaps.\n");
+
+cleanup:
+	/* Cleanup */
+	kill(child_pid, SIGKILL);
+	waitpid(child_pid, NULL, 0);
+	if (pidfd >= 0)
+		close(pidfd);
+}
+
+/*
+ * Test process_madvise() with various invalid pidfds to ensure correct error
+ * handling. This includes negative fds, non-pidfd fds, and pidfds for
+ * processes that no longer exist.
+ */
+TEST_F(process_madvise, invalid_pidfd)
+{
+	struct iovec vec;
+	pid_t child_pid;
+	ssize_t ret;
+	int pidfd;
+
+	vec.iov_base = (void *)0x1234;
+	vec.iov_len = 4096;
+
+	/* Using an invalid fd number (-1) should fail with EBADF. */
+	ret = sys_process_madvise(-1, &vec, 1, MADV_DONTNEED, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBADF);
+
+	/*
+	 * Using a valid fd that is not a pidfd (e.g. stdin) should fail
+	 * with EBADF.
+	 */
+	ret = sys_process_madvise(STDIN_FILENO, &vec, 1, MADV_DONTNEED, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBADF);
+
+	/*
+	 * Using a pidfd for a process that has already exited should fail
+	 * with ESRCH.
+	 */
+	child_pid = fork();
+	ASSERT_NE(child_pid, -1);
+
+	if (child_pid == 0)
+		exit(0);
+
+	pidfd = pidfd_open(child_pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	/* Wait for the child to ensure it has terminated. */
+	waitpid(child_pid, NULL, 0);
+
+	ret = sys_process_madvise(pidfd, &vec, 1, MADV_DONTNEED, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ESRCH);
+	close(pidfd);
+}
+
+/*
+ * Test process_madvise() with an invalid flag value. Now we only support flag=0
+ * future we will use it support sync so reserve this test.
+ */
+TEST_F(process_madvise, flag)
+{
+	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
+	unsigned int invalid_flag;
+	struct iovec vec;
+	char *map;
+	ssize_t ret;
+
+	map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1,
+		   0);
+	ASSERT_NE(map, MAP_FAILED);
+
+	vec.iov_base = map;
+	vec.iov_len = pagesize;
+
+	invalid_flag = 0x80000000;
+
+	ret = sys_process_madvise(PIDFD_SELF, &vec, 1, MADV_DONTNEED,
+				  invalid_flag);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(map, pagesize), 0);
+}
+
+TEST_HARNESS_MAIN
\ No newline at end of file
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index f96d43153fc0..5c28ebcf1ea9 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -61,6 +61,8 @@ separated by spaces:
 	ksm tests that require >=2 NUMA nodes
 - pkey
 	memory protection key tests
+- process_madvise
+	test process_madvise
 - soft_dirty
 	test soft dirty page bit semantics
 - pagemap
@@ -424,6 +426,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
 CATEGORY="madv_guard" run_test ./guard-regions
 
+# PROCESS_MADVISE TEST
+CATEGORY="process_madv" run_test ./process_madv
+
 # MADV_DONTNEED and PROCESS_DONTNEED tests
 CATEGORY="madv_dontneed" run_test ./madv_dontneed
 
-- 
2.43.0


