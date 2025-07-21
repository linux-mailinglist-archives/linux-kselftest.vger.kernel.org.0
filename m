Return-Path: <linux-kselftest+bounces-37746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD5B0C39E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE06D3AC603
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820C2BF007;
	Mon, 21 Jul 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT63x/U7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA02D29B5;
	Mon, 21 Jul 2025 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098536; cv=none; b=BY8JaBb5vNdow4sDyUF6vJ1df+mt2ppz468Ut1rSk7adP3aL4Db5jk/6FsMfB8XL1pbAH1niIeftSYPZGEAG1vKo9LmuEa4dE4oe8uAqKaauZzmB3xpF6t9VzutB55j+GHlDRkVuvFfKwwoy0y2oRjoTQwBbuR+t/x/Hn0Azclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098536; c=relaxed/simple;
	bh=FPZUoVzQ1k2Jl40SR1sDvMO7mt9dYAITqWdmmM3E9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KL3P/S6gxA3bdfhxIB6nMSx0m5vCA7C/lQ82g8oeUlS7J9enmy+OHzuoY38s5/QfUJxdzOfyzw0jp5/H0nbKIErBlLmDzaS3uaOBQ1EmW8JoVvg4dKggeQItpOCUwiv0yaat/opJA4VRDqPXI6WtD3BiRV7X4pxyedyG3e/St0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT63x/U7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b440afa7so39332265ad.0;
        Mon, 21 Jul 2025 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098534; x=1753703334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sReXXIx9NMJXCRfkoLRAwZrYfbcdFD69IH+Y22/p/w=;
        b=PT63x/U7cZ7sCuMFRpeR0N5pVeH8Ssm4cRvMC8U79AXtPO+5pL+p5gLfer7Z/aLIDL
         DiP0t1ndFycQjYz4PbdlUwZv0eA+UA+dc4BfDg4lAmUQ7lmstnPxeAEJGDUWBIBbKQj5
         z5TU5SZU6kTbC6HvQCKUXYvnB1bQD9DoP5hAO8R2Mdyak3k28bINaWmEgZNxFJaqwnOu
         wD3k8F2iWxMssiL72pnVVpx6n10jeYVYh7afw+/VRsbzmQsE7ecy5c/3jo3jn62j6hIA
         qgOZsEdxRnh81+LBwUGeiStEztNSJmq8lsCizIZdmKIyMMj7W30S+6exEfxPCkG/ajSA
         mfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098534; x=1753703334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sReXXIx9NMJXCRfkoLRAwZrYfbcdFD69IH+Y22/p/w=;
        b=cY2GBIKdI1prdiuY2VRbuQc3jJnM4skLySl/yurT8tbZrZZdaH3cjHLtlQEmWYo+eO
         WVGXosmXFziB737a6yDxHMqlDxbMqv2Zr9B5Vpe0dk0wnF4rErzfgqcz1kwFCaIlpPi/
         /PyfPIoiusj3olRKNQ1NaBmbX6i/IU25Qyn9RS6YVzYqZdmJTd2LmDunY3yx63+MWT+4
         I2Ywnyn2Nk9Q6bWGrDTT3Yq3ntv6IwwPAYTPPlR9IxKwaB9L4mfJ0dkUgt5r8lii+YLm
         sCD+1RoucfhPLpCSz5THieJvWzZY58bDBuxn9LQ+BdXtjGvK+bfoMmzZ6GNBxiOFb3rI
         lPXA==
X-Forwarded-Encrypted: i=1; AJvYcCXDeLdbXnxJNzG7TtwCqbJBD86tBPn2Br8653/Aw1Zfz09kimptC5wX5YnR31RVc2ksRqoMqwDiZwRRp749vB0n@vger.kernel.org, AJvYcCXrSk9aMnsAF7tJh6pK246vhlINIK+bjtYiPzix2z3Jbdr1Dd8Wvja5eVePhXUPzEB/LKAUJ+y4kF5ZM44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBNJ2gKQItr5+JDHH6e7qTWOASp+elY+lrzIZrSOXHPyJ1X9q
	5hXGBpNUH3tIZCKKsMu/cNHQxLd7izVjAh8JgkuKTbjCnPpfNOWZWs/e
X-Gm-Gg: ASbGncsjsHpuDyU143Q+/r+p6jKrqRi54Y+uYSYMQ2dWxrvQLrQavhWsvIq7tvBxOsZ
	ZbcDZkSsU8qRHIcu385021GHHBvwX/sSe8tXb7huqjmsQXoODHhuIHkWlwJXcq5DNK4OkYcDhR7
	ac6chBeLcbynLNx/3Cpb75hWB3Zxq8GX4hlZLRhkIgAVFfz+DgjhYogE85CNXQy/vDUoE7lx8nr
	fz5SF030+kG0LWNj3ZZxQ6wiJCAQefcYTWg3ujiuJphnDKCpA5/XUJxCRpb/NB41qwboPrQaKoE
	QsCJRU3QNDEld81bKvRIGcXtcJvXEcHgEbsMqLh6fBV5HpwJhZVXNPZpGhoTDQONu5lk5vo6+L9
	yAah9Ey+hEQmW2mBuTPfVv06iEzixijbguha+GfQBbi65auOL
X-Google-Smtp-Source: AGHT+IHsUogxyxa7Su4xFJsizeA4Qw7ICRea3y4pr9fiZSlnKvxn857hLpw1XX1ViVgvxDlDgxPzKQ==
X-Received: by 2002:a17:903:2ac7:b0:235:779:edfe with SMTP id d9443c01a7336-23e3035fd75mr233353325ad.43.1753098533948;
        Mon, 21 Jul 2025 04:48:53 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b4adeb8sm57038675ad.0.2025.07.21.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:48:53 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	jannh@google.com,
	Liam.Howlett@oracle.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	gkwang@linx-info.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	zijing.zhang@proton.me,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v6] selftests/mm: add process_madvise() tests
Date: Mon, 21 Jul 2025 19:46:14 +0800
Message-ID: <20250721114614.40996-1-lianux.mm@gmail.com>
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
Changelog v6:
- Refactor child process and pidfd management to use the kselftest
  fixture's setup and teardown mechanism. This ensures that child
  processes are reliably terminated and file descriptors are closed, even
  when a test is aborted by an ASSERT or SKIP macro. This resolves the
  issue where a failed assertion could lead to a leaked child process.

Changelog v5: https://lore.kernel.org/lkml/20250714122533.3135-1-lianux.mm@gmail.com/
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
 tools/testing/selftests/mm/process_madv.c | 302 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   5 +
 4 files changed, 309 insertions(+)
 create mode 100644 tools/testing/selftests/mm/process_madv.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index f2dafa0b700b..e7b23a8a05fe 
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
index 000000000000..8a83eac3bfab
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -0,0 +1,302 @@
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
+	int remote_pidfd;
+	int pidfd;
+};
+
+FIXTURE_SETUP(process_madvise)
+{
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+	self->pidfd = PIDFD_SELF;
+	self->remote_pidfd = -1;
+	self->child_pid = -1;
+};
+
+FIXTURE_TEARDOWN_PARENT(process_madvise)
+{
+	/* This teardown is guaranteed to run, even if tests SKIP or ASSERT */
+	if (self->child_pid > 0) {
+		kill(self->child_pid, SIGKILL);
+		waitpid(self->child_pid, NULL, 0);
+	}
+
+	if (self->remote_pidfd >= 0)
+		close(self->remote_pidfd);
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
+	self->remote_pidfd = syscall(__NR_pidfd_open, self->child_pid, 0);
+	ASSERT_GE(self->remote_pidfd, 0);
+
+	vec.iov_base = info.map_addr;
+	vec.iov_len = huge_page_size;
+
+	ret = sys_process_madvise(self->remote_pidfd, &vec, 1, MADV_COLLAPSE, 0);
+	if (ret == -1) {
+		if (errno == EINVAL)
+			SKIP(return, "PROCESS_MADV_ADVISE is not supported.\n");
+		else if (errno == EPERM)
+			SKIP(return,
+				   "No process_madvise() permissions, try running as root.\n");
+		return;
+	}
+
+	ASSERT_EQ(ret, huge_page_size);
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


