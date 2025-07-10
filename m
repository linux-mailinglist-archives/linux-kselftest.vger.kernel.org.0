Return-Path: <linux-kselftest+bounces-36955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45632B00079
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5F3A5352
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D164D29C352;
	Thu, 10 Jul 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD4IJo6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0842E5B2C;
	Thu, 10 Jul 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146606; cv=none; b=oGiemRqPY05VI9PsamQMOp6wn7xUjzElJ5CdHzOLrrX6EDAkzkVNWmy547Lbs0AzQ/VuA8XzB4HHvTqQbw/qoZVyeCU8kMfeYnc3ZZ8+tTkzHWh4K9h8UIrTbFgcPOEwbkyEo+uQhfSITI0mfoEJkcLksFR2iQIDEHSNn0KiBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146606; c=relaxed/simple;
	bh=X52YSyQ5nwP6l4rPQCIs03mNa1gyInYstO3GHPgVeuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeW+i8yRqpdhCTfBRc2UFFbakA6cWGf4hvExpmbK0lFOsTLnwkka/1kYIEFO2jxgRzSTxlLqWpwZPP8utfmEnxDKguavWLWousogLseJfn3helPBRCqfdiyXokpgIwd6OISY+XH/IcJ68dD2P7apeN1gOGYIHBkdAsaeGyqPjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD4IJo6m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234f17910d8so9008485ad.3;
        Thu, 10 Jul 2025 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752146604; x=1752751404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ayrM+n065jz37PSc6Pv9+0i4x5lteXvCa3/oTidBgc=;
        b=QD4IJo6mdotMC+Y+CVRjmLCJ5XdlRYd42XWLDp1vvYrA/bH53R6f2f5vPeAcrW6V+s
         NlZg0Qis5LCNJCyJcJyv6sWbIfoTkZ2h2JBLhNbTFTAOI/cwzJv1BASSMQVI15/3LhMW
         6xS8kioC71zILnV58cymlrDon3IC5S8gG+BF6TLRnJfB5eiFjxnyXYbrAWktGXy9+2t5
         P/8YL3c58I3WtCRIhqcKUurzeO5XLtkGdBSQnKz2LuNJ9Bn9nYN3Kb52NJfK2svPao5i
         vgp71nW99MjXWXbALivHUNRSBnOgV9V/dNNYjKnKJ/7VRZuVsELIjnzsY1RFoZ0ZeJIP
         1cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146604; x=1752751404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ayrM+n065jz37PSc6Pv9+0i4x5lteXvCa3/oTidBgc=;
        b=fGfQF/YkDDK7CJIBu+TS91E9sH9YwEkXoWMLkrDEFpsIMHHykIm3Ff3BHDyxRZocAM
         PZu4JX06JVtLxkoLfH8PSOb9PkDtFPwzbjH3ndXKX1709j85BVS0gUPgch80KOy5uSns
         hXmUaa4gXb7Wi5eYTvBtaR428CJWp2G2H3p507ot/7tNqoCtS7RYNQsFzPJfMr6GaFPn
         UAvt8rnBH36YaDBIDvtAxRBTuXHuIPK4/0C06OdnVOaErbL963B7OqWOGC2pbRA3kRmK
         JnojpkQRAIjl+ytFlBzYwTf0Ml00EWFFkcKixnOM4UIdO1mXAiDXyDDO2ycxeFiKcXDn
         o2+w==
X-Forwarded-Encrypted: i=1; AJvYcCUKNwDtFbO3dmAP2HAV7+TeRTdNWIELh9qoL1pbeufIRl30Mhnh1/tv0kia8+yV7Y+uPufhoJhIltci8zExo+ML@vger.kernel.org, AJvYcCXjuDNhTeSbyydXAOWh1ETMYtDn5Ovf4ZRGFRicCMTNSY3qc+oAYsdCGmc3/gpMxcJPBBzMAF0JwKlZfDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0zpzP5G+fRy6Qd2pPoXyPmrbMG8Ld0tpYYEnB8i9/sNtKx7e
	fnddbB7whhi4ZdwpDoUYN9MZUHgKKOUVxOjaSathz4ONCpOXiLxrcmB7
X-Gm-Gg: ASbGnctl+m/itXauxmy+xgWkjIuEL5vacexz6fr3ZY/4sgYLgr5JLyV/5LrNZ9FCb0X
	7c6Kw+aUIBAjvJmiYo9uVj7i63QdbAtFDOna94WLCX6CrfQqoAEs+AT/deV3Lvk5KOHxm4nEzuS
	oZDCnyAnlX7LfE1GIBDhMfV2KTMrVLV66p0ysUsZ3XLKeDm+CiRo4fhDxe5hMiimvGD5L3d+k/X
	+sAznQV9GxzJsFgSQ/Cb3XAA06wR3XtYT7sObyFZq37yTIMc7fBt1fxwcHkRI/lLuUNQEzSqZmY
	3E8w+/AiAPxr9rN8JJ1Xny+Q2jf2hpTqPxcpEUDCJaz1XIMOvPyjoz4alhuQKe5xFznyGranUk0
	dybp+CYD3
X-Google-Smtp-Source: AGHT+IHtyEQevvKEUpp8vFDMWWvuMq8VvPKAukAjvjliKgtkDqLtTfkXD2U7UfT7ndEIYJBiYOSlLQ==
X-Received: by 2002:a17:903:2ac5:b0:234:f6ba:e68a with SMTP id d9443c01a7336-23de2507f1fmr53895135ad.45.1752146603577;
        Thu, 10 Jul 2025 04:23:23 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb62caasm1960368a91.39.2025.07.10.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:23:23 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	sj@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	broonie@kernel.org,
	Liam.Howlett@oracle.com,
	brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	lianux.mm@gmail.com
Subject: [PATCH v4] selftests/mm: add process_madvise() tests
Date: Thu, 10 Jul 2025 19:22:49 +0800
Message-ID: <20250710112249.58722-1-lianux.mm@gmail.com>
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
Acked-by: SeongJae Park <sj@kernel.org>
---
Changelog v4:
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

 tools/testing/selftests/mm/.gitignore      |   1 +
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/guard-regions.c |  51 ---
 tools/testing/selftests/mm/process_madv.c  | 447 +++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh  |   5 +
 tools/testing/selftests/mm/vm_util.c       |  35 ++
 tools/testing/selftests/mm/vm_util.h       |  22 +
 7 files changed, 511 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/mm/process_madv.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 824266982aa3..95bd9c6ead9e 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -25,6 +25,7 @@ pfnmap
 protection_keys
 protection_keys_32
 protection_keys_64
+process_madv
 madv_populate
 uffd-stress
 uffd-unit-tests
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
diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 93af3d3760f9..4cf101b0fe5e 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -9,8 +9,6 @@
 #include <linux/limits.h>
 #include <linux/userfaultfd.h>
 #include <linux/fs.h>
-#include <setjmp.h>
-#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -24,24 +22,6 @@
 
 #include "../pidfd/pidfd.h"
 
-/*
- * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
- *
- * "If the signal occurs other than as the result of calling the abort or raise
- *  function, the behavior is undefined if the signal handler refers to any
- *  object with static storage duration other than by assigning a value to an
- *  object declared as volatile sig_atomic_t"
- */
-static volatile sig_atomic_t signal_jump_set;
-static sigjmp_buf signal_jmp_buf;
-
-/*
- * Ignore the checkpatch warning, we must read from x but don't want to do
- * anything with it in order to trigger a read page fault. We therefore must use
- * volatile to stop the compiler from optimising this away.
- */
-#define FORCE_READ(x) (*(volatile typeof(x) *)x)
-
 /*
  * How is the test backing the mapping being tested?
  */
@@ -120,14 +100,6 @@ static int userfaultfd(int flags)
 	return syscall(SYS_userfaultfd, flags);
 }
 
-static void handle_fatal(int c)
-{
-	if (!signal_jump_set)
-		return;
-
-	siglongjmp(signal_jmp_buf, c);
-}
-
 static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
 				   size_t n, int advice, unsigned int flags)
 {
@@ -180,29 +152,6 @@ static bool try_read_write_buf(char *ptr)
 	return try_read_buf(ptr) && try_write_buf(ptr);
 }
 
-static void setup_sighandler(void)
-{
-	struct sigaction act = {
-		.sa_handler = &handle_fatal,
-		.sa_flags = SA_NODEFER,
-	};
-
-	sigemptyset(&act.sa_mask);
-	if (sigaction(SIGSEGV, &act, NULL))
-		ksft_exit_fail_perror("sigaction");
-}
-
-static void teardown_sighandler(void)
-{
-	struct sigaction act = {
-		.sa_handler = SIG_DFL,
-		.sa_flags = SA_NODEFER,
-	};
-
-	sigemptyset(&act.sa_mask);
-	sigaction(SIGSEGV, &act, NULL);
-}
-
 static int open_file(const char *prefix, char *path)
 {
 	int fd;
diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
new file mode 100644
index 000000000000..7d7509486d46
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madv.c
@@ -0,0 +1,447 @@
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
+#include <linux/pidfd.h>
+#include <linux/uio.h>
+#include "vm_util.h"
+
+FIXTURE(process_madvise)
+{
+	int pidfd;
+	int flag;
+	pid_t child_pid;
+};
+
+FIXTURE_SETUP(process_madvise)
+{
+	self->pidfd = PIDFD_SELF;
+	self->flag = 0;
+	self->child_pid = -1;
+	setup_sighandler();
+};
+
+FIXTURE_TEARDOWN_PARENT(process_madvise)
+{
+	teardown_sighandler();
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
+ * Enable our signal catcher and try to read the specified buffer. The
+ * return value indicates whether the read succeeds without a fatal
+ * signal.
+ */
+static bool try_read_buf(char *ptr)
+{
+	bool failed;
+
+	/* Tell signal handler to jump back here on fatal signal. */
+	signal_jump_set = true;
+	/* If a fatal signal arose, we will jump back here and failed is set. */
+	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
+
+	if (!failed)
+		FORCE_READ(ptr);
+
+	signal_jump_set = false;
+	return !failed;
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
+	if (map == MAP_FAILED)
+		ksft_exit_skip("mmap failed, not enough memory.\n");
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
+	for (int i = 0; i < pagesize; i++)
+		ASSERT_EQ(unadvised_page[i], 'A');
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
+	snprintf(smaps_path, sizeof(smaps_path), "/proc/%d/smaps", pid);
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
+static bool is_thp_always(void)
+{
+	const char *path = "/sys/kernel/mm/transparent_hugepage/enabled";
+	char buf[32];
+	FILE *f = fopen(path, "r");
+
+	if (!f)
+		return false;
+
+	if (fgets(buf, sizeof(buf), f))
+		if (strstr(buf, "[always]")) {
+			fclose(f);
+			return true;
+		}
+
+	fclose(f);
+	return false;
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
+		ksft_exit_skip("Failed to read child info from pipe.\n");
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
+	if (is_thp_always()) {
+		long initial_huge_pages;
+
+		/*
+		 * When THP is 'always', khugepaged may pre-emptively
+		 * collapse the pages before our MADV_COLLAPSE call. Check
+		 * the initial state to provide a more accurate test report.
+		 */
+		initial_huge_pages =
+			get_smaps_anon_huge_pages(self->child_pid, info.map_addr);
+
+		if (initial_huge_pages == 2 * huge_page_size) {
+			/*
+			 * The pages were already collapsed by khugepaged.
+			 * The test goal narrows to verifying that MADV_COLLAPSE
+			 * correctly returns success on an already-collapsed
+			 * region, as documented.
+			 */
+			ksft_test_result_skip(
+				"THP is 'always' and pages were pre-collapsed; verifying success on already-collapsed page.\n");
+
+			ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE,
+						  0);
+			ASSERT_EQ(ret, huge_page_size);
+			goto cleanup;
+		}
+
+		/*
+		 * Pages are still small, creating a race between our call
+		 * and khugepaged. This is the main test scenario for 'always'.
+		 */
+		ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
+
+		if (ret == -1) {
+			/*
+			 * MADV_COLLAPSE lost the race to khugepaged, which
+			 * likely held a page lock. The kernel correctly
+			 * reports this temporary contention with EAGAIN.
+			 */
+			if (errno == EAGAIN) {
+				ksft_test_result_skip(
+					"THP is 'always', process_madvise returned EAGAIN due to an expected race with khugepaged.\n");
+			} else {
+				ksft_test_result_fail(
+					"process_madvise failed with unexpected errno %d in 'always' mode.\n",
+					errno);
+			}
+			goto cleanup;
+		}
+
+		/*
+		 * MADV_COLLAPSE won the race and successfully collapsed
+		 * the pages. Verify the final state.
+		 */
+		ASSERT_EQ(ret, huge_page_size);
+		ASSERT_EQ(get_smaps_anon_huge_pages(self->child_pid, info.map_addr),
+			  huge_page_size);
+		ksft_test_result_pass(
+			"THP is 'always', MADV_COLLAPSE won race and collapsed pages.\n");
+		goto cleanup;
+	}
+
+	/*
+	 * THP is 'madvise' or 'never'. No race is expected with khugepaged.
+	 * We can perform a straightforward state-change verification.
+	 */
+	ASSERT_EQ(get_smaps_anon_huge_pages(self->child_pid, info.map_addr), 0);
+
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
+	ASSERT_EQ(get_smaps_anon_huge_pages(self->child_pid, info.map_addr),
+		  huge_page_size);
+
+	ksft_test_result_pass(
+		"MADV_COLLAPSE successfully verified via smaps.\n");
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
+	pidfd = syscall(__NR_pidfd_open, child_pid, 0);
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
+	if (map == MAP_FAILED)
+		ksft_exit_skip("mmap failed, not enough memory.\n");
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
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index dddd1dd8af14..84fb51902c3e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -65,6 +65,8 @@ separated by spaces:
 	test pagemap_scan IOCTL
 - pfnmap
 	tests for VM_PFNMAP handling
+- process_madv
+	test process_madvise
 - cow
 	test copy-on-write semantics
 - thp
@@ -422,6 +424,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
 CATEGORY="madv_guard" run_test ./guard-regions
 
+# PROCESS_MADVISE TEST
+CATEGORY="process_madv" run_test ./process_madv
+
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 5492e3f784df..85b209260e5a 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -20,6 +20,9 @@
 unsigned int __page_size;
 unsigned int __page_shift;
 
+volatile sig_atomic_t signal_jump_set;
+sigjmp_buf signal_jmp_buf;
+
 uint64_t pagemap_get_entry(int fd, char *start)
 {
 	const unsigned long pfn = (unsigned long)start / getpagesize();
@@ -524,3 +527,35 @@ int read_sysfs(const char *file_path, unsigned long *val)
 
 	return 0;
 }
+
+static void handle_fatal(int c)
+{
+	if (!signal_jump_set)
+		return;
+
+	siglongjmp(signal_jmp_buf, c);
+}
+
+void setup_sighandler(void)
+{
+	struct sigaction act = {
+		.sa_handler = &handle_fatal,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGSEGV, &act, NULL))
+		ksft_exit_fail_perror("sigaction in setup");
+}
+
+void teardown_sighandler(void)
+{
+	struct sigaction act = {
+		.sa_handler = SIG_DFL,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGSEGV, &act, NULL))
+		ksft_exit_fail_perror("sigaction in teardown");
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b8136d12a0f8..6bc4177a2807 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -8,6 +8,8 @@
 #include <unistd.h> /* _SC_PAGESIZE */
 #include "../kselftest.h"
 #include <linux/fs.h>
+#include <setjmp.h>
+#include <signal.h>
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
 #define PM_SOFT_DIRTY                 BIT_ULL(55)
@@ -61,6 +63,24 @@ static inline void skip_test_dodgy_fs(const char *op_name)
 	ksft_test_result_skip("%s failed with ENOENT. Filesystem might be buggy (9pfs?)\n", op_name);
 }
 
+/*
+ * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
+ *
+ * "If the signal occurs other than as the result of calling the abort or raise
+ *  function, the behavior is undefined if the signal handler refers to any
+ *  object with static storage duration other than by assigning a value to an
+ *  object declared as volatile sig_atomic_t"
+ */
+extern volatile sig_atomic_t signal_jump_set;
+extern sigjmp_buf signal_jmp_buf;
+
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
+
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
 bool pagemap_is_swapped(int fd, char *start);
@@ -90,6 +110,8 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
 int close_procmap(struct procmap_fd *procmap);
 int write_sysfs(const char *file_path, unsigned long val);
 int read_sysfs(const char *file_path, unsigned long *val);
+void setup_sighandler(void);
+void teardown_sighandler(void);
 
 static inline int open_self_procmap(struct procmap_fd *procmap_out)
 {
-- 
2.43.0


