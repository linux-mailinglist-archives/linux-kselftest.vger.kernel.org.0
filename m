Return-Path: <linux-kselftest+bounces-38049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD13B14D0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 13:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE973B6D9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA928CF6F;
	Tue, 29 Jul 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clw7hP4q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521F2248A0;
	Tue, 29 Jul 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788744; cv=none; b=itMhVooPKmzIjV/ssazfOj74ATTwMuJKnr3BrRiVcNcmiHqeZ16jQwif1Y82Iev3smx3MvmlN6Eub7c3f74A7/wQhH5vrqWRF22YS7jGFKOuJZ96KjjgPgA+x5R3dTGDMRAwSdZYSJ414NyWUnbMI12Gi2sFJPreMQIRzVNIBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788744; c=relaxed/simple;
	bh=Q9rmyPq3LvSHj4kkNv9xYeGBakz/Mkv/1LFIDRNPtqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkP6CYFJmgGENbl/g+CWHrc9GsTel0USfrcDGPNfwpDCGEGAN6Ab4cGrUD3B8lEqqcj6z2OAuIqE4zZCF3nfCZHYKq8VaGB7kgl2WootsYDEbZLaxgHd1i+vMR5sHmgDnGxtjCgHT8YhaVfG2GtP4nZTox7hNVGzkS7kNERulc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Clw7hP4q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23ffa7b3b30so24906645ad.1;
        Tue, 29 Jul 2025 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753788740; x=1754393540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHhUFJOea/Pd7a6BTVGSEExEjw5vXu28unEpKBj3Ibs=;
        b=Clw7hP4qLhr/MeYXVs3+XWvObvKJibYqA+CcRcuhLxkKPsy3EjN2VWwH9adkQ9x9O8
         lIJ3uD5QKxnFnCIct/qSoqj3GTLBFa/XGYcQjNICnE7Vu5EpWgusqtzbOUIadAdD/KkT
         beegCoQM9nmAnamDovUFbeDX283kZ1oIvMa38kL5kQRpRXsGQWnBQLvrPBm7SLe//e7y
         UNTonOnTPWL1zhzdqDKRmY57IuYt8gegq9YWljjreTOLgDvkPLFQPBAja2ce48jnwFMX
         d6f8T4FLQvcVrXSEH+f0nulralf7zy+Fr676ryxI8pGhynXupYAT1JTLrt4ii8KJfh/Y
         SReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753788740; x=1754393540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHhUFJOea/Pd7a6BTVGSEExEjw5vXu28unEpKBj3Ibs=;
        b=Nss854mdkI8WxaYXvps/V8pJwcWDyKpS5RPeLwO4BCmsBmi96XnQS2OTJt5wTDN8Xw
         RzFP6i5aw7kZ8YxSM9hlTDHW05SHDrR7rq+NjH+FBODQSitb+SdbXXcvQdxnqLfOUQnZ
         sTKOVDE5ya+ytoVXdh+IMTWM9ED4ZfDqAzJyf8EGwXtuaoUcQY4oouLr+kqdLc9Wm7/c
         mADmnLqUVY1JbzMra1H/8rIrbZIq4Qaw9FwK4AyAvhqXwGapUjwp1UiWKuKCDFC6EuQH
         idtfVoLGNRq/a7/B/a06Gbd+lALH/P/ZSDvQKjBg3rx81GZ0boD8INuHWtN8C6AteUpz
         BzkA==
X-Forwarded-Encrypted: i=1; AJvYcCUjeLuUsj7BO2mk1ce6gf/QYZJ9T/H9iCab7hJegQYnC8v3MUbWQVGtW86CiPnhbf3/Y2Y6AT1ZKRMO4JON/cEw@vger.kernel.org, AJvYcCXm4b8NyjZupusCEtg1MTLlWL7farmYb/n/h9Wjw0+auCdLy9M/g3IBkaa2Q29hrHdb8cxDwourpqrdgh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9mnugUeZ2pdyYcY5XAKBF105RYD87AFsUO7imkqcJoGR7tpn
	ZkYqM/N9MKuxDFar/A+rRJyFI9y09Sykhb+XiTb8afxxFTgVdLeneHQF
X-Gm-Gg: ASbGncv18MRGh6+eh4ypd/xzyNXczVEaJ6Gk1nxvOKUpLAbxfd4/v/VrK/Wa5VZefMG
	Sfnx0cxwZZbYJfWs2HMfe8E6B34TOHVmSuu9gjboRTjWnUSSpPAM3gF3lE66zxGLjTwQS06beHI
	WuE2MAVFFn6pBHmPxL6WQbUkuLHjobVnlhUiWzIynhUCtTN+zv59R6UtkKP2cMqE+wH/73Br51u
	tNzgghLSp0YMuflueJ7SEUUSUek0IyYO3mIw9XE0pxKWl0+0mAtUOMgL32XLTEmiI9qplqBifex
	XnS7iYuIizpsxgHBI04lHklrq8mrSHmuwxCR02bXZ6yGqb89hCoi6VVvIPyOGHhRlBlrjswFzde
	SXecJ8OWWqzj52JS9ftdNR6zYF1JZ/ApQ9MFSI+T7qRvmbbP2CuKLNAdfVCE=
X-Google-Smtp-Source: AGHT+IFXzwzJWyCGho6shdLUUQN2sDwdI0rFz44svVIJGV/mIzME36PR/iNv/78wzMWtsb/GOcsAUQ==
X-Received: by 2002:a17:902:d484:b0:240:640a:c560 with SMTP id d9443c01a7336-240640ac6d1mr55978525ad.24.1753788740276;
        Tue, 29 Jul 2025 04:32:20 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.255.249.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24007d9a31bsm54092565ad.103.2025.07.29.04.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:32:19 -0700 (PDT)
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
	ryancsn@gmail.com,
	zijing.zhang@proton.me,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v7] selftests/mm: add process_madvise() tests
Date: Tue, 29 Jul 2025 19:31:09 +0800
Message-ID: <20250729113109.12272-1-lianux.mm@gmail.com>
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
Suggested-by: Mark Brown <broonie@kernel.org>
Acked-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Zi Yan <ziy@nvidia.com>

---
Changelog v7:
- In the remote_collapse test, replace default_huge_page_size() with read_pmd_pagesize()
- Add a new test, invalid_vlen, to verify that process_madvise() correctly 
 fails with EINVAL when the vlen argument exceeds UIO_MAXIOV.

Changelog v6: https://lore.kernel.org/lkml/20250721114614.40996-1-lianux.mm@gmail.com/
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
 tools/testing/selftests/mm/process_madv.c | 344 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   5 +
 4 files changed, 351 insertions(+)
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
index 000000000000..471cae8427f1
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -0,0 +1,344 @@
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
+	huge_page_size = read_pmd_pagesize();
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
+	ret = sys_process_madvise(self->remote_pidfd, &vec, 1, MADV_COLLAPSE,
+				  0);
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
+	const unsigned long pagesize = self->page_size;
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
+	self->remote_pidfd = syscall(__NR_pidfd_open, self->child_pid, 0);
+	ASSERT_GE(self->remote_pidfd, 0);
+
+	/* Wait for the child to ensure it has terminated. */
+	waitpid(self->child_pid, NULL, 0);
+
+	ret = sys_process_madvise(self->remote_pidfd, &vec, 1, MADV_DONTNEED,
+				  0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ESRCH);
+}
+
+/*
+ * Test process_madvise() with bad pidfds to ensure correct error
+ * handling.
+ */
+TEST_F(process_madvise, bad_pidfd)
+{
+	const unsigned long pagesize = self->page_size;
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
+ * Test that process_madvise() rejects vlen > UIO_MAXIOV.
+ * The kernel should return -EINVAL when the number of iovecs exceeds 1024.
+ */
+TEST_F(process_madvise, invalid_vlen)
+{
+	const unsigned long pagesize = self->page_size;
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
+	ret = sys_process_madvise(pidfd, &vec, 1025, MADV_DONTNEED, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(map, pagesize), 0);
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


