Return-Path: <linux-kselftest+bounces-11712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A073890467B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A8286C3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20C15444B;
	Tue, 11 Jun 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yMO8slo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C315383F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142954; cv=none; b=I04QwYkUXS3g6gcb+WU79dUC1+l0XbLCAP0R5BLoVfNKJU/WhOENt059d+nXZlRaXU0SiPmug8r4WN50M6rA3OksFEuDzrVttI8WDkZK0hVteHUysfR+7V3pgK2ZxRxQj+YIA6Z4ytoTPfYFs1/6RCzKfxJW6BwFF4oub+oNMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142954; c=relaxed/simple;
	bh=GBgET4fmwGb9lrtGJyLygNttYS2f5thC1cbI31Pc68k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oTIMYP5iuXmoUTBONEUZUON3gS2+lX76GfY4jc3sWRq1RG8NuJjbOvCxXcPMdgyU4vKY+Yb5XiWlZQa1vH8pCxGonePNAVlUmA0LTlLcVOw+Pl6GoMHtG1yN3Xxn7UAzPrEmZDNDBQlkps5v875anlblmbKS8lByvHoTS1APzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yMO8slo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee902341c0so8456338276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718142951; x=1718747751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyQTVglq7Cwm4lMbb1naXFnTTx4rj2liHiRoRZq6pME=;
        b=4yMO8slo8a6cR3UUMQS7Mn0iqLcHUzGPWgsQ+mxCLtPLkA/jfwbpKK2DAc6QoM0Ukv
         QYK9XgSOyJos/a2Ey69fuJ8LLWWBhGpc3/IYDtSrKcXrT+Z/0hT+9wRKmbzdY4nzT/Fg
         CKw8i0COwsZJzwj3c4mwWqm0xUsiGTSHlUn9hLFYLX4yqj9X84xWBvVmrC/9WNFg0Zvu
         VNF2xEIwlQIl6yAFZ4QzOSRiHpa3HfIlrig6l7bhs3VuDn322XUTgFEenFI0dK0ww5DO
         +htkDVHwdv/0ROp163o5IvZnIvQ6drAhEaXIXNwVkSwthOPSHSPplA3Utu1o4hWLXzcy
         dYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142951; x=1718747751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyQTVglq7Cwm4lMbb1naXFnTTx4rj2liHiRoRZq6pME=;
        b=X6spCla4cJfidEYqJAb8Jmlnhje9tJ47+AxPjUc4fboreWe9YnEOQCR/o0LjaQa4+i
         elLaBjJvMsjXj+4TDmLbca4EGOex9RIDik1KvErJP8sd3JzYor3xFRl48y5RF5skSH5A
         zoeNb02vnHewzW9w5I+H0oH8UAudr8tHdNeijbZF7NUeIa5dMIzSKDASfoP2h6mBVOc7
         wlb9KJOqaa3S1QBHJ7a2iHKvhk93SepwkNLb32qwkIQjjx6ZFJeGMqhOX0T/BuJeCfN1
         XeG5+YeIgeLBql9nwUiy4UHXIMpNJ8ypj0/Mic6uGEhLFJLF3klZyzeBHhxHDjuRMDe2
         UnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgII8YBekzSHcgQTlMhVcXf8Mwfve/7VlXmgSR5pssGcz9lNDo1AuWPOnoN4khtBWLWQk+lZli1/SuKDKDknXAPmecBkXsTZg/8YIybIQ7
X-Gm-Message-State: AOJu0Yy/ibkg5yfRlq/VczjuLMPFRLU8ZDGKQZJgpEEv3elUp7xPb3G1
	p4gaJqLuwvdHeEAK6uPW+2A+C5sBYzHaXgQnDwPhSpjh4kMuO3NifypmpCqXrecqKzMLxcl3qYO
	AMUYTaV42Uw==
X-Google-Smtp-Source: AGHT+IEHVqmqrs5fNX0G2Rm+19MY544u/GPqOHKCJXOP123n1O4Le3p4ZuHF3jDVgujwWTc0zwNSeaeRWk5Crg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:1248:b0:df4:a393:8769 with SMTP
 id 3f1490d57ef6-dfaf65ba959mr1328238276.9.1718142951291; Tue, 11 Jun 2024
 14:55:51 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:55:43 +0000
In-Reply-To: <20240611215544.2105970-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611215544.2105970-3-jiaqiyan@google.com>
Subject: [PATCH v2 2/3] selftest/mm: test enable_soft_offline behaviors
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add regression and new tests when hugepage has correctable memory
errors, and how userspace wants to deal with it:
* if enable_soft_offline=0, mapped hugepage is soft offlined
* if enable_soft_offline=1, mapped hugepage is intact

Free hugepages case is not explicitly covered by the tests.

Hugepage having corrected memory errors is emulated with
MADV_SOFT_OFFLINE.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 258 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 4 files changed, 264 insertions(+)
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
index 000000000000..d37d68a433e7
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test soft offline behavior for HugeTLB pages:
+ * - if enable_soft_offline = 0, hugepages should stay intact and soft
+ *   offlining failed with EINVAL.
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
+#ifndef MADV_SOFT_OFFLINE
+#define MADV_SOFT_OFFLINE 101
+#endif
+
+#define PREFIX " ... "
+#define EPREFIX " !!! "
+
+enum test_status {
+	TEST_PASS = 0,
+	TEST_FAILED = 1,
+	// From ${ksft_skip} in run_vmtests.sh.
+	TEST_SKIPPED = 4,
+};
+
+static enum test_status do_soft_offline(int fd, size_t len, int expect_ret)
+{
+	char *filemap = NULL;
+	char *hwp_addr = NULL;
+	const unsigned long pagesize = getpagesize();
+	int ret = 0;
+	enum test_status status = TEST_SKIPPED;
+
+	if (ftruncate(fd, len) < 0) {
+		perror(EPREFIX "ftruncate to len failed");
+		return status;
+	}
+
+	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (filemap == MAP_FAILED) {
+		perror(EPREFIX "mmap failed");
+		goto untruncate;
+	}
+
+	memset(filemap, 0xab, len);
+	printf(PREFIX "Allocated %#lx bytes of hugetlb pages\n", len);
+
+	hwp_addr = filemap + len / 2;
+	ret = madvise(hwp_addr, pagesize, MADV_SOFT_OFFLINE);
+	printf(PREFIX "MADV_SOFT_OFFLINE %p ret=%d, errno=%d\n",
+	       hwp_addr, ret, errno);
+	if (ret != 0)
+		perror(EPREFIX "madvise failed");
+
+	if (errno == expect_ret)
+		status = TEST_PASS;
+	else {
+		printf(EPREFIX "MADV_SOFT_OFFLINE should ret %d\n", expect_ret);
+		status = TEST_FAILED;
+	}
+
+	munmap(filemap, len);
+untruncate:
+	if (ftruncate(fd, 0) < 0)
+		perror(EPREFIX "ftruncate back to 0 failed");
+
+	return status;
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
+	if (cmdfile == NULL)
+		perror(EPREFIX "failed to set enable_soft_offline");
+	else
+		printf(PREFIX "enable_soft_offline => %d\n", value);
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
+	if (!fgets(buffer, sizeof(buffer), cmdfile)) {
+		perror(EPREFIX "failed to read nr_hugepages");
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
+		perror(EPREFIX "could not open hugetlbfs file");
+		return -1;
+	}
+
+	memset(file_stat, 0, sizeof(*file_stat));
+	if (fstatfs(fd, file_stat)) {
+		perror(EPREFIX "fstatfs failed");
+		goto close;
+	}
+	if (file_stat->f_type != HUGETLBFS_MAGIC) {
+		printf(EPREFIX "not hugetlbfs file\n");
+		goto close;
+	}
+
+	return fd;
+close:
+	close(fd);
+	return -1;
+}
+
+static enum test_status test_soft_offline(void)
+{
+	int fd;
+	struct statfs file_stat;
+	unsigned long hugepagesize_kb = 0;
+	unsigned long nr_hugepages_before = 0;
+	unsigned long nr_hugepages_after = 0;
+	enum test_status status = TEST_SKIPPED;
+
+	printf("Test Soft Offline When softoffline_corrected_errors=1\n");
+
+	fd = create_hugetlbfs_file(&file_stat);
+	if (fd < 0) {
+		printf(EPREFIX "Failed to create hugetlbfs file\n");
+		return status;
+	}
+
+	hugepagesize_kb = file_stat.f_bsize / 1024;
+	printf(PREFIX "Hugepagesize is %ldkB\n", hugepagesize_kb);
+
+	if (set_enable_soft_offline(1))
+		return TEST_FAILED;
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0)
+		return TEST_FAILED;
+
+	printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_before);
+
+	status = do_soft_offline(fd, 2 * file_stat.f_bsize, /*expect_ret=*/0);
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0)
+		return TEST_FAILED;
+
+	printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_after);
+
+	if (nr_hugepages_before != nr_hugepages_after + 1) {
+		printf(EPREFIX "MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
+		return TEST_FAILED;
+	}
+
+	return status;
+}
+
+static enum test_status test_disable_soft_offline(void)
+{
+	int fd;
+	struct statfs file_stat;
+	unsigned long hugepagesize_kb = 0;
+	unsigned long nr_hugepages_before = 0;
+	unsigned long nr_hugepages_after = 0;
+	enum test_status status = TEST_SKIPPED;
+
+	printf("Test Soft Offline When softoffline_corrected_errors=0\n");
+
+	fd = create_hugetlbfs_file(&file_stat);
+	if (fd < 0) {
+		printf(EPREFIX "Failed to create hugetlbfs file\n");
+		return status;
+	}
+
+	hugepagesize_kb = file_stat.f_bsize / 1024;
+	printf(PREFIX "Hugepagesize is %ldkB\n", hugepagesize_kb);
+
+	if (set_enable_soft_offline(0))
+		return TEST_FAILED;
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0)
+		return TEST_FAILED;
+
+	printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_before);
+
+	status = do_soft_offline(fd, 2 * file_stat.f_bsize, /*expect_ret=*/EINVAL);
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0)
+		return TEST_FAILED;
+
+	printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_after);
+
+	if (nr_hugepages_before != nr_hugepages_after) {
+		printf(EPREFIX "MADV_SOFT_OFFLINE reduced %lu hugepages\n",
+			nr_hugepages_before - nr_hugepages_after);
+		return TEST_FAILED;
+	}
+
+	return status;
+}
+
+int main(void)
+{
+	enum test_status status;
+
+	status = test_soft_offline();
+	if (status != TEST_PASS)
+		return status;
+
+	status = test_disable_soft_offline();
+	if (status != TEST_PASS)
+		return status;
+
+	printf("Test Soft Offline All Good!\n");
+	return TEST_PASS;
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
2.45.2.505.gda0bf45e8d-goog


