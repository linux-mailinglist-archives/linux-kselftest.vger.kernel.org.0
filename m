Return-Path: <linux-kselftest+bounces-11069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA08D6BA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4271C24A87
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3CA7A15C;
	Fri, 31 May 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fF7lQ7OZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CAF78C9C
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191292; cv=none; b=N4QSIpEV3CAW9+vG1RFkXFLtsndFIHUTXlVYdKGhvCWvgi9YS+4Mz5Lztt1mzlJ97q1AOBrP9G8j5LUDWeirluLO2Xi1vsCzCqaZaYYUl6j1QEhuskjIymX9MDoi59gMFpcBwViGf5GCgHMTZEYLPBlJbYsjO4u5RlutM0y0OFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191292; c=relaxed/simple;
	bh=02UTbjLfjgvn+fb0W08wz5Qre+KmhSWe3wIJbMHnF3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AIN0W6TfLOOwJWH/IwkHnoNWg4rlMHPdnUpTwfKByUVhoAqbeImi1BtPcK8VqZ8RNMOt4aW4FfmcFOHqnuLsW25c50zAsKNXDUHaYthcZ6eCV/RvCwXPl9zEFuk5rdmwwNX2ZeZZh2sQm16Dbo3qz5cSFHsH6q8DsbHp83j5LXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fF7lQ7OZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df77196089eso3667945276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717191289; x=1717796089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSzGyHzMerzTaST3R5/MMuosQBVUwsZqbBH4EMH0Fg0=;
        b=fF7lQ7OZovcbZHT9xm5N6BMkprDB3vILPJrJ/12cPS4GaLN32L2kkzIlC1GgllKZxk
         TDvCTWDcBXghj/IqnyWDnngsjUnyreuYfXrycIEOcxC0nEfZMDbrTE0+ugkp6ArZ9I9t
         5Cerrkez+gzS94nNopIYEPHFeGYtnNQxrtQ8AlFPtDXpXWs5YWT9hazbs4lqPRSCV/Gk
         Vnwn0ILTQKs6vrPEYRie3KH/V9EacYRHLSLNsZLBtwtzIzOl7uI29b/0ejaY4m5Aq/xg
         I7dvquHTPVwesFVgJh0brLWVeERctRQKwpSnlAsu4XoqXBuA+2ar+rDtzAAAmu05Tcjl
         PsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191289; x=1717796089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSzGyHzMerzTaST3R5/MMuosQBVUwsZqbBH4EMH0Fg0=;
        b=jI4J0fwPjKi+n3Ncezyg9xjdy71/n/h3HmwxXAbZTNk9j9mQeX0c1rZFLhqmovPg/F
         yg0lyhnzhC3NX5698LXtwgGTGnKp3SIeKvXd5HynDRLB0s11PfvYO580FyEsrjHO9ZOj
         kmTtLsWX0Z7qgfvYqluaNXie1T3FlXc8Kw3MHhdnzoEVrVB2GkHGQW4baG5cbL5ndd+s
         1ixLa7JBgf6ZBd8MWdtiCOruBGv24UeDJA1SsYcFm0dDDbyOOkIUuCvfsZTMVMDc3++M
         A6rATUjS6j+D5KNkAf/B/mSQ5SiSgEDE0RpYEYp8UJ1DEUomSaKdalzwRoxSali1Diww
         s3qw==
X-Forwarded-Encrypted: i=1; AJvYcCXbhYqB2h9zRx4P0N7kP8sLKQrw5H17VjXRoVUezS1Oi9EZbKQw/n61A94oJ8A1Sg2xXJacCJ15WggsoJV3SlHXU8pslKHjt5byQ9k+oM5q
X-Gm-Message-State: AOJu0Yzq/gocRgo7e5GDHNekctZUex1dT7fpTGfO0FK0PVPc/4FNDZR6
	1NNA65ROQOGo5w1ECKwGIzMDgIA15vwu7+nbPW9yS1cNSn5wRd0t4ijVx/63FTM0TA7y7YEAuO1
	y34WyN58kWw==
X-Google-Smtp-Source: AGHT+IEQi1nZ7QRqcXRTdtpnROLucQXBPkROpipk0R8nebc5FNrDvH4o9mUOqbtoIoIFxgTSbLnzJMZjzIErxw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:1003:b0:df7:62ec:c517 with SMTP
 id 3f1490d57ef6-dfa73dba365mr150746276.11.1717191288972; Fri, 31 May 2024
 14:34:48 -0700 (PDT)
Date: Fri, 31 May 2024 21:34:38 +0000
In-Reply-To: <20240531213439.2958891-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531213439.2958891-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531213439.2958891-3-jiaqiyan@google.com>
Subject: [PATCH v1 2/3] selftest/mm: test softoffline_corrected_errors behaviors
From: Jiaqi Yan <jiaqiyan@google.com>
To: naoya.horiguchi@nec.com, muchun.song@linux.dev, linmiaohe@huawei.com
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add regression and new tests when hugepage has correctable memory
errors, and how userspace wants to deal with it:
* if softoffline_corrected_errors=0, mapped hugepage is soft offlined
* if softoffline_corrected_errors=1, mapped hugepage is intact

Free hugepages case is not explicitly covered by the tests.

Hugepage having corrected memory errors is emulated with
MADV_SOFT_OFFLINE.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 262 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 4 files changed, 268 insertions(+)
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
index 000000000000..8d1d7d4a84d8
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test soft offline behavior for HugeTLB pages:
+ * - if softoffline_corrected_errors = 0, hugepages should stay intact and soft
+ *   offlining failed with EINVAL.
+ * - if softoffline_corrected_errors > 0, a hugepage should be dissolved and
+ *   nr_hugepages should be reduced by 1.
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
+static int set_softoffline_corrected_errors(unsigned long hugepage_size, int value)
+{
+	char cmd[256] = {0};
+	FILE *cmdfile = NULL;
+
+	if (value != 0 && value != 1)
+		return -EINVAL;
+
+	sprintf(cmd,
+		"echo %d > /sys/kernel/mm/hugepages/hugepages-%ldkB/softoffline_corrected_errors",
+		value, hugepage_size);
+	cmdfile = popen(cmd, "r");
+
+	if (cmdfile == NULL)
+		perror(EPREFIX "failed to set softoffline_corrected_errors");
+	else
+		printf(PREFIX
+		       "softoffline_corrected_errors=%d for %ldkB hugepages\n",
+		       value, hugepage_size);
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
+	if (set_softoffline_corrected_errors(hugepagesize_kb, 1))
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
+	if (set_softoffline_corrected_errors(hugepagesize_kb, 0))
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
index 3157204b9047..91db9971ba69 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -332,6 +332,10 @@ CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
 CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
 if $RUN_DESTRUCTIVE; then
 CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
+nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
+echo 8 > /proc/sys/vm/nr_hugepages
+CATEGORY="hugetlb" run_test ./hugetlb-soft-offline
+echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
 fi
 
 if [ $VADDR64 -ne 0 ]; then
-- 
2.45.1.288.g0e0cd299f1-goog


