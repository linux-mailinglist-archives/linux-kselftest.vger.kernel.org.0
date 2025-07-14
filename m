Return-Path: <linux-kselftest+bounces-37243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E6B03E90
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E817417DD2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F626247294;
	Mon, 14 Jul 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZJgWC3V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FE246335;
	Mon, 14 Jul 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495983; cv=none; b=uLmRHi49jD7FigZv71m2unv9qY426PELMaSxXxrTYUpDvV+YYbSEVxGB/0ZRnpNC8UnqBK9IKSdnmuM8X6nHt1WPoG7tC0kqEqzGW84j/anZCm24G2BGzBkNFgHIc+2v+1eSHwjEKkaDmUT11O0Tj3Y2Ei3qiy+RfdtcDQx0yKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495983; c=relaxed/simple;
	bh=hYk00zGCG6x4d97VNY/+OHGhXs35MK/eMj4fdfoN2RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tic3Kgze7EudKFfVlQQahbRF1KnW5fAX5eXjBiREFo3IqhdJ1DkOOg5MHPla1amy+z1GTe+BlC+KRTD721h0OaJ9D3i5cDeQS5nWsmszx5bAAuIsEnHNfR+2m3K+mJjnX5y8T+66ozyF2Y2qbVGNJg8bzHyP9Fx2Qpb3nx5iZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZJgWC3V; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b56b1d301so2415905b3a.1;
        Mon, 14 Jul 2025 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752495980; x=1753100780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50J9z665k0zC/xuWOx+EPjjMP/L04EkIhGbCyQjAIRQ=;
        b=BZJgWC3VDPYJp+gnVBkW8DE1zTHlVBm4hsQb11FAcTdOOLAH7dsY8iCzeXzQFPDYaj
         VmhFoRjnDH0o161OCWU+czxs2AKiqbjg9Ka74+86J5aAP4jO7T9E6UT9h8qgy3QAy6S7
         G6ynrCQ92dnNm1QHJYLpCjWOqHCRvqAZvCNEc0kPLoqaSCbiM5AA833unJwGl62SiAAm
         t3WSJ1kErW5XMadM/qjevoi1wBNdgbS6RG/4WtPbHFKrY7xyCDPXMTPHepMESsd3zKAy
         XVfCYYVd/tYp+9gS0U4d0ndXkIyAq1zHTJUHzABcT3k7AZh5UjjTT7epZOfp60xa22nY
         b7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495980; x=1753100780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50J9z665k0zC/xuWOx+EPjjMP/L04EkIhGbCyQjAIRQ=;
        b=TpMfdFitAp26bDY0RmAb1xLuiK2zpT/TpJXJ3RIyFHQ0wGnOKA7BKEbm05LqD3hrG6
         n4IHLvc2y5xVx3SckxSIYdIIrTpAzbY49W3LpcsByJ15bS40V+OiJJVU1WF2rYkz3HND
         sMRv9yhUFmpQggGWnM4GTD3qQkEw8lojIrKUBmjRrW51WjlgwyZ768F19DzJwLLiANvh
         u83VVzB9b/XDItbOzQE2Gjvw1376eQMwZPKMuA3D0cbgjecV8CNmok5x0t+w0SRT2MZm
         jBSkxUECwY9ZQhO6LVC6Y7BobeIt8Kyfz2NKOaWoLq0deH1yVV9ukyeFcRHifbzZYlu9
         DMKA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+oDvh0JVhhuNt/Xd99T9NuC053MSKM/x8MnLA8kWoPGdHlMIO8pg+Sz3RHJN3L1K3t+SoQ33ZkbBZ/s=@vger.kernel.org, AJvYcCXRGV3V5K8qxvXuI7401MiTxkWbGycmjrh0K5Nku/8ANEZDHVSrf1DAGOIdalhowrjhU1j3g7JZx+BIAZnE3Eyw@vger.kernel.org
X-Gm-Message-State: AOJu0Yybv+QaeAxG4/IjLtOEacYh9qahLtjfkIgQ4MLJNwCIcAg6lagJ
	N56bQu42WwnjNSyeCuKq5LXt/aBQWdtFyXKJIodNOGmV6medceMEUe4f
X-Gm-Gg: ASbGncs3OQiWa++RebOVpfTzpKpd9eCm6rFvRSkKIM/OCROTaaAz6OGcZU8XeWl5Xdf
	jIisGaDuVh9CgZysJ6HBE+qJwGyfEOfGWh/muaz/ZHYtYv0wJiyJGghB1Bt3fUFGcqF6Wcj3aym
	Ez3x8uREgVB67x2i6h1FNyuNbObMEzoLYsEDcwPxH6hFbcKxgvwgTTNtg2nD7kZzlrsQ9ql8d6z
	vnr+G7dq1QHTc3ZG1FdnW4OnfM9x2y1pDyH+Gc3xbhEbppNT2pJUidp7UCO7jyE6uoEfoGIYDB9
	EimkZMHyLxgz2prHYghSGIJfeLADPb0IIKGvFdQxhEjtOT/XvVJXuFV8QV4IY+G7cJFcu4bnbkY
	UmVZtp7r+TNLEIVOjD39zhDt3gmJYNmENyPad6jWNxxyKo59JEm4egCI=
X-Google-Smtp-Source: AGHT+IFBcMfiX++AMr9iCIFPBcyM8A1+/mtArFfDZUr0zyB8GGeCCLBSdqzvVryUE7rBd5WKGlatnA==
X-Received: by 2002:a05:6a00:1413:b0:74c:5a8e:dd37 with SMTP id d2e1a72fcca58-74ee2b56632mr17831323b3a.16.1752495980174;
        Mon, 14 Jul 2025 05:26:20 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4c989sm10731701b3a.130.2025.07.14.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:26:19 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	wang lian <lianux.mm@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <Liam.Howlett@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	gkwang <gkwang@linx-info.com>,
	p1ucky0923 <p1ucky0923@gmail.com>,
	ryncsn <ryncsn@gmail.com>,
	"zijing . zhang" <zijing.zhang@proton.me>,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5] selftests/mm: add process_madvise() tests
Date: Mon, 14 Jul 2025 20:25:33 +0800
Message-ID: <20250714122533.3135-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for process_madvise(), focusing on verifying behavior under
various conditions including valid usage and error cases.

Signed-off-by: wang lian <lianux.mm@gmail.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Mark Brown <broonie@kernel.org>
Acked-by: SeongJae Park <sj@kernel.org>

---
Changelog v5:
- Refactor the remote_collapse test to concentrate on its primary goal
  confirming the successful remote invocation of process_madvise() on a child process.
- Split the validation logic for invalid pidfds out of the remote test and into two new
  (`exited_process_pidfd` and `bad_pidfd`).
- Based mm-new branch, can ensure clean application


Changelog v4: https://lore.kernel.org/lkml/20250710112249.58722-1-lianux.mm@gmail.com/
- Refine resource cleanup logic in test teardown to be more robust.
- Improve remote_collapse test to correctly handle different THP
  (Transparent Huge Page) policies ('always', 'madvise', 'never'),
  including handling race conditions with khugepaged.
- Resolve build errors

Changelog v3: https://lore.kernel.org/lkml/20250703044326.65061-1-lianux.mm@gmail.com/
- Rebased onto the latest mm-stable branch to ensure clean application.
- Refactor common signal handling logic into vm_util to reduce code duplication.
- Improve test robustness and diagnostics based on community feedback.
- Address minor code style and script corrections.

Changelog v2: https://lore.kernel.org/lkml/20250630140957.4000-1-lianux.mm@gmail.com/
- Drop MADV_DONTNEED tests based on feedback.
- Focus solely on process_madvise() syscall.
- Improve error handling and structure.
- Add future-proof flag test.
- Style and comment cleanups.

-V1: https://lore.kernel.org/lkml/20250621133003.4733-1-lianux.mm@gmail.com/

 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   1 +
 tools/testing/selftests/mm/process_madv.c | 304 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   5 +
 4 files changed, 311 insertions(+)
 create mode 100644 tools/testing/selftests/mm/process_madv.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index f2dafa0b700b..e7b23a8a05fe 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -21,6 +21,7 @@ on-fault-limit
 transhuge-stress
 pagemap_ioctl
 pfnmap
+process_madv
 *.tmp*
 protection_keys
 protection_keys_32
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index ae6f994d3add..d13b3cef2a2b 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -85,6 +85,7 @@ TEST_GEN_FILES += mseal_test
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += pfnmap
+TEST_GEN_FILES += process_madv
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
new file mode 100644
index 000000000000..249e2ed8dfe9
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -0,0 +1,304 @@
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
+#include <linux/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <sched.h>
+#include "vm_util.h"
+
+#include "../pidfd/pidfd.h"
+
+FIXTURE(process_madvise)
+{
+	unsigned long page_size;
+	pid_t child_pid;
+	int pidfd;
+};
+
+FIXTURE_SETUP(process_madvise)
+{
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+	self->pidfd = PIDFD_SELF;
+	self->child_pid = -1;
+};
+
+FIXTURE_TEARDOWN_PARENT(process_madvise)
+{
+	if (self->child_pid > 0) {
+		kill(self->child_pid, SIGKILL);
+		waitpid(self->child_pid, NULL, 0);
+	}
+}
+
+static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
+				   size_t vlen, int advice, unsigned int flags)
+{
+	return syscall(__NR_process_madvise, pidfd, iovec, vlen, advice, flags);
+}
+
+/*
+ * This test uses PIDFD_SELF to target the current process. The main
+ * goal is to verify the basic behavior of process_madvise() with
+ * a vector of non-contiguous memory ranges, not its cross-process
+ * capabilities.
+ */
+TEST_F(process_madvise, basic)
+{
+	const unsigned long pagesize = self->page_size;
+	const int madvise_pages = 4;
+	struct iovec vec[madvise_pages];
+	int pidfd = self->pidfd;
+	ssize_t ret;
+	char *map;
+
+	/*
+	 * Create a single large mapping. We will pick pages from this
+	 * mapping to advise on. This ensures we test non-contiguous iovecs.
+	 */
+	map = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (map == MAP_FAILED)
+		SKIP(return, "mmap failed, not enough memory.\n");
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
+	ret = sys_process_madvise(pidfd, vec, madvise_pages, MADV_DONTNEED, 0);
+	if (ret == -1 && errno == EPERM)
+		SKIP(return,
+			   "process_madvise() unsupported or permission denied, try running as root.\n");
+	else if (errno == EINVAL)
+		SKIP(return,
+			   "process_madvise() unsupported or parameter invalid, please check arguments.\n");
+
+	/* The call should succeed and report the total bytes processed. */
+	ASSERT_EQ(ret, madvise_pages * pagesize);
+
+	/* Check that advised pages are now zero. */
+	for (int i = 0; i < madvise_pages; i++) {
+		char *advised_page = (char *)vec[i].iov_base;
+
+		/* Content must be 0, not 'A'. */
+		ASSERT_EQ(*advised_page, '\0');
+	}
+
+	/* Check that an un-advised page in between is still 'A'. */
+	char *unadvised_page = &map[1 * pagesize];
+
+	for (int i = 0; i < pagesize; i++)
+		ASSERT_EQ(unadvised_page[i], 'A');
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(map, pagesize * 10), 0);
+}
+
+/*
+ * This test deterministically validates process_madvise() with MADV_COLLAPSE
+ * on a remote process, other advices are difficult to verify reliably.
+ *
+ * The test verifies that a memory region in a child process,
+ * focus on process_madv remote result, only check addresses and lengths.
+ * The correctness of the MADV_COLLAPSE can be found in the relevant test examples in khugepaged.
+ */
+TEST_F(process_madvise, remote_collapse)
+{
+	const unsigned long pagesize = self->page_size;
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
+		SKIP(return, "Could not determine a valid huge page size.\n");
+
+	ASSERT_EQ(pipe(pipe_info), 0);
+
+	self->child_pid = fork();
+	ASSERT_NE(self->child_pid, -1);
+
+	if (self->child_pid == 0) {
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
+		waitpid(self->child_pid, NULL, 0);
+		SKIP(return, "Failed to read child info from pipe.\n");
+	}
+	ASSERT_EQ(ret, sizeof(info));
+	close(pipe_info[0]);
+	self->child_pid = info.pid;
+
+	pidfd = syscall(__NR_pidfd_open, self->child_pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	vec.iov_base = info.map_addr;
+	vec.iov_len = huge_page_size;
+
+	ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
+	if (ret == -1) {
+		if (errno == EINVAL)
+			SKIP(return, "PROCESS_MADV_ADVISE is not supported.\n");
+		else if (errno == EPERM)
+			SKIP(return,
+				   "No process_madvise() permissions, try running as root.\n");
+		goto cleanup;
+	}
+
+	ASSERT_EQ(ret, huge_page_size);
+
+cleanup:
+	/* Cleanup */
+	kill(self->child_pid, SIGKILL);
+	waitpid(self->child_pid, NULL, 0);
+	if (pidfd >= 0)
+		close(pidfd);
+}
+
+/*
+ * Test process_madvise() with a pidfd for a process that has already
+ * exited to ensure correct error handling.
+ */
+TEST_F(process_madvise, exited_process_pidfd)
+{
+	struct iovec vec;
+	ssize_t ret;
+	int pidfd;
+
+	vec.iov_base = (void *)0x1234;
+	vec.iov_len = 4096;
+
+	/*
+	 * Using a pidfd for a process that has already exited should fail
+	 * with ESRCH.
+	 */
+	self->child_pid = fork();
+	ASSERT_NE(self->child_pid, -1);
+
+	if (self->child_pid == 0)
+		exit(0);
+
+	pidfd = syscall(__NR_pidfd_open, self->child_pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	/* Wait for the child to ensure it has terminated. */
+	waitpid(self->child_pid, NULL, 0);
+
+	ret = sys_process_madvise(pidfd, &vec, 1, MADV_DONTNEED, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ESRCH);
+	close(pidfd);
+}
+
+/*
+ * Test process_madvise() with bad pidfds to ensure correct error
+ * handling.
+ */
+TEST_F(process_madvise, bad_pidfd)
+{
+	struct iovec vec;
+	ssize_t ret;
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
+}
+
+/*
+ * Test process_madvise() with an invalid flag value. Currently, only a flag
+ * value of 0 is supported. This test is reserved for the future, e.g., if
+ * synchronous flags are added.
+ */
+TEST_F(process_madvise, flag)
+{
+	const unsigned long pagesize = self->page_size;
+	unsigned int invalid_flag;
+	int pidfd = self->pidfd;
+	struct iovec vec;
+	char *map;
+	ssize_t ret;
+
+	map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1,
+		   0);
+	if (map == MAP_FAILED)
+		SKIP(return, "mmap failed, not enough memory.\n");
+
+	vec.iov_base = map;
+	vec.iov_len = pagesize;
+
+	invalid_flag = 0x80000000;
+
+	ret = sys_process_madvise(pidfd, &vec, 1, MADV_DONTNEED, invalid_flag);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(map, pagesize), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index a38c984103ce..471e539d82b8 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -65,6 +65,8 @@ separated by spaces:
 	test pagemap_scan IOCTL
 - pfnmap
 	tests for VM_PFNMAP handling
+- process_madv
+	test for process_madv
 - cow
 	test copy-on-write semantics
 - thp
@@ -425,6 +427,9 @@ CATEGORY="madv_guard" run_test ./guard-regions
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
+# PROCESS_MADV test
+CATEGORY="process_madv" run_test ./process_madv
+
 CATEGORY="vma_merge" run_test ./merge
 
 if [ -x ./memfd_secret ]
-- 
2.43.0


