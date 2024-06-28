Return-Path: <linux-kselftest+bounces-12948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC291C7B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48F71F23890
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A77CF25;
	Fri, 28 Jun 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMYQs9lo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FC7D3EF
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608408; cv=none; b=h39WlDI6TmYg+JKWXr4Yu3NaPtCF6E3eaNvzEP78P23tuaeYEKVAGZZjk7kikG6GYL/gNm8SFIHstgpc/a1thgFO/AmUvx5LO92OoXhJHzNAWlVHHWTpW6vz03Q6S3Inl8TPEl/cbymsoelUE40rORcM7JVdEOE+MJcao2Dnz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608408; c=relaxed/simple;
	bh=LCHGGY1EFfDIspqK5SqQqCOmxTMgsqMadH69D/F1Wdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJ9WSW/bcTMuHp5v3R/higzcH1THdXI3+eDuGOBDMP2JN0GIfuBCqKr7Yw3rcKRviqWjhWE1g7+iQWl+bFbL3cNrr/EtR+AvlYsU4keR15t14gHMuz7t8aNkBHxUfyJADqTcmPbxhaEq+BdTHaw7znN60FueDmIpTBn3U5Wye6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMYQs9lo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-70d8b7924e7so819309a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719608406; x=1720213206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX2k2Odth3Czy1UPzCvu++jrFt8goB6d9yMZ+ndJ/Y8=;
        b=lMYQs9lo8P6kgKnZ5H4AiBDvG3FlExWioL/d0lMa12KfCEwOMafFSwfeiQudFl8/lp
         Epc01pzPfYa/CMgGjb7USQjFjaJputJ0Iw16/pqavzcNHgATOcFae5A6gCJ26+9PFsEk
         fv8yqELJ2iVLjnQIjuEoSCWMqDfVRLHlU3q7zalVj0Eiuk30KJe6Eb1L7wM6BWIoiwAR
         9z5sQmETBrKMbMa5BMr/+yeOYZ9PjEgcFEnql2fBT9kBh0Ntr/2U1wMf9PcBLeVh2qtu
         pV4jrPrJkC53wnySpDpiUlsYwi96BIxLsgHReXEO1qGks0XDQjD86Ax4UD7Mrn78AFvi
         k4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608406; x=1720213206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LX2k2Odth3Czy1UPzCvu++jrFt8goB6d9yMZ+ndJ/Y8=;
        b=U5E/ey5EntJh25a/+MA7Wo7UxFbdztAXrzwtN8/4vvghT6at242Fl1WofbZnDfdzll
         A4mx6oNu91bJAejTWyvxHLE/7y4/RyQTDPEqsiAleK2fRQ3DZc8kbTKHagtdcnPuZ9xW
         KbnCtjgPwR7jyZgXIh4cWO/q71o1/8aI/W1R2MEbf7ItSaTWO3G+6MUxufnAtWmiYFAt
         PAf9rRp+19H4UR4ri3h/KmCMPZ7cIcPr/a4rYnLM5Wdkv3TsnxpxqRKrQE8ezSjLxHeC
         3aHrFjfGwIbrcNDfG406LtzxEDugEytPjansTz9OAg+jsmjJd7dqwlCOVcKOFao/s8pc
         hRcw==
X-Forwarded-Encrypted: i=1; AJvYcCU2y4jCLD8MVx+tSl3sf2yZ9VKkCXaFGkzmumoeunhAMAyPNyL7VQOI/ezYbw/PyoFYexBqWzE3RkNGRke4p++TUPEg627+A/Cvj593pX6t
X-Gm-Message-State: AOJu0YxmYNocYeipQEzihrolQkGLLIrHQ1k0ocp9WJPHtYBaJN6foLp0
	+jN/m8vQX4K4d3+Cx9Nb4noSZAjL9wzR7TJ5xKOtsrj0QLs+Fgpy7Y3aKAmYU17hXYiWN/6TJLM
	On0pbb4Kxgw==
X-Google-Smtp-Source: AGHT+IEOnM2DmpIwo9UplyJX5c7ScIunYeQjWO3FSTx8VD2hKPYukIltq7alsOpJeqnRkjeE7/AeNNFxxG+TFA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:7151:0:b0:6e5:9777:4b0a with SMTP id
 41be03b00d2f7-71a39d74f05mr42746a12.8.1719608405925; Fri, 28 Jun 2024
 14:00:05 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:59:57 +0000
In-Reply-To: <20240628205958.2845610-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628205958.2845610-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628205958.2845610-4-jiaqiyan@google.com>
Subject: [PATCH v7 3/4] selftest/mm: test enable_soft_offline behaviors
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, ioworker0@gmail.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, shuah@kernel.org, rdunlap@infradead.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, ak@linux.intel.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add regression and new tests when hugepage has correctable memory
errors, and how userspace wants to deal with it:
* if enable_soft_offline=1, mapped hugepage is soft offlined
* if enable_soft_offline=0, mapped hugepage is intact

Free hugepages case is not explicitly covered by the tests.

Hugepage having corrected memory errors is emulated with
MADV_SOFT_OFFLINE.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 228 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 4 files changed, 236 insertions(+)
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
index 0d96c6123636..e1aa09ddaa3d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -43,6 +43,7 @@ TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
 TEST_GEN_FILES += hugetlb-read-hwpoison
+TEST_GEN_FILES += hugetlb-soft-offline
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
new file mode 100644
index 000000000000..f086f0e04756
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
+	if (set_enable_soft_offline(enable_soft_offline) != 0) {
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
index 5698d519170d..03ac4f2e1cce 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -332,6 +332,12 @@ CATEGORY="hugetlb" run_test ./thuge-gen
 CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
 CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
 if $RUN_DESTRUCTIVE; then
+nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
+enable_soft_offline=$(cat /proc/sys/vm/enable_soft_offline)
+echo 8 > /proc/sys/vm/nr_hugepages
+CATEGORY="hugetlb" run_test ./hugetlb-soft-offline
+echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
+echo "$enable_soft_offline" > /proc/sys/vm/enable_soft_offline
 CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
 fi
 
-- 
2.45.2.803.g4e1b14247a-goog


