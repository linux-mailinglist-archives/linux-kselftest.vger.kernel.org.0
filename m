Return-Path: <linux-kselftest+bounces-7255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F208899873
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589E5B2231D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031B15FA8F;
	Fri,  5 Apr 2024 08:49:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781B15FA8D;
	Fri,  5 Apr 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306993; cv=none; b=G+GzrbX35Ua8ai4SUqWwsaMcHc0VRpehoLvjg+CmszTuiOid7tkj8XAAIgyn3hOZ1b7cyI0u4Dd9hq4WpZjBTrHVkookL9e/qnF8+u6+MQUj5Yz2SbOziyV1SDVfr6jjMN9Z9dh+u9NXW2oJ9cqFO07hwBkHzRGghkHIdKZJ7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306993; c=relaxed/simple;
	bh=u+HUzxYLCfySfWM6T+hRKqGJDsoBpjm+5Q0bROj9OYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlA/1h7Mccq6ymwpc5bH27eiVbXkyMApANe+k3TWB4wHHnr9UVe0Q4kMQcNEbUMh0B/7iUYlOOxmgb4fPiE8JFhQtmu29KK067ivMs1S9KjhNGWVVmlVkMlOxO8xv1AzPjNzRRFkFiiOrLfD0W00cTl60JcqqtFrO1SLP6uXGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73E7A1007;
	Fri,  5 Apr 2024 01:50:21 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B2C73F64C;
	Fri,  5 Apr 2024 01:49:46 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	suzuki.poulose@arm.com,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	Catalin.Marinas@arm.com,
	broonie@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 1/4] selftests/arm: Add mm test
Date: Fri,  5 Apr 2024 14:14:07 +0530
Message-Id: <20240405084410.256788-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405084410.256788-1-dev.jain@arm.com>
References: <20240405084410.256788-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tests the 4GB VA restriction for 32-bit processes; it is required
to test the compat layer, whether the kernel knows that it is running a 32-bit
process or not. Chunks are allocated until the VA gets exhausted; mmap must
fail beyond 4GB. This is asserted against the VA mappings found
in /proc/self/maps.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm/mm/compat_va.c | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/arm/mm/compat_va.c

diff --git a/tools/testing/selftests/arm/mm/compat_va.c b/tools/testing/selftests/arm/mm/compat_va.c
new file mode 100644
index 000000000000..3a78f240bc87
--- /dev/null
+++ b/tools/testing/selftests/arm/mm/compat_va.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#define NR_CHUNKS_4G	(SZ_1G / MAP_CHUNK_SIZE) * 4	/* prevent overflow */
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
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	char *ptr[NR_CHUNKS_4G + 3];
+	char line[1000];
+	const char *file_name;
+	int chunks;
+	FILE *file;
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(1);
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
+	if (chunks >= NR_CHUNKS_4G) {
+		ksft_test_result_fail("mmapped chunks beyond 4GB\n");
+		ksft_finished();
+	}
+
+	/* parse /proc/self/maps, confirm 32 bit VA mappings */
+	file_name = "/proc/self/maps";
+	file = fopen(file_name, "r");
+	if (file == NULL)
+		ksft_exit_fail_msg("/proc/self/maps cannot be opened\n");
+
+	while (fgets(line, sizeof(line), file)) {
+		const char *whitespace_loc, *hyphen_loc;
+
+		hyphen_loc = strchr(line, '-');
+		whitespace_loc = strchr(line, ' ');
+
+		if (!(hyphen_loc && whitespace_loc)) {
+			ksft_test_result_skip("Unexpected format");
+			ksft_finished();
+		}
+
+		if ((hyphen_loc - line > 8) ||
+		    (whitespace_loc - hyphen_loc) > 9) {
+			ksft_test_result_fail("Memory map more than 32 bits\n");
+			ksft_finished();
+		}
+	}
+
+	for (int i = 0; i < chunks; ++i)
+		munmap(ptr[i], MAP_CHUNK_SIZE);
+
+	ksft_test_result_pass("Test\n");
+	ksft_finished();
+}
-- 
2.39.2


