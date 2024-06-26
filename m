Return-Path: <linux-kselftest+bounces-12771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBA9177E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2EE1C227E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978111448EA;
	Wed, 26 Jun 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMXUczu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843013D8A8
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378510; cv=none; b=rJhnVNAprylEFv8hALqJxkILLLLBDsXS0SVkVQFT7OudujPWij9fYNYZgIA/8jzYX9VHtdToc4PMs5x1FDebn9UnItGjJVAvECYUiTU6ltscmtkCjLv2NBsRx3J4Zja+rVvQVgnh5Wwt4gZ/kqBA0gn4mRKQjz67AiFOwny2e0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378510; c=relaxed/simple;
	bh=IhvigeJBL2yPDtPyEQN8WvD1fHpUC66ewqLpBFi1bog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9mv8Jjr+i9K3S327S8ksJQqMbeKvhjsJyioYN9di3hv0jpqwxW4ifRQQSoAJm365I9+A98PaE0LEYr6a1X3ENfNDPPdVqd3W4K2gUk8uZgu6yD30WNpiHEfAHDoeCVEHIsplPK9VRa1ue8otCW2/81w/9JjjWg31KP7AMPdbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMXUczu3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c7a8fa8013so7998958a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719378508; x=1719983308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJd557bj0v0anBZaK3fJ4hYak7G76iVHGHBQnSWuRrw=;
        b=CMXUczu3gSJaw2ZVxrHVFI1N4pkhqxM7JbgzjAUKEX9N4h9qfYa52SmCCaA8QnU1Z5
         L1ab5mKBmRC+9dBKaHkqe/G+BA1ve8TCuDcCM74AvyJqRqcca2DxdXkuxNxBPUgODY/S
         nIRrO3gQpEulUcIZxzVf/47rCjd9WkzlAlij3CXyPsAWDCPAydv7QAcwdAZSLNcWYjFL
         hgyWwz5Ajs+frFBWH/U9OD0GRCvEffO3KNVllgqM88xTQKz5qCKGewaZC/pEELiibA8a
         a6v98tN55z4T+ALFYlVdD70uGvqquukorU7Zrm3A4UU5Xi4/frnEddb09DDQk4NF5nlv
         FSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378508; x=1719983308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJd557bj0v0anBZaK3fJ4hYak7G76iVHGHBQnSWuRrw=;
        b=ISXxPdnK6wShxj4CqebQMooTamCFkGUwQM9SyHmD8PNXkHrVSnATK5I/CYEx8qgsGU
         ZnQQ+oCT7Wx0IwjywXFsiggsFTNWujQtzmOo1coERnOrcMC8icDiFZUYm14qHds505Wb
         9zFfDAc2qK1EL8O8+5gWvLt7y8qy0jl9S2jalyLsDzet15VMuNLJd9aWnoFNAaJFeJG3
         GK5fSwQ4O5YYFG1d/+a1xubZozYneF4CMY61WOjBvH6PiU+3rYtuZK0tB85YaHrhbNR+
         7v5kwUUvtMiIn8wQTWSYEGwe4DjRoSH5CBOMqn6Srkgb789Bn+/smPm4qLCtOkm3jM2d
         7VpA==
X-Forwarded-Encrypted: i=1; AJvYcCV/JZD7mwr0cbaBrb8BC5YEyDYZ/akZcKbNgNwQ/K33OAXAVYpqvklYKTYYJXI9sABNGcCSHOGnHDYIGVRAwwlIW2QrH1Zxs7CljnAquQi/
X-Gm-Message-State: AOJu0YxXATjT4yV5jI/Lgn4F0e0I3ec+1okTIaQQL0Q9sWnmZkfHjhi6
	Cp+hlVUy/JaH1Oyu8y9uEtKsPmMHLHd5ZNJjH9/QftK0Km67CTp00KLWeA9yacA8Vdb/4S3/2IF
	hkYdJYplvyA==
X-Google-Smtp-Source: AGHT+IGLzJKqNE8nNJFCYfxrPfVH9NDTHcNE6vKZzW5PjJBzTU2L1tGxUO1tqukBPzHMTIE1Jt7R8nK+3yAFHQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:e752:b0:1f9:aafc:1ebb with SMTP
 id d9443c01a7336-1fa1d6b39f4mr15984145ad.13.1719378508065; Tue, 25 Jun 2024
 22:08:28 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:08:17 +0000
In-Reply-To: <20240626050818.2277273-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626050818.2277273-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626050818.2277273-4-jiaqiyan@google.com>
Subject: [PATCH v6 3/4] selftest/mm: test enable_soft_offline behaviors
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, rdunlap@infradead.org, ioworker0@gmail.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add regression and new tests when hugepage has correctable memory
errors, and how userspace wants to deal with it:
* if enable_soft_offline=1, mapped hugepage is soft offlined
* if enable_soft_offline=0, mapped hugepage is intact

Free hugepages case is not explicitly covered by the tests.

Hugepage having corrected memory errors is emulated with
MADV_SOFT_OFFLINE.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 228 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 4 files changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 0b9ab987601c..064e7b125643 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -6,6 +6,7 @@ hugepage-shm
 hugepage-vmemmap
 hugetlb-madvise
 hugetlb-read-hwpoison
+hugetlb-soft-offline
 khugepaged
 map_hugetlb
 map_populate
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 3b49bc3d0a3b..d166067d75ef 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -42,6 +42,7 @@ TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
 TEST_GEN_FILES += hugetlb-read-hwpoison
+TEST_GEN_FILES += hugetlb-soft-offline
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
new file mode 100644
index 000000000000..cde82705499b
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test soft offline behavior for HugeTLB pages:
+ * - if enable_soft_offline = 0, hugepages should stay intact and soft
+ *   offlining failed with EOPNOTSUPP.
+ * - if enable_soft_offline = 1, a hugepage should be dissolved and
+ *   nr_hugepages/free_hugepages should be reduced by 1.
+ *
+ * Before running, make sure more than 2 hugepages of default_hugepagesz
+ * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
+ *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <linux/magic.h>
+#include <linux/memfd.h>
+#include <sys/mman.h>
+#include <sys/statfs.h>
+#include <sys/types.h>
+
+#include "../kselftest.h"
+
+#ifndef MADV_SOFT_OFFLINE
+#define MADV_SOFT_OFFLINE 101
+#endif
+
+#define EPREFIX " !!! "
+
+static int do_soft_offline(int fd, size_t len, int expect_errno)
+{
+	char *filemap = NULL;
+	char *hwp_addr = NULL;
+	const unsigned long pagesize = getpagesize();
+	int ret = 0;
+
+	if (ftruncate(fd, len) < 0) {
+		ksft_perror(EPREFIX "ftruncate to len failed");
+		return -1;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		ksft_perror(EPREFIX "mmap failed");
+		ret = -1;
+		goto untruncate;
+	}
+
+	memset(filemap, 0xab, len);
+	ksft_print_msg("Allocated %#lx bytes of hugetlb pages\n", len);
+
+	hwp_addr = filemap + len / 2;
+	ret = madvise(hwp_addr, pagesize, MADV_SOFT_OFFLINE);
+	ksft_print_msg("MADV_SOFT_OFFLINE %p ret=%d, errno=%d\n",
+		       hwp_addr, ret, errno);
+	if (ret != 0)
+		ksft_perror(EPREFIX "madvise failed");
+
+	if (errno == expect_errno)
+		ret = 0;
+	else {
+		ksft_print_msg("MADV_SOFT_OFFLINE should ret %d\n",
+			       expect_errno);
+		ret = -1;
+	}
+
+	munmap(filemap, len);
+untruncate:
+	if (ftruncate(fd, 0) < 0)
+		ksft_perror(EPREFIX "ftruncate back to 0 failed");
+
+	return ret;
+}
+
+static int set_enable_soft_offline(int value)
+{
+	char cmd[256] = {0};
+	FILE *cmdfile = NULL;
+
+	if (value != 0 && value != 1)
+		return -EINVAL;
+
+	sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value);
+	cmdfile = popen(cmd, "r");
+
+	if (cmdfile)
+		ksft_print_msg("enable_soft_offline => %d\n", value);
+	else {
+		ksft_perror(EPREFIX "failed to set enable_soft_offline");
+		return errno;
+	}
+
+	pclose(cmdfile);
+	return 0;
+}
+
+static int read_nr_hugepages(unsigned long hugepage_size,
+			     unsigned long *nr_hugepages)
+{
+	char buffer[256] = {0};
+	char cmd[256] = {0};
+
+	sprintf(cmd, "cat /sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages",
+		hugepage_size);
+	FILE *cmdfile = popen(cmd, "r");
+
+	if (cmdfile == NULL) {
+		ksft_perror(EPREFIX "failed to popen nr_hugepages");
+		return -1;
+	}
+
+	if (!fgets(buffer, sizeof(buffer), cmdfile)) {
+		ksft_perror(EPREFIX "failed to read nr_hugepages");
+		pclose(cmdfile);
+		return -1;
+	}
+
+	*nr_hugepages = atoll(buffer);
+	pclose(cmdfile);
+	return 0;
+}
+
+static int create_hugetlbfs_file(struct statfs *file_stat)
+{
+	int fd;
+
+	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
+	if (fd < 0) {
+		ksft_perror(EPREFIX "could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(file_stat, 0, sizeof(*file_stat));
+	if (fstatfs(fd, file_stat)) {
+		ksft_perror(EPREFIX "fstatfs failed");
+		goto close;
+	}
+	if (file_stat->f_type != HUGETLBFS_MAGIC) {
+		ksft_print_msg(EPREFIX "not hugetlbfs file\n");
+		goto close;
+	}
+
+	return fd;
+close:
+	close(fd);
+	return -1;
+}
+
+static void test_soft_offline_common(int enable_soft_offline)
+{
+	int fd;
+	int expect_errno = enable_soft_offline ? 0 : EOPNOTSUPP;
+	struct statfs file_stat;
+	unsigned long hugepagesize_kb = 0;
+	unsigned long nr_hugepages_before = 0;
+	unsigned long nr_hugepages_after = 0;
+	int ret;
+
+	ksft_print_msg("Test soft-offline when enabled_soft_offline=%d\n",
+		       enable_soft_offline);
+
+	fd = create_hugetlbfs_file(&file_stat);
+	if (fd < 0)
+		ksft_exit_fail_msg("Failed to create hugetlbfs file\n");
+
+	hugepagesize_kb = file_stat.f_bsize / 1024;
+	ksft_print_msg("Hugepagesize is %ldkB\n", hugepagesize_kb);
+
+	if (set_enable_soft_offline(enable_soft_offline)) {
+		close(fd);
+		ksft_exit_fail_msg("Failed to set enable_soft_offline\n");
+	}
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0) {
+		close(fd);
+		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
+	}
+
+	ksft_print_msg("Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		       nr_hugepages_before);
+
+	ret = do_soft_offline(fd, 2 * file_stat.f_bsize, expect_errno);
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
+		close(fd);
+		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
+	}
+
+	ksft_print_msg("After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_after);
+
+	// No need for the hugetlbfs file from now on.
+	close(fd);
+
+	if (enable_soft_offline) {
+		if (nr_hugepages_before != nr_hugepages_after + 1) {
+			ksft_test_result_fail("MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
+			return;
+		}
+	} else {
+		if (nr_hugepages_before != nr_hugepages_after) {
+			ksft_test_result_fail("MADV_SOFT_OFFLINE reduced %lu hugepages\n",
+				nr_hugepages_before - nr_hugepages_after);
+			return;
+		}
+	}
+
+	ksft_test_result(ret == 0,
+			 "Test soft-offline when enabled_soft_offline=%d\n",
+			 enable_soft_offline);
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	test_soft_offline_common(1);
+	test_soft_offline_common(0);
+
+	ksft_finished();
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3157204b9047..781117fac1ba 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -331,6 +331,10 @@ CATEGORY="hugetlb" run_test ./thuge-gen
 CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
 CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
 if $RUN_DESTRUCTIVE; then
+nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
+echo 8 > /proc/sys/vm/nr_hugepages
+CATEGORY="hugetlb" run_test ./hugetlb-soft-offline
+echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
 CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
 fi
 
-- 
2.45.2.741.gdbec12cfda-goog


