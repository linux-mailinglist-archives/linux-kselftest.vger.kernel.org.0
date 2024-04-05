Return-Path: <linux-kselftest+bounces-7257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED86899878
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE65B2250C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7415FD15;
	Fri,  5 Apr 2024 08:50:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61A15FD0A;
	Fri,  5 Apr 2024 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307003; cv=none; b=jhtTyvblDRH/07NDbgaW3gHgTIu82+NWA+CTaQ5IPpNjtt3+JMqYUAOcKelTO02zwcqmhGrj7j84hy8DS68fCXtCi2kg2Dpyb9EDvqvr7GUTM6rYKJm8XG/w6YG9zy/a5gZRe74HOBaaKP+hQUoQKXSZsyXl/IVUYq7wupaeKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307003; c=relaxed/simple;
	bh=p/8Fq+jpurELJ6V7Gi3YxX1mI3RCEZP5MKqChiEaFz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfDqEbJMUnNfIkhtgYmouD1/Z5g79Iu+O2xK0fsB446Z6rJQuxY2aaykeIUq/8UmLHlMwj+wiwYuCmy//6GVFE8ilW1nNNqXWpJ3w8t+vaSAuJRy/YgWmJeBaDgwV2oOp2AulVlTzKwD5of14HDzDjo8ATQ6txLVXD9ocHFjW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73FFFEC;
	Fri,  5 Apr 2024 01:50:31 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF8443F64C;
	Fri,  5 Apr 2024 01:49:56 -0700 (PDT)
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
Subject: [PATCH 3/4] selftests/arm: Add elf test
Date: Fri,  5 Apr 2024 14:14:09 +0530
Message-Id: <20240405084410.256788-4-dev.jain@arm.com>
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

This patch introduces an ELF parsing test; the 5th byte of the ELF header
must be 0x01 for a 32-bit process. A basic sanity check is required to ensure
that we are actually testing a 32-bit build.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm/elf/parse_elf.c | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c

diff --git a/tools/testing/selftests/arm/elf/parse_elf.c b/tools/testing/selftests/arm/elf/parse_elf.c
new file mode 100644
index 000000000000..decd65699858
--- /dev/null
+++ b/tools/testing/selftests/arm/elf/parse_elf.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Author : Dev Jain <dev.jain@arm.com>
+ *
+ * Parse elf header to confirm 32-bit process
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <elf.h>
+#include <stdint.h>
+
+#include <kselftest.h>
+
+/* The ELF file header.  This appears at the start of every ELF file. */
+
+struct elf_header {
+	unsigned char	e_ident[16];	/* Magic number and other info */
+	uint16_t	e_type;		/* Object file type */
+	uint16_t	e_machine;	/* Architecture */
+	uint32_t	e_version;	/* Object file version */
+	uint64_t	e_entry;	/* Entry point virtual address */
+	uint64_t	e_phoff;	/* Program header table file offset */
+	uint64_t	e_shoff;	/* Section header table file offset */
+	uint32_t	e_flags;	/* Processor-specific flags */
+	uint16_t	e_ehsize;	/* ELF header size in bytes */
+	uint16_t	e_phentsize;	/* Program header table entry size */
+	uint16_t	e_phnum;	/* Program header table entry count */
+	uint16_t	e_shentsize;	/* Section header table entry size */
+	uint16_t	e_shnum;	/* Section header table entry count */
+	uint16_t	e_shstrndx;	/* Section header string table index */
+};
+
+static int read_elf_header(const char  *elfFile)
+{
+	struct elf_header header;
+	FILE *file;
+
+	file = fopen(elfFile, "r");
+	if (file) {
+
+		/* store header in struct */
+		fread(&header, 1, sizeof(header), file);
+		fclose(file);
+
+		/* sanity check: does it really follow ELF format */
+		if (header.e_ident[0] == 0x7f &&
+		    header.e_ident[1] == 'E' &&
+		    header.e_ident[2] == 'L' &&
+		    header.e_ident[3] == 'F') {
+			if (header.e_ident[4] == 0x01)
+				return 0;
+			return 1;
+		}
+		ksft_exit_fail_msg("Cannot parse /proc/self/exe\n");
+	}
+	ksft_exit_fail_msg("Cannot open /proc/self/exe\n");
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char *argv[])
+{
+	const char *file_name;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	file_name = "/proc/self/exe";
+	ksft_test_result(read_elf_header(file_name) == 0, "ELF is 32 bit\n");
+	ksft_finished();
+}
-- 
2.39.2


