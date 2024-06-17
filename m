Return-Path: <linux-kselftest+bounces-12080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC7690B76C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24AE1C20CDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2D16A94B;
	Mon, 17 Jun 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGijsYUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6816A933
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643955; cv=none; b=WS7VtSNSgST9B/WSdlgJmQ7G77gL57E5d3WF/zGpvF2Yqa7GNlVUTIbC57wqgFdnO9s0R3zH1THXk9IXbrRfTyxg9MWgKzBxYJlqxhxUuq64fW/tmHqOrwfPDCQI4qUiTSJAZFAnlqYS2uQTSlHKFkXxGB7Nu6NqSxbv8djkWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643955; c=relaxed/simple;
	bh=x5zdNYq40oMTUMtx51hwmzI2cShWpJGHRO1AZ7syqsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxEHGerP8E+pvpfb3aDJe2DWLqHCuSJVqKuOOmDKo6Lbr16ZK4RgPl5QbVI4ndpTZ+MWvuvsBSRt29HtSYKkIvMjffr5Nzd6meOmvZvlvJUXFeqXJPePRQhYw+0Iloewi1QU16os2qgZaof4F6ftTq8rbpB7t0f+zDEuqE+eYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGijsYUJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff16daff8dso6355900276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718643952; x=1719248752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tevmA1HCzsTVLfVkW48VuStWY2+98Ib3ji+6cFhdVU=;
        b=FGijsYUJleLEanarNUgIlyCGmo507J4fMyBIBeqqE6wwT6cWJXUOzJQA3skg1Iuoom
         arqAV8Z7rD3mJmP43KxRIKmpE+Qi9D8hninyYIG9Ry7X2rqV6KOzxS7d0EmbXtGOXUV1
         ovRqYTIvVUpBDqS6KfxE8zpvI+hcbdj1jLQaz+i0bZIYNgNFyjCPoleKVNak4WlZMnS1
         UFBNCeQG0TfCbTV3Z+S+6lGkLtn7XprghR0gZ2/iDsNGthQvfXMdoCV+na87HUtbQDWA
         H3SHETA/kME3USs9fdXMRmSKftSpbq6Z/49GU9imSkHi9Tp0QODES+krzMLdSZC+xDKk
         A66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643952; x=1719248752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tevmA1HCzsTVLfVkW48VuStWY2+98Ib3ji+6cFhdVU=;
        b=rC60rK0QUxBMSUN6vsQ5NIFpWHu/V4JOyF4efLOIzcHfBGsCLuCM4etc+/dZzXK1sI
         +xGlbUGBWGkNZCiEPbLeUMfR5nvY1IP0lpAoJ8E40gEgMKQWY2350LcxAa0U7+aD2jbn
         7SKdWgjzYLuLAqbXe+36p/BwG3YjxqxlyNoWFV0NF332Uzj0hUowDLxrCCC5AkL+rXba
         6IGn4P23anUtJm9rokwrpiLksVpxhQqI9hsl/6gOl9rUUcwGelBMDXm5ntHCwVSN+GUw
         qplpL19NWAUBttNz78E/L0giJgLU53kAd2dMhReiZPoQrLhQmG4wPDMtaua90JSg5nrE
         WFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmJIIYMpg22iv0fn+bEF17uB/9/DWRClghtK0EkZpuj5IIA/HY5e03IUlXrylVkcA/7fLJdTKypELpZS2LtCvcj0w3bhp7Q6TV5vCHde4C
X-Gm-Message-State: AOJu0Yw3ULszyFkFJWQbotkwVTTh+Ya/Ci05dDODUvWf7ABfwB+zPyyv
	eMCNoHSIep12jeWAsmAs8fuOQTfxLhI0DL1Y3r4OA2pDKOQAd5HmG4w0F/XHAXmuwT8NhTUWbm6
	xqtbotYiNWw==
X-Google-Smtp-Source: AGHT+IHaPH860LoxB8KdOgFhvqZSzGViBlD2JGwLQiFXTHzuc4xC+T3rNtkWpuJIT3TcVn/I2RZqtycsHAYZ7w==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:110e:b0:dfa:b2ca:7a9e with SMTP
 id 3f1490d57ef6-dff15456ffbmr3225706276.8.1718643952522; Mon, 17 Jun 2024
 10:05:52 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:05:44 +0000
In-Reply-To: <20240617170545.3820912-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617170545.3820912-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617170545.3820912-3-jiaqiyan@google.com>
Subject: [PATCH v3 2/3] selftest/mm: test enable_soft_offline behaviors
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
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
 .../selftests/mm/hugetlb-soft-offline.c       | 229 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 4 files changed, 235 insertions(+)
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
index 000000000000..5701eea4ee48
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -0,0 +1,229 @@
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
+	if (cmdfile)
+		printf(PREFIX "enable_soft_offline => %d\n", value);
+	else {
+		perror(EPREFIX "failed to set enable_soft_offline");
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
+		perror(EPREFIX "failed to popen nr_hugepages");
+		return -1;
+	}
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
+static enum test_status test_soft_offline_common(int enable_soft_offline)
+{
+	int fd;
+	int expect_ret = enable_soft_offline ? 0 : EOPNOTSUPP;
+	struct statfs file_stat;
+	unsigned long hugepagesize_kb = 0;
+	unsigned long nr_hugepages_before = 0;
+	unsigned long nr_hugepages_after = 0;
+	enum test_status status = TEST_SKIPPED;
+
+	printf("Test soft-offline when enabled_soft_offline=%d\n",
+		enable_soft_offline);
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
+	if (set_enable_soft_offline(enable_soft_offline))
+		return TEST_FAILED;
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0)
+		return TEST_FAILED;
+
+	printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_before);
+
+	status = do_soft_offline(fd, 2 * file_stat.f_bsize, expect_ret);
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0)
+		return TEST_FAILED;
+
+	printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
+		nr_hugepages_after);
+
+	if (enable_soft_offline) {
+		if (nr_hugepages_before != nr_hugepages_after + 1) {
+			printf(EPREFIX "MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
+			return TEST_FAILED;
+		}
+	} else {
+		if (nr_hugepages_before != nr_hugepages_after) {
+			printf(EPREFIX "MADV_SOFT_OFFLINE reduced %lu hugepages\n",
+				nr_hugepages_before - nr_hugepages_after);
+			return TEST_FAILED;
+		}
+	}
+
+	return status;
+}
+
+int main(void)
+{
+	enum test_status status;
+
+	status = test_soft_offline_common(1);
+	if (status != TEST_PASS)
+		return status;
+
+	status = test_soft_offline_common(0);
+	if (status != TEST_PASS)
+		return status;
+
+	printf("Soft-offline tests all good!\n");
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
2.45.2.627.g7a2c4fd464-goog


