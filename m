Return-Path: <linux-kselftest+bounces-8598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46148AC4C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE661F2203B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887974D13F;
	Mon, 22 Apr 2024 07:09:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8344D112;
	Mon, 22 Apr 2024 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769742; cv=none; b=pfDJ+Jq59Vrey9e/7rZiNvvqKrWXJ/tzlh18YbJ5KkzXrIEYsrhMd6Bz0hpdIkPJzKtIdWK4qp4eMruSzGAChBL8mWgyvdRWE4JdLGS6HD7RT6LxCRJOjRDeImk+tUjQNtne+F+KxgTf922z4RQNkrg2ZUbVMV68SNmCQ38GOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769742; c=relaxed/simple;
	bh=PhnsmAqWu+HmDRPdj49qRtxwYFJ41YZWd0ArXVRH1fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIa1sumxa+5mjh35JrcmsqdsWHYnKfenHs0Neij2a4yrDdjxfzyGB5GdCfkkOOUK4kzw+JUih0zQ6uIH1wrL57Gj0GyQRdcMZzzKvcUJLxrU4bd4LF6mF22GSGmAekmQs7U0C1TzBBgA6QF2sxjkWFQjSS/S0dEFbjFmTPTBEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D79121063;
	Mon, 22 Apr 2024 00:09:28 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE87F3F7BD;
	Mon, 22 Apr 2024 00:08:55 -0700 (PDT)
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
Subject: [PATCH v2 3/4] selftests/arm: Add elf test
Date: Mon, 22 Apr 2024 12:37:16 +0530
Message-Id: <20240422070717.2194201-4-dev.jain@arm.com>
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

This patch introduces an ELF parsing test; the 5th byte of the ELF header
must be 0x01 for a 32-bit process. A basic sanity check is required to ensure
that we are actually testing a 32-bit build.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm/elf/parse_elf.c | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c

diff --git a/tools/testing/selftests/arm/elf/parse_elf.c b/tools/testing/selftests/arm/elf/parse_elf.c
new file mode 100644
index 000000000000..86a2ec88b47d
--- /dev/null
+++ b/tools/testing/selftests/arm/elf/parse_elf.c
@@ -0,0 +1,74 @@
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
+	int ret = -1;
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
+				ret = 0;
+		} else {
+			ksft_print_msg("Cannot parse /proc/self/exe\n");
+		}
+	} else {
+		ksft_print_msg("Cannot open /proc/self/exe\n");
+	}
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	ksft_test_result(read_elf_header("/proc/self/exe") == 0, "ELF is 32 bit\n");
+	ksft_finished();
+}
-- 
2.39.2


