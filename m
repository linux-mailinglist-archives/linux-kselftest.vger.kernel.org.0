Return-Path: <linux-kselftest+bounces-12636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E949A9167BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FD41F242F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33261553B3;
	Tue, 25 Jun 2024 12:24:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77D1553AF;
	Tue, 25 Jun 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318279; cv=none; b=dbIYE5i9EOmT9CxTVjDPcvOMQKx6NlLc4jJsyTawwcsDx9tQWDokmqYDBsHFm5GWz8jDJkIkkdTNCDwGReT00K3jB9EJcJeaOP/VUZs8LEWXSQyctQbP/+XmHRpfz4N8wqWTbc+aZfAvEUNaigEn+Z7kVUeViBDQi29m6DOg46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318279; c=relaxed/simple;
	bh=MVs5z0/RG/otjMsFB/U3mOThMHQjhs1d7gbRxQCETTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSHYiNpsu2uiQm4kCgMgasWFdWyxz0qkq1LXV6X/TIm4Elyu/LD1brYY2uW7/1vclERADUbga/mIeAvXdvNOO0J0xtRoIVGlIeSCFDK9LwY5r9tU3QTbHYCleWOIe+mQJzIaQD25sgqIuRu9R430gZMKdBgnopWOKxtUFANJOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795F5339;
	Tue, 25 Jun 2024 05:25:02 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B600F3F766;
	Tue, 25 Jun 2024 05:24:32 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 1/9] selftests/arm: Add mm test
Date: Tue, 25 Jun 2024 17:54:00 +0530
Message-Id: <20240625122408.1439097-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625122408.1439097-1-dev.jain@arm.com>
References: <20240625122408.1439097-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tests the 4GB VA restriction for 32-bit processes; it is
required to test the compat layer, whether the kernel knows that it is
running a 32-bit process or not. Chunks are allocated until the VA gets
exhausted; mmap must fail beyond 4GB. This is asserted against the VA
mappings found in /proc/self/maps.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
v2->v3:
 - Split into multiple testcases

 tools/testing/selftests/arm/mm/compat_va.c | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/arm/mm/compat_va.c

diff --git a/tools/testing/selftests/arm/mm/compat_va.c b/tools/testing/selftests/arm/mm/compat_va.c
new file mode 100644
index 000000000000..20aa419eff29
--- /dev/null
+++ b/tools/testing/selftests/arm/mm/compat_va.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Author : Dev Jain <dev.jain@arm.com>
+ *
+ * Tests 4GB VA restriction for 32 bit process
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <kselftest.h>
+
+#define MAP_CHUNK_SIZE	SZ_1M
+#define NR_CHUNKS_4G	((SZ_1G / MAP_CHUNK_SIZE) * 4)	/* prevent overflow */
+
+static int validate_address_hint(void)
+{
+	char *ptr;
+
+	ptr = mmap((void *) (1UL << 29), MAP_CHUNK_SIZE, PROT_READ |
+		   PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (ptr == MAP_FAILED)
+		return 0;
+
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	char *ptr[NR_CHUNKS_4G + 3];
+	char line[1000];
+	int chunks;
+	FILE *file;
+	int ret;
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	/* try allocation beyond 4 GB */
+	for (i = 0; i < NR_CHUNKS_4G + 3; ++i) {
+		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+		if (ptr[i] == MAP_FAILED) {
+			if (validate_address_hint())
+				ksft_exit_fail_msg("VA exhaustion failed\n");
+			break;
+		}
+	}
+
+	chunks = i;
+
+	ret = (chunks < NR_CHUNKS_4G);
+	ksft_test_result(ret, "mmapped chunks under 4GB\n");
+
+	/* parse /proc/self/maps, confirm 32 bit VA mappings */
+	file = fopen("/proc/self/maps", "r");
+	if (!file)
+		ksft_exit_fail_perror("/proc/self/maps");
+
+	ret = 0;
+	while (fgets(line, sizeof(line), file)) {
+		const char *whitespace_loc, *hyphen_loc;
+
+		hyphen_loc = strchr(line, '-');
+		whitespace_loc = strchr(line, ' ');
+
+		if (!(hyphen_loc && whitespace_loc))
+			ksft_exit_fail_msg("Unexpected format\n");
+
+		ret |= ((hyphen_loc - line > 8) ||
+			(whitespace_loc - hyphen_loc > 9));
+	}
+
+	ksft_test_result(!ret, "Memory map within 32 bits\n");
+
+	for (i = 0; i < chunks; ++i)
+		munmap(ptr[i], MAP_CHUNK_SIZE);
+
+	ksft_finished();
+}
-- 
2.39.2


