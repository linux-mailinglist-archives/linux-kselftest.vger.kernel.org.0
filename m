Return-Path: <linux-kselftest+bounces-36038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2FAEC6C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2107A19E2
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9078220F41;
	Sat, 28 Jun 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBeSiFIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D521C9E4;
	Sat, 28 Jun 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751110804; cv=none; b=Q23b9Xwq2XDwwe5YwfMyybrrULXQCqEpNMtmH4ZKUu9D4sTnHumMP0vg1cDx+6cYEcvg3+L7Pxck4Zd3oP7xtjA5KeAuhMtswr3365vqFXTI7grRtp5bxQ5nq2nXgqjyhXqZtXm/TWAOU7rb3VPZ3btaoWei0mwnKCV/iwGDEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751110804; c=relaxed/simple;
	bh=7GEEpOeNMcTbPLlhzMv8Jyx7KZuUFgw5+Q4FxL0PlHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfNf9Pq+zgzROb0DJjMeGmrRiBJEl+3lp2CCyeP7XUEYfCnwRTZF/4g9HQIQUU0LQmYCvAos68qSACCE1kyVnLF+AEg/1AyceTYk0G/1EKhZH5iPFonqtAfmKkDY+uxBpQPICdTEYSnX4C48S8TpA3BysEbj6dptfj0aNanfUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBeSiFIf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237311f5a54so3184175ad.2;
        Sat, 28 Jun 2025 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751110802; x=1751715602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6y9Dw+jgZJo4xJlbwrL/3OQAq0W5zElj1YXcefANK4=;
        b=IBeSiFIfj+akJe5J+39kTp8CEwlS+Vjj3IJfPRUaYlD2WwGIzsqhNJ0Jptgeqb7066
         Q3OfyWw95/Q6NwB6eCJ7DWxbQR6X4caHFOHFdGkq7m6+hDgDwCbRd3727BzAKbNb2BiT
         KUOv+zmh6uNIey8hPw1uQ2nMB7iwhbFHpM19xrkB5Si88sC3WSKDkscfKBbDgMKSeqFZ
         yAVNTsNO45Og+I1laKTJ0wfPHEN7aGjlMzIWUqz+7Y+2Y9mwXnujCmfTxj8oTT+5M2uD
         tMbiS/0k+yzcOcZvVFd/O/A+Oaf4YtQ1g0AO1K5SWxE1pcX1/5ZiaIp0GONgMGmTJwTu
         JsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751110802; x=1751715602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6y9Dw+jgZJo4xJlbwrL/3OQAq0W5zElj1YXcefANK4=;
        b=SOgCGZUEdkmtq+1XyTPwQfKCsWtaK9B1gxIwJYMTEkyBTb3sXOimH7FesiIM2pMgHg
         ZzgpvgE4m4IT97sKOXyPmZB0T+2RwpYX3KabRlJgYMcOyI4gyQdgkCmI/41g5IHB1Jlk
         e6IfvfvvOfy8jZVKYgFBB30A8CcJ7E0AwXrNKEoCKonxlYkPhTQIraijYwoa4/ySVep+
         Kjt1u/JW5uXhI43lMgMgPs20wREVR0OopFFLBpd8t5ZhjqXPVvh047V3e/OqKQH2iVCy
         zrvPIMztYHikB40TSP1xYC5hBmMhOhIlqUESWhcCxdiuhhrDBl+RiQ3QTqb7G/3jTlx8
         581A==
X-Forwarded-Encrypted: i=1; AJvYcCViVHfZSfVLwfGwk0mLrdAxuSW9p/vC4V6rqxQOYEUqrqliCAZCCDQv9TCfylxSgDglKklX0wUICLqbNlAAZAIQ@vger.kernel.org, AJvYcCWrcS0QEPTTa/E2q3LygySGPD195JZjyUXxYCWMoYClgxuVb5c0VRp0Lvltf6nJhZfSypeblUogLwoqNA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+j2lfqAZ2LKZCPVkqYXFA3upnzD1JeGDpM1q9dwA3OzkkJT5f
	nYFRwy3plCd83M2VBZUgd4wBXuKhSxgGs+192ZibAZUPqbeajbPdqYA3
X-Gm-Gg: ASbGncuZHB7u+BUV8ItzpmQQ81y1iVJw8vOdzrcEeSlHpzndiDlXoC0ErZ9Iwvb/Lbv
	9wZ62zmxaRA/Sfhmlrh/ND7acjBcj59qQBJ/fKynctsXrQNjjG2hQ5Jf4KWfi5WGGklrxES3a/p
	DSVHea+863gPiIpcAcVlGbSDyfbWcbBxZbZfw4DPMy2LY5nrkv79TbyOEHhjc9MiAnYSKRZBB7p
	+OsJxOB2YvhcV7jx5blWpHFN3UD4VRSHnfIt5oRiWFptLAgFAE/Xj+BK8ozDi+NIES9UcMzAOaG
	1vCt9ZXT+dZO0Rb8Sn9tUbOix9qkVjYT2/xNUeQ0cCRv5tTjXki+PpvzyUnVAjxtVf6SYFDRImk
	WDEESjq1TrtNiEQYE
X-Google-Smtp-Source: AGHT+IG/DmUME3XbmifZP4XmUZlQ8KnKZYhZROLCSr4UX8yivfQ+99IqRK81G0jjZGl4uUqUWhK8QA==
X-Received: by 2002:a17:903:2452:b0:235:f45f:ed41 with SMTP id d9443c01a7336-23ac3afdaadmr107838625ad.19.1751110801639;
        Sat, 28 Jun 2025 04:40:01 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([111.202.167.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f2239sm38710135ad.81.2025.06.28.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 04:40:01 -0700 (PDT)
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
Subject: [PATCH] selftests/mm: Add process_madvise() tests
Date: Sat, 28 Jun 2025 19:39:45 +0800
Message-ID: <20250628113945.145588-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624104654.4418-1-lianux.mm@gmail.com>
References: <20250624104654.4418-1-lianux.mm@gmail.com>
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

Changelog v2:
- Drop MADV_DONTNEED tests based on feedback
- Focus solely on process_madvise() syscall
- Improve error handling and structure
- Add future-proof flag test
- Style and comment cleanups

Signed-off-by: wang lian<lianux.mm@gmail.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
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


