Return-Path: <linux-kselftest+bounces-8596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23238AC4BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 09:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9E2822F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05C48CCC;
	Mon, 22 Apr 2024 07:08:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB4482D7;
	Mon, 22 Apr 2024 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769732; cv=none; b=MT0hyJSgdaI4+Ljn6AP35sZ3AmwKDDzyHQVapX7pocNeohilxFwcYy/K5MAGRUsuWZUeIQsnKTq5uGjAYtqJdg7cWPJdMTZIw5j/NNIS9nIktEjvfKb12dBrR+IBCBkeH7GQVewSWPedqJQkjq2ag2Q3/jmCYNEkFF47YbU3DCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769732; c=relaxed/simple;
	bh=ypJhMt8Uo2wr/UL7YmAzqCdpKHS3vYTHgdA1ZbWhI9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKTgHlcbP+gkU5b1B2/Ww3VF+aPQ73EwMJNrojIG7MAkcd9iaC9crbplQ3G4Ag+AjrpII9ftsSBUrMYkQseq0GoCutdjrKm2DCrTX1EezsZTFAQyGuADAsy5tQRJkDsjrR3p6k9g5NZ5pbRFmPqi4wgv8FUaCkbimt3MeEHJU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 966B31063;
	Mon, 22 Apr 2024 00:09:18 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC65C3F7BD;
	Mon, 22 Apr 2024 00:08:45 -0700 (PDT)
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
	linux@armlinux.org.uk,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 1/4] selftests/arm: Add mm test
Date: Mon, 22 Apr 2024 12:37:14 +0530
Message-Id: <20240422070717.2194201-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422070717.2194201-1-dev.jain@arm.com>
References: <20240422070717.2194201-1-dev.jain@arm.com>
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
 tools/testing/selftests/arm/mm/compat_va.c | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/arm/mm/compat_va.c

diff --git a/tools/testing/selftests/arm/mm/compat_va.c b/tools/testing/selftests/arm/mm/compat_va.c
new file mode 100644
index 000000000000..03f662fad79f
--- /dev/null
+++ b/tools/testing/selftests/arm/mm/compat_va.c
@@ -0,0 +1,92 @@
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
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	char *ptr[NR_CHUNKS_4G + 3];
+	char line[1000];
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
+	file = fopen("/proc/self/maps", "r");
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


