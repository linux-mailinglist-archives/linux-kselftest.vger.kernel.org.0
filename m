Return-Path: <linux-kselftest+bounces-35539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38576AE292A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFAB18980DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A51F76A5;
	Sat, 21 Jun 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL9pfZNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734B11CA9;
	Sat, 21 Jun 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750512623; cv=none; b=R49jNudPn5x1uNmpiEw07/B48uJLvyG/iTaOkObgRH1pk8ZzAAf43N4BQelG7AAqcfZKWklP12/DEmkuulAdVZWF5zT6I2BsvqVenNfmvJSB2k/S01yTdWrmSHSAjlP43cUjEMKhfH3GdQSWQKqAzt5MoQjna8a0T9ki5FqKrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750512623; c=relaxed/simple;
	bh=7EDuQNpDg5Zu99VkJWjuHrYseVr0Tn66XDPebcVdedE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qyn4WoE03rsJWPGBqvAs5r+9gjrjfSpVTo/leCXBPBcKWqDw7xvlF9LhKKx12RraGYgd/UVtdlQSv40rcmEUG6UXvnlc46Z41ipet1I5w1vVQZ47vHnk1yPWW0cI6fFkmZVGG3ipEDWPVUc3u1PwnahIe5yEjmOkZcOopKB/fCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL9pfZNm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so3181678a12.2;
        Sat, 21 Jun 2025 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750512621; x=1751117421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ba6hvi5I10v0KDgTvmfI9Js/MJvGg3xuS26eE2n7BsE=;
        b=FL9pfZNmW46ipW94lcF+7gm/0s8zmg3nuPiwSJjYs7bwdDVeGXmzVVK2pfctVxH7X2
         L/gkxpAaBBxOwHiUUFMUTc3Q1VnpFQseQCa4R2bZBU4oqIHNTCrV0JvImvuWSxMMK7Ip
         aJez7maABwDoiH60f2DI6CqkgKeGhC88uYvn0srEdgAAjafpIPm/XNSSeOiSpMGVx11P
         q+SGV01tb5IHG0uh7qGlANmyGutl40QERMMOodl9zZz1IrcHUm5z8jH0u9HaLsMHacG+
         QztN9zDUYV2dtkfxR+GfSAUszaF+5WW/lwtAXo78OHEJXv0jwbfJ0z2iJRImPZI4UHFU
         HxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750512621; x=1751117421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ba6hvi5I10v0KDgTvmfI9Js/MJvGg3xuS26eE2n7BsE=;
        b=gd8zda/Y1CqYNzuL23A7ZMRkqCsM0TJjf/m3hliZaDm6gyBUHiSq0HGxehLrR11ygX
         oaHfT3CV143FOBuolDkvWBvF+5EuCe/6K6GCRZyj2amTArZC5c3cr1mDkcMemZxuyZuv
         OVBXfi/PF/tkBn04XImYO2rCHprRYGm1E6A5HtDudRpK+iJZ6F1sODgWz0N800/DcvIQ
         AKXnBIFZJneeYG6JuQfr1ABrcoQOGmEC7kxHSXzo9QI8gyPmkcjyTPaJjgPhREH6bpiP
         bN/33/3/qBGmldwOCn2qgiBd49LgxlfLPSPcDniuDWnhImR3Hb56mt++jKnHMCFUwNzp
         mHCg==
X-Forwarded-Encrypted: i=1; AJvYcCVcz23WTCVcLr58uynqp+VhTpy9jNcz4qMgq8zLrQPBg033Sm7c4aXdCz91l0XKwX7A2/ZlopidV74x6Tg=@vger.kernel.org, AJvYcCX1OHNRO929ebueccwNCV4t7u8l/mxr/lX3qkEM4rHZ3M45yeaNcQ5Jzj1kVnP4U2z2OWM+OoJs0OYPDPBL5hJs@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhEOFY/ljz8a9tSujQFnJ5Wjfzq/aLQSOmy2ttcd3CQP5g501
	p0mN3GRp06vA7mt3I/bOBH14tbkEyn0U0f6puRvwDHhT7GQF3bcZw89Y
X-Gm-Gg: ASbGncuWtjjqcPrwElzNkpxBgxYglfeLaQCNct+Ea8mv7EhBZ3OXE67o0YUD41hALL1
	stbC9qmPVBDph6r/FCehcMv4o+dNmTAAaxmfuAm/OapqGEyFMlzjaZQnMHygBXEaCwgfXCp0tHp
	WFKMbBc4h81ZKmygF/XCe2vyU7vycXR1vsbBaj4Iimh8/fs5BABqxQKP1nEfnW/LrJETxgONFqy
	4rzKGZ5wlQ3vXEw4iIYQ674qW7y5v21efE7hJ2HPQj6D+JpgiDMMbuG6vDMJehFylHul/87bkGz
	D5iDG49IHIBAqk7BKFDvCykG/eNKLQ/hOYkUtyfQasILJQRlWccFCaSWqWePtvDKYzgBvdsAhss
	+oU/ekg==
X-Google-Smtp-Source: AGHT+IG5l0kSPJkR8H5fdLe5JFToPH93RCB/TbvmqIpTMVgRYpj+s57WMWDtsevqR00yq6oVHvWiyg==
X-Received: by 2002:a17:90b:2703:b0:314:2a2e:9da9 with SMTP id 98e67ed59e1d1-3159d8d661fmr9165484a91.25.1750512620817;
        Sat, 21 Jun 2025 06:30:20 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([111.202.167.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a23e6fbsm6527692a91.14.2025.06.21.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 06:30:20 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	SeongJae Park <sj@kernel.org>,
	zijing.zhang@proton.me,
	ryncsn@gmail.com,
	p1ucky0923@gmail.com,
	gkwang@linx-info.com,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
Date: Sat, 21 Jun 2025 21:30:03 +0800
Message-ID: <20250621133003.4733-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lian Wang <lianux.mm@gmail.com>

Let's add a simple test for MADV_DONTNEED and PROCESS_MADV_DONTNEED,
and inspired by SeongJae Park's test at GitHub[1] add batch test
for PROCESS_MADV_DONTNEED,but for now it influence by workload and
need add some race conditions test.We can add it later.

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
References
==========

[1] https://github.com/sjp38/eval_proc_madvise

---
 tools/testing/selftests/mm/.gitignore      |   1 +
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/madv_dontneed.c | 220 +++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh  |   5 +
 4 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/mm/madv_dontneed.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 824266982aa3..911f39d634be 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -25,6 +25,7 @@ pfnmap
 protection_keys
 protection_keys_32
 protection_keys_64
+madv_dontneed
 madv_populate
 uffd-stress
 uffd-unit-tests
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index ae6f994d3add..2352252f3914 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -67,6 +67,7 @@ TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
 TEST_GEN_FILES += hugepage-vmemmap
 TEST_GEN_FILES += khugepaged
+TEST_GEN_FILES += madv_dontneed
 TEST_GEN_FILES += madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
diff --git a/tools/testing/selftests/mm/madv_dontneed.c b/tools/testing/selftests/mm/madv_dontneed.c
new file mode 100644
index 000000000000..b88444da7f9e
--- /dev/null
+++ b/tools/testing/selftests/mm/madv_dontneed.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MADV_DONTNEED and PROCESS_MADV_DONTNEED tests
+ *
+ * Copyright (C) 2025, Linx Software Corp.
+ *
+ * Author(s): Lian Wang <lianux.mm@gmail.com>
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/mman.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include "vm_util.h"
+#include <time.h>
+
+#include "../kselftest.h"
+
+/*
+ * For now, we're using 2 MiB of private anonymous memory for all tests.
+ */
+#define SIZE (256 * 1024 * 1024)
+
+static size_t pagesize;
+
+static void sense_support(void)
+{
+	char *addr;
+	int ret;
+
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	ret = madvise(addr, pagesize, MADV_DONTNEED);
+	if (ret)
+		ksft_exit_skip("MADV_DONTNEED is not available\n");
+
+	munmap(addr, pagesize);
+}
+
+/*
+ * Read pagemap to check page is present in mermory
+ */
+static bool is_page_present(void *addr)
+{
+	uintptr_t vaddr = (uintptr_t)addr;
+	uintptr_t offset = (vaddr / pagesize) * sizeof(uint64_t);
+	ssize_t bytes_read;
+	uint64_t entry;
+	bool ret;
+	int fd;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0) {
+		ksft_exit_fail_msg("opening pagemap failed\n");
+		ret = false;
+	}
+
+	if ((lseek(fd, offset, SEEK_SET)) == -1) {
+		close(fd);
+		ret = false;
+	}
+
+	bytes_read = read(fd, &entry, sizeof(entry));
+	close(fd);
+
+	if (bytes_read != sizeof(entry)) {
+		perror("read failed");
+		return false;
+	}
+
+	if (entry & (1ULL << 63))
+		ret = true;
+
+	return ret;
+}
+
+/*
+ * test madvsise_dontneed
+ */
+static void test_madv_dontneed(void)
+{
+	unsigned long rss_anon_before, rss_anon_after;
+	bool present, rss;
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	memset(addr, 0x7A, SIZE);
+
+	rss_anon_before = rss_anon();
+	if (!rss_anon_before)
+		ksft_exit_fail_msg("No RssAnon is allocated before dontneed\n");
+	ret = madvise(addr, SIZE, MADV_DONTNEED);
+	ksft_test_result(!ret, "MADV_DONTNEED\n");
+
+	rss_anon_after = rss_anon();
+	if (rss_anon_after < rss_anon_before)
+		rss = true;
+	ksft_test_result(rss, "MADV_DONTNEED rss is correct\n");
+
+	for (size_t i = 0; i < SIZE; i += pagesize) {
+		present = is_page_present(addr + i);
+		if (present) {
+			ksft_print_msg("Page not zero at offset %zu\n",
+				       (size_t)i);
+		}
+	}
+
+	ksft_test_result(!present, "MADV_DONTNEED page is present\n");
+	munmap(addr, SIZE);
+}
+
+/*
+ * Measure performance of batched process_madvise vs madvise
+ */
+static int measure_process_madvise_batching(int hint, int total_size,
+					    int single_unit, int batch_size)
+{
+	struct iovec *vec = malloc(sizeof(*vec) * batch_size);
+	struct timespec start, end;
+	unsigned long elapsed_ns = 0;
+	unsigned long nr_measures = 0;
+	pid_t pid = getpid();
+	char *buf;
+	int pidfd;
+
+	pidfd = syscall(SYS_pidfd_open, pid, 0);
+	if (pidfd == -1) {
+		perror("pidfd_open fail");
+		return -1;
+	}
+
+	buf = mmap(NULL, total_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap fail");
+		goto out;
+	}
+
+	if (!vec) {
+		perror("malloc vec failed");
+		goto unmap_out;
+	}
+
+	while (elapsed_ns < 5UL * 1000 * 1000 * 1000) {
+		memset(buf, 0x7A, total_size);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+
+		for (int off = 0; off < total_size;
+		     off += single_unit * batch_size) {
+			for (int i = 0; i < batch_size; i++) {
+				vec[i].iov_base = buf + off + i * single_unit;
+				vec[i].iov_len = single_unit;
+			}
+			syscall(SYS_process_madvise, pidfd, vec, batch_size,
+				hint, 0);
+		}
+
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		elapsed_ns += (end.tv_sec - start.tv_sec) * 1e9 +
+			      (end.tv_nsec - start.tv_nsec);
+		nr_measures++;
+	}
+
+	ksft_print_msg("[RESULT] batch=%d time=%.3f us/op\n", batch_size,
+		       (double)(elapsed_ns / nr_measures) /
+			       (total_size / single_unit));
+
+	free(vec);
+unmap_out:
+	munmap(buf, total_size);
+out:
+	close(pidfd);
+	return 0;
+}
+
+static void test_perf_batch_process(void)
+{
+	ksft_print_msg("[RUN] %s\n", __func__);
+	measure_process_madvise_batching(MADV_DONTNEED, SIZE, pagesize, 1);
+	measure_process_madvise_batching(MADV_DONTNEED, SIZE, pagesize, 2);
+	measure_process_madvise_batching(MADV_DONTNEED, SIZE, pagesize, 4);
+	ksft_test_result(1, "All test were done\n");
+}
+
+int main(int argc, char **argv)
+{
+	int err;
+
+	pagesize = getpagesize();
+
+	ksft_print_header();
+	ksft_set_plan(4);
+
+	sense_support();
+	test_madv_dontneed();
+	test_perf_batch_process();
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n", err,
+				   ksft_test_num());
+	ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index dddd1dd8af14..f96d43153fc0 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -47,6 +47,8 @@ separated by spaces:
 	hmm smoke tests
 - madv_guard
 	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
+- madv_dontneed
+	test memadvise(2) MADV_DONTNEED and PROCESS_MADV_DONTNEED options
 - madv_populate
 	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
 - memfd_secret
@@ -422,6 +424,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
 CATEGORY="madv_guard" run_test ./guard-regions
 
+# MADV_DONTNEED and PROCESS_DONTNEED tests
+CATEGORY="madv_dontneed" run_test ./madv_dontneed
+
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
-- 
2.43.0


