Return-Path: <linux-kselftest+bounces-12289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4690FA3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 02:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65109B21610
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 00:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578A80B;
	Thu, 20 Jun 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3mtCkuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9F64C;
	Thu, 20 Jun 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843228; cv=none; b=ndIYfXAOYrvR3EYPXxwZgKzcfqXJVM449llf83X+yhC4PoA1ElWrg360J0m0xQSeIXdpr3XSXggfHhI6X8Xyp7BgGel76sboNIrIlApgYURqfFKlMBF3YxnnqtxMc2IDxBVW7xZwhVUFFYWcFL4UsNl5tv+lcrGSfsX0LLznPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843228; c=relaxed/simple;
	bh=bz3ViVq8/ema1ANLsu/KH87HhKpcqFGpBqv5TCzfcMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sznmgb+w4w7WtVUbsU4/r+0sdMBAxtVvFNAxwMO+wEyGpo+VjTjrdl3aBfg4hByncMaC/DBzDAKm0yGih4NV2EcZZ0YuOCsATy9/Oj6oeeOql0BhdGNl9smalC4UopfruY/Zyu96ApOZXP+644sDQOZRZyEZi0n41SxA3p/l6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3mtCkuD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-705bf368037so366924b3a.0;
        Wed, 19 Jun 2024 17:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718843226; x=1719448026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/phkDRQOzz1mys5+rBCaSnbv5F7N/ucY8CBHIGfrx8g=;
        b=W3mtCkuDHY8JEZBWvzlZC3CsTSGi7B4fNaL6hJWPdJY80erW5/7jbt0RMpaNlY0SV+
         b/OVWYzF48xS+meknY0MN00e/+Kf2DDcjeOBfD+A4Z5ui/QW2YVhTnkhahMPwGH83ZVB
         BbD9BKq/OdphaIBpycL9L1RDy9fmxWue3aiGZ1Gf7S2072jom/rh9LAJt1kT5/7If9Em
         85JSinGTfe7Raloe9zOFyPMtIUUJeVRc+cQTcGRGV8pWuxjtz/HZ4nq6b2foV6+Nv/zW
         FtxC56E0kHpTFzkg/uB4GFebVRC/oqrbgizBud1U5Wv4+eSScabGicJXCNMEu5dstSHs
         2sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718843226; x=1719448026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/phkDRQOzz1mys5+rBCaSnbv5F7N/ucY8CBHIGfrx8g=;
        b=et1DN2d15P1YpKZdHq77X0NwYk8OoP4bTiwnIneYqw2CEsHxvSJPrIPNJZW8pGAlEJ
         ddq1G1HFiTCz7fwYorS0TWddQ51SzM0KvZPJdKsZ0tHWutdWMza0xM7C1YWBH8gqDGK3
         hhuDc0CFAfo+Sz2Q6ghidLbvLz625+NKpHvYbcGl8VP4TSsemd+v2qaIZuZ7VNioibxS
         kWqARdk0HTGpmQRE3vgx0eUI7vrC8v+muNbsoV5bCNJAXe5gYMYtgiAeWTNGzHMJE9YK
         PUJclyvQzW6JmUSy5IrVm+2ziSNvj1lOXhONgchF4nPQq2u1Q0qS9ryNeBw2a3Qak5sk
         xZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCULyfndJ1OlymQb7uTvh8vFUaqsbIiyAEhEY4Fvi4DuET7J83sLLwgnqjn67n50UcBw3GB/XL90rU9RQB502yraoaXFvn7D1MdwBVDzpC5XdfRWkX8iZXKCHDI+y63ri9vKgeVOe0+MDM0jmom1
X-Gm-Message-State: AOJu0YwmrBU4BLHriHQzMkC90NtWmYHf/B16shoqCUvLPnPNwf4R5Qhh
	IFw+2JcJiIqK7Cyc32mSmhm8IIbIBfEBGTG33Qljzkpbviwd0Fgx
X-Google-Smtp-Source: AGHT+IEKP///BAxzukR21Dn0SGKbKyRk6+T0rDc0H3AwIZxrIsHI7d6TiHcl1VqbM0vqcWGSiAyMEA==
X-Received: by 2002:a05:6a00:2f43:b0:704:1ac0:bf16 with SMTP id d2e1a72fcca58-70629c1fcbbmr3686506b3a.5.1718843225789;
        Wed, 19 Jun 2024 17:27:05 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967356sm11273385b3a.63.2024.06.19.17.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 17:27:05 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	chrisl@kernel.org,
	david@redhat.com,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ying.huang@intel.com,
	linux-kselftest@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] selftests/mm: Introduce a test program to assess swap entry allocation for thp_swapout
Date: Thu, 20 Jun 2024 12:26:48 +1200
Message-Id: <20240620002648.75204-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Both Ryan and Chris have been utilizing the small test program to aid
in debugging and identifying issues with swap entry allocation. While
a real or intricate workload might be more suitable for assessing the
correctness and effectiveness of the swap allocation policy, a small
test program presents a simpler means of understanding the problem and
initially verifying the improvements being made.

Let's endeavor to integrate it into the self-test suite. Although it
presently only accommodates 64KB and 4KB, I'm optimistic that we can
expand its capabilities to support multiple sizes and simulate more
complex systems in the future as required.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_test.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index e1aa09ddaa3d..64164ad66835 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -65,6 +65,7 @@ TEST_GEN_FILES += mseal_test
 TEST_GEN_FILES += seal_elf
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
+TEST_GEN_FILES += thp_swap_allocator_test
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
new file mode 100644
index 000000000000..4443a906d0f8
--- /dev/null
+++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * thp_swap_allocator_test
+ *
+ * The purpose of this test program is helping check if THP swpout
+ * can correctly get swap slots to swap out as a whole instead of
+ * being split. It randomly releases swap entries through madvise
+ * DONTNEED and do swapout on two memory areas: a memory area for
+ * 64KB THP and the other area for small folios. The second memory
+ * can be enabled by "-s".
+ * Before running the program, we need to setup a zRAM or similar
+ * swap device by:
+ *  echo lzo > /sys/block/zram0/comp_algorithm
+ *  echo 64M > /sys/block/zram0/disksize
+ *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
+ *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
+ *  mkswap /dev/zram0
+ *  swapon /dev/zram0
+ * The expected result should be 0% anon swpout fallback ratio w/ or
+ * w/o "-s".
+ *
+ * Author(s): Barry Song <v-songbaohua@oppo.com>
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <time.h>
+
+#define MEMSIZE_MTHP (60 * 1024 * 1024)
+#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
+#define ALIGNMENT_MTHP (64 * 1024)
+#define ALIGNMENT_SMALLFOLIO (4 * 1024)
+#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
+#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
+#define MTHP_FOLIO_SIZE (64 * 1024)
+
+#define SWPOUT_PATH \
+	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
+#define SWPOUT_FALLBACK_PATH \
+	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback"
+
+static void *aligned_alloc_mem(size_t size, size_t alignment)
+{
+	void *mem = NULL;
+
+	if (posix_memalign(&mem, alignment, size) != 0) {
+		perror("posix_memalign");
+		return NULL;
+	}
+	return mem;
+}
+
+static void random_madvise_dontneed(void *mem, size_t mem_size,
+		size_t align_size, size_t total_dontneed_size)
+{
+	size_t num_pages = total_dontneed_size / align_size;
+	size_t i;
+	size_t offset;
+	void *addr;
+
+	for (i = 0; i < num_pages; ++i) {
+		offset = (rand() % (mem_size / align_size)) * align_size;
+		addr = (char *)mem + offset;
+		if (madvise(addr, align_size, MADV_DONTNEED) != 0)
+			perror("madvise dontneed");
+
+		memset(addr, 0x11, align_size);
+	}
+}
+
+static unsigned long read_stat(const char *path)
+{
+	FILE *file;
+	unsigned long value;
+
+	file = fopen(path, "r");
+	if (!file) {
+		perror("fopen");
+		return 0;
+	}
+
+	if (fscanf(file, "%lu", &value) != 1) {
+		perror("fscanf");
+		fclose(file);
+		return 0;
+	}
+
+	fclose(file);
+	return value;
+}
+
+int main(int argc, char *argv[])
+{
+	int use_small_folio = 0;
+	int i;
+	void *mem1 = aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
+	void *mem2 = NULL;
+
+	if (mem1 == NULL) {
+		fprintf(stderr, "Failed to allocate 60MB memory\n");
+		return EXIT_FAILURE;
+	}
+
+	if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) != 0) {
+		perror("madvise hugepage for mem1");
+		free(mem1);
+		return EXIT_FAILURE;
+	}
+
+	for (i = 1; i < argc; ++i) {
+		if (strcmp(argv[i], "-s") == 0)
+			use_small_folio = 1;
+	}
+
+	if (use_small_folio) {
+		mem2 = aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
+		if (mem2 == NULL) {
+			fprintf(stderr, "Failed to allocate 1MB memory\n");
+			free(mem1);
+			return EXIT_FAILURE;
+		}
+
+		if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) != 0) {
+			perror("madvise nohugepage for mem2");
+			free(mem1);
+			free(mem2);
+			return EXIT_FAILURE;
+		}
+	}
+
+	for (i = 0; i < 100; ++i) {
+		unsigned long initial_swpout;
+		unsigned long initial_swpout_fallback;
+		unsigned long final_swpout;
+		unsigned long final_swpout_fallback;
+		unsigned long swpout_inc;
+		unsigned long swpout_fallback_inc;
+		double fallback_percentage;
+
+		initial_swpout = read_stat(SWPOUT_PATH);
+		initial_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
+
+		random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
+				TOTAL_DONTNEED_MTHP);
+
+		if (use_small_folio) {
+			random_madvise_dontneed(mem2, MEMSIZE_SMALLFOLIO,
+					ALIGNMENT_SMALLFOLIO,
+					TOTAL_DONTNEED_SMALLFOLIO);
+		}
+
+		if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) != 0) {
+			perror("madvise pageout for mem1");
+			free(mem1);
+			if (mem2 != NULL)
+				free(mem2);
+			return EXIT_FAILURE;
+		}
+
+		if (use_small_folio) {
+			if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) != 0) {
+				perror("madvise pageout for mem2");
+				free(mem1);
+				free(mem2);
+				return EXIT_FAILURE;
+			}
+		}
+
+		final_swpout = read_stat(SWPOUT_PATH);
+		final_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
+
+		swpout_inc = final_swpout - initial_swpout;
+		swpout_fallback_inc = final_swpout_fallback - initial_swpout_fallback;
+
+		fallback_percentage = (double)swpout_fallback_inc /
+			(swpout_fallback_inc + swpout_inc) * 100;
+
+		printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu, Fallback percentage: %.2f%%\n",
+				i + 1, swpout_inc, swpout_fallback_inc, fallback_percentage);
+	}
+
+	free(mem1);
+	if (mem2 != NULL)
+		free(mem2);
+
+	return EXIT_SUCCESS;
+}
-- 
2.34.1


