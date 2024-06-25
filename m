Return-Path: <linux-kselftest+bounces-12637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0E9167BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CDE1C25AEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE8156654;
	Tue, 25 Jun 2024 12:24:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84DF1553AF;
	Tue, 25 Jun 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318285; cv=none; b=EO8nWxkfE6sLvDwRvuvDvla/rWwI4Gg967YIKX0C8Wk6ljLUmcsVoe+rJQCo29ww2CEWF+MgWjQhsz+eo0SbC8MjU4e+G/6cSRFGcYOLAJCNbf2ZKX9dv1gPwzWPyAOWV1gt2DeAGpmY+3kqRHgBF6Hp/+rKsMH9mIiMrJ56pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318285; c=relaxed/simple;
	bh=1PSrTGcZOk8NrG6nmdRKoCA3QkgwzXuWtNM9SyFayRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fknvmXIR0SjResHu9Qps1ROsVZxdFfdO/houUMQUu+fV42IpUUpHvtrp5YXRraza19SPrAKqV0BAgR3L2CMbhgW33aT2uRN/jmKR84qGff4The9EdIXjHSGk3aqavSbWnK+jdVqj54K156wA8VgSYkc73ntLErmXWvfCTNGn7Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F259339;
	Tue, 25 Jun 2024 05:25:08 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 370573F766;
	Tue, 25 Jun 2024 05:24:37 -0700 (PDT)
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
Subject: [PATCH v3 2/9] selftests/arm: Add elf test
Date: Tue, 25 Jun 2024 17:54:01 +0530
Message-Id: <20240625122408.1439097-3-dev.jain@arm.com>
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

This patch introduces an ELF parsing test. A basic sanity check is
required to ensure that we are actually testing a 32-bit build.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
v2->v3:
 - Introduce two more testcases

 tools/testing/selftests/arm/elf/parse_elf.c | 77 +++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c

diff --git a/tools/testing/selftests/arm/elf/parse_elf.c b/tools/testing/selftests/arm/elf/parse_elf.c
new file mode 100644
index 000000000000..6eb8fb91f6a7
--- /dev/null
+++ b/tools/testing/selftests/arm/elf/parse_elf.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+	uint32_t	e_entry;	/* Entry point virtual address */
+	uint32_t	e_phoff;	/* Program header table file offset */
+	uint32_t	e_shoff;	/* Section header table file offset */
+	uint32_t	e_flags;	/* Processor-specific flags */
+	uint16_t	e_ehsize;	/* ELF header size in bytes */
+	uint16_t	e_phentsize;	/* Program header table entry size */
+	uint16_t	e_phnum;	/* Program header table entry count */
+	uint16_t	e_shentsize;	/* Section header table entry size */
+	uint16_t	e_shnum;	/* Section header table entry count */
+	uint16_t	e_shstrndx;	/* Section header string table index */
+};
+
+#define ELFCLASS32	1
+#define EM_ARM		40
+
+void read_elf_header(const char  *elfFile)
+{
+	struct elf_header header;
+	FILE *file;
+	int ret;
+
+	file = fopen(elfFile, "r");
+	if (!file)
+		ksft_exit_fail_perror("/proc/self/exe");
+
+	/* store header in struct */
+	if (fread(&header, 1, sizeof(header), file) != sizeof(header))
+		ksft_exit_fail_perror("fread");
+
+	if (fclose(file))
+		ksft_exit_fail_perror("fclose");
+
+	/* sanity check: does it really follow ELF format */
+	ret = (header.e_ident[0] == 0x7f && header.e_ident[1] == 'E'
+	       && header.e_ident[2] == 'L' && header.e_ident[3] == 'F');
+
+	ksft_test_result(ret == 1, "Follows ELF format\n");
+
+	ksft_test_result(header.e_ident[4] == ELFCLASS32, "ELF is 32 bit\n");
+
+	ksft_test_result(header.e_machine == EM_ARM, "Machine type\n");
+}
+
+int main(int argc, char *argv[])
+{
+	ksft_print_header();
+	ksft_set_plan(3);
+
+	read_elf_header("/proc/self/exe");
+
+	ksft_finished();
+}
-- 
2.39.2


