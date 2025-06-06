Return-Path: <linux-kselftest+bounces-34428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63DAD08CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 21:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852E5189AD3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA0202996;
	Fri,  6 Jun 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V3JL5Uga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AE215073
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749239108; cv=none; b=cuWuyujs/0OygqBJsXXprCgRzxDxLnAy39IE76bzdbXP0C8SUmsskdoteW0LAgNI2NA6ZeoxW5GjfbVEOEmr9+5p9euIsRD0xek7Q7ymW8iyV6CimkyerAoBTwivO8TXfiBVgGABHAsm4+N2yt4KrQFcRNj+fg8T1eKI93Z/Nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749239108; c=relaxed/simple;
	bh=ZGOo15rEt3M2IldpfcXsUeXjkvIT0uNaqmNLb5r2poM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHerO/cSH3lEH3zk1MXN/VaaKzj/OJ15jvI6vB3MZnloapRcxrfvD+vcebvrTFGhEBqkdkLM9wKbpUgC2uaUOwBzI0W/6PEcBzulTKM4nSH3ufUI3Lwn/CVGDzqhDSxzJ58OpVCI1zwYRfeIL/sni96lBjgU062tnIGN6E8Tw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V3JL5Uga; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a589b7dd5fso40851121cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Jun 2025 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749239104; x=1749843904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNE4vqKG4oc21x5jajC1nXKC3LtbUyjtsX298mgjNWw=;
        b=V3JL5UgamIRps5vz2egXwu6oXNsiVAxd5CCVKJp1CH3HNRgzMYBSXKFN/P6HT88+bu
         b0Crj2oCUifZIO6yAi5rOVDdreMjz94K4A/H/QqQVCXplOI4Sw1yxpqXfii4ET0wOf1p
         0mfj2zBv/b+vtQRFVWCqm7mXGd2CYDVWlhp7QU2853xVQpMRyHWBdL42D+jRrin2BN+m
         A2CVeP5HY2le4d+4FIyMg9B7BYNysVYi8/SDtnzIDuWnU+65FyvgF2dzWNxQ+7dDSJ6y
         +IGwGDaHhIsmmv11DLaaNQTPP11AjpxrAeJOXj2OS4NjTSuBSmv11ooczjcDpTHs+MqG
         OJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749239104; x=1749843904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNE4vqKG4oc21x5jajC1nXKC3LtbUyjtsX298mgjNWw=;
        b=YmMCxXjnIeP4I6jd+x+YmQBvWdXSpTlSx/zarSH2nD3cOdsAc7D09dA+wYArRPIDGs
         ujs9lUs5vbvr0N1iF6MH8Cok9fj9h6z6TMeOe4kO692lYsDXP9qMqWD7qfLSS0DWj1UF
         nwH4zVW/aaTGXDoXt5ZtYrIC1HUzpNVaezwonk6lny39vz5MdAAXjkbztNparCGl6BY0
         DSwuUvTG86rkLVKgXbarsC09l4Ze9SyxsMNWdwPLxpS1z48x+yvEcbPiElmjPlmPT7ew
         wWkqGnTqavxMtInob6Pwt+qviGVXHxV3OwhiNqi0gts9W/KEnwBBlT4ck8DaXdpAszNr
         xsuw==
X-Forwarded-Encrypted: i=1; AJvYcCUMhyH0mJj4/lAcY+qWpbAnZXFfsNGozvH0F/005iblQhp1dLXcmwfZSo15M6uPD0aAIaH0iyQmx94R9OShqqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/boTzlBz1i0GqmbYydU3A2nYDJ225clkuw10Fga65A2TeplMp
	PYGpnU8e68VBF/NAI9g3jJEqbuqCRU6d+gClZVCiLRuLYbocF/wckrgjrtgN609HoAY=
X-Gm-Gg: ASbGncvCIeomLnxddqWx42Urt47Ie0p0K69S1P+dszVre8MhY//lZefqMEhOJJApHkp
	3AuWnH2khid9SQ6vcjDlbNqlDDXDOF9HWg7v6inqQQIPcUx7+hm+4EzFoT99W0MKe9LdEydOT49
	/kp7HD9eBnA2wLlaIrQDtI79G6ALE/mxRp/6XrViQdfLy+hPiXgBXlw3WJ3ZwUP2Il6WA90MC9E
	hPzu6bHqcKWRZUrzzWA0o6FbpgDoMWHjbgR1kSRNpGwOCPqYvius0ZRl9D4A/ZwIyLCWKlQ5ojZ
	a0poHKbpsx7lkRg+aNXINW35AD+/pXPGpSFH5Svpmx29JYVM/+E7hRU9fzRq7P0FWqVLvUZ3TX3
	DJBAt1AABadZnXVb0tmIoTsPFSMZ/rKYCIpswbzlMuakKp8vX
X-Google-Smtp-Source: AGHT+IGS6mYRFI9uteKca7Gp4Dxhg9Vwkq5Hrd67uT+o6oH0EN2GlDM0WqkMw44G87Oy4A/3TVPTFw==
X-Received: by 2002:a05:622a:4d04:b0:4a4:31e2:2e73 with SMTP id d75a77b69052e-4a5b9dafcbcmr74129161cf.45.1749239104321;
        Fri, 06 Jun 2025 12:45:04 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-224-24.bstnma.fios.verizon.net. [108.26.224.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619865e74sm17662291cf.61.2025.06.06.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:45:04 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>
Subject: [PATCH v4] riscv: sbi: Add SBI Debug Triggers Extension tests
Date: Fri,  6 Jun 2025 12:45:03 -0700
Message-ID: <20250606194503.2857119-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for the DBTR SBI extension.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
V1 -> V2:
 - Call report_prefix_pop before returning
 - Disable compressed instructions in exec_call, update related comment
 - Remove extra "| 1" in dbtr_test_load
 - Remove extra newlines
 - Remove extra tabs in check_exec
 - Remove typedefs from enums
 - Return when dbtr_install_trigger fails
 - s/avalible/available/g
 - s/unistall/uninstall/g
V2 -> V3:
 - Change SBI_DBTR_SHMEM_INVALID_ADDR to -1UL
 - Move all dbtr functions to sbi-dbtr.c
 - Move INSN_LEN to processor.h
 - Update include list
 - Use C-style comments
V3 -> V4:
 - Include libcflat.h
 - Remove #define SBI_DBTR_SHMEM_INVALID_ADDR
---
 lib/riscv/asm/sbi.h |   1 +
 riscv/Makefile      |   1 +
 riscv/sbi-dbtr.c    | 811 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/sbi-tests.h   |   1 +
 riscv/sbi.c         |   1 +
 5 files changed, 815 insertions(+)
 create mode 100644 riscv/sbi-dbtr.c

diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
index a5738a5c..78fd6e2a 100644
--- a/lib/riscv/asm/sbi.h
+++ b/lib/riscv/asm/sbi.h
@@ -51,6 +51,7 @@ enum sbi_ext_id {
 	SBI_EXT_SUSP = 0x53555350,
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_SSE = 0x535345,
+	SBI_EXT_DBTR = 0x44425452,
 };
 
 enum sbi_ext_base_fid {
diff --git a/riscv/Makefile b/riscv/Makefile
index 11e68eae..55c7ac93 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -20,6 +20,7 @@ all: $(tests)
 $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-asm.o
 $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-fwft.o
 $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-sse.o
+$(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-dbtr.o
 
 all_deps += $($(TEST_DIR)/sbi-deps)
 
diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
new file mode 100644
index 00000000..b254f84e
--- /dev/null
+++ b/riscv/sbi-dbtr.c
@@ -0,0 +1,811 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SBI DBTR testsuite
+ *
+ * Copyright (C) 2025, Rivos Inc., Jesse Taube <jesse@rivosinc.com>
+ */
+
+#include <asm/io.h>
+#include <bitops.h>
+#include <asm/processor.h>
+#include <libcflat.h>
+
+#include "sbi-tests.h"
+
+#define RV_MAX_TRIGGERS			32
+
+#define SBI_DBTR_TRIG_STATE_MAPPED		BIT(0)
+#define SBI_DBTR_TRIG_STATE_U			BIT(1)
+#define SBI_DBTR_TRIG_STATE_S			BIT(2)
+#define SBI_DBTR_TRIG_STATE_VU			BIT(3)
+#define SBI_DBTR_TRIG_STATE_VS			BIT(4)
+#define SBI_DBTR_TRIG_STATE_HAVE_HW_TRIG	BIT(5)
+
+#define SBI_DBTR_TRIG_STATE_HW_TRIG_IDX_SHIFT		8
+#define SBI_DBTR_TRIG_STATE_HW_TRIG_IDX(trig_state)	(trig_state >> SBI_DBTR_TRIG_STATE_HW_TRIG_IDX_SHIFT)
+
+#define SBI_DBTR_TDATA1_TYPE_SHIFT		(__riscv_xlen - 4)
+
+#define SBI_DBTR_TDATA1_MCONTROL6_LOAD_BIT	BIT(0)
+#define SBI_DBTR_TDATA1_MCONTROL6_STORE_BIT	BIT(1)
+#define SBI_DBTR_TDATA1_MCONTROL6_EXECUTE_BIT	BIT(2)
+#define SBI_DBTR_TDATA1_MCONTROL6_U_BIT		BIT(3)
+#define SBI_DBTR_TDATA1_MCONTROL6_S_BIT		BIT(4)
+#define SBI_DBTR_TDATA1_MCONTROL6_SELECT_BIT	BIT(21)
+#define SBI_DBTR_TDATA1_MCONTROL6_VS_BIT	BIT(23)
+#define SBI_DBTR_TDATA1_MCONTROL6_VU_BIT	BIT(24)
+
+#define SBI_DBTR_TDATA1_MCONTROL_LOAD_BIT	BIT(0)
+#define SBI_DBTR_TDATA1_MCONTROL_STORE_BIT	BIT(1)
+#define SBI_DBTR_TDATA1_MCONTROL_EXECUTE_BIT	BIT(2)
+#define SBI_DBTR_TDATA1_MCONTROL_U_BIT		BIT(3)
+#define SBI_DBTR_TDATA1_MCONTROL_S_BIT		BIT(4)
+#define SBI_DBTR_TDATA1_MCONTROL_SELECT_BIT	BIT(19)
+
+enum McontrolType {
+	SBI_DBTR_TDATA1_TYPE_NONE =		(0UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_LEGACY =		(1UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_MCONTROL =		(2UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_ICOUNT =		(3UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_ITRIGGER =		(4UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_ETRIGGER =		(5UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_MCONTROL6 =	(6UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_TMEXTTRIGGER =	(7UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_RESERVED0 =	(8UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_RESERVED1 =	(9UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_RESERVED2 =	(10UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_RESERVED3 =	(11UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_CUSTOM0 =		(12UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_CUSTOM1 =		(13UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_CUSTOM2 =		(14UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+	SBI_DBTR_TDATA1_TYPE_DISABLED =		(15UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
+};
+
+enum Tdata1Value {
+	VALUE_NONE =	0,
+	VALUE_LOAD =	BIT(0),
+	VALUE_STORE =	BIT(1),
+	VALUE_EXECUTE =	BIT(2),
+};
+
+enum Tdata1Mode {
+	MODE_NONE =	0,
+	MODE_M =	BIT(0),
+	MODE_U =	BIT(1),
+	MODE_S =	BIT(2),
+	MODE_VU =	BIT(3),
+	MODE_VS =	BIT(4),
+};
+
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_SETUP_SHMEM,
+	SBI_EXT_DBTR_TRIGGER_READ,
+	SBI_EXT_DBTR_TRIGGER_INSTALL,
+	SBI_EXT_DBTR_TRIGGER_UPDATE,
+	SBI_EXT_DBTR_TRIGGER_UNINSTALL,
+	SBI_EXT_DBTR_TRIGGER_ENABLE,
+	SBI_EXT_DBTR_TRIGGER_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+};
+
+/* SBI shared mem messages layout */
+struct sbi_dbtr_shmem_entry {
+	union {
+		struct sbi_dbtr_data_msg data;
+		struct sbi_dbtr_id_msg id;
+	};
+};
+
+static bool dbtr_handled;
+
+/* Expected to be leaf function as not to disrupt frame-pointer */
+static __attribute__((naked)) void exec_call(void)
+{
+	/* skip over nop when triggered instead of ret. */
+	asm volatile (".option push\n"
+		      ".option arch, -c\n"
+		      "nop\n"
+		      "ret\n"
+		      ".option pop\n");
+}
+
+static void dbtr_exception_handler(struct pt_regs *regs)
+{
+	dbtr_handled = true;
+
+	/* Reading *epc may cause a fault, skip over nop */
+	if ((void *)regs->epc == exec_call) {
+		regs->epc += 4;
+		return;
+	}
+
+	/* WARNING: Skips over the trapped intruction */
+	regs->epc += RV_INSN_LEN(readw((void *)regs->epc));
+}
+
+static bool do_save(void *tdata2)
+{
+	bool ret;
+
+	writel(0, tdata2);
+
+	ret = dbtr_handled;
+	dbtr_handled = false;
+
+	return ret;
+}
+
+static bool do_load(void *tdata2)
+{
+	bool ret;
+
+	readl(tdata2);
+
+	ret = dbtr_handled;
+	dbtr_handled = false;
+
+	return ret;
+}
+
+static bool do_exec(void)
+{
+	bool ret;
+
+	exec_call();
+
+	ret = dbtr_handled;
+	dbtr_handled = false;
+
+	return ret;
+}
+
+static unsigned long gen_tdata1_mcontrol(enum Tdata1Mode mode, enum Tdata1Value value)
+{
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL;
+
+	if (value & VALUE_LOAD)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_LOAD_BIT;
+
+	if (value & VALUE_STORE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_STORE_BIT;
+
+	if (value & VALUE_EXECUTE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_EXECUTE_BIT;
+
+	if (mode & MODE_M)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_U_BIT;
+
+	if (mode & MODE_U)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_U_BIT;
+
+	if (mode & MODE_S)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_S_BIT;
+
+	return tdata1;
+}
+
+static unsigned long gen_tdata1_mcontrol6(enum Tdata1Mode mode, enum Tdata1Value value)
+{
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
+
+	if (value & VALUE_LOAD)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_LOAD_BIT;
+
+	if (value & VALUE_STORE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_STORE_BIT;
+
+	if (value & VALUE_EXECUTE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_EXECUTE_BIT;
+
+	if (mode & MODE_M)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_U_BIT;
+
+	if (mode & MODE_U)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_U_BIT;
+
+	if (mode & MODE_S)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_S_BIT;
+
+	if (mode & MODE_VU)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_VU_BIT;
+
+	if (mode & MODE_VS)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_VS_BIT;
+
+	return tdata1;
+}
+
+static unsigned long gen_tdata1(enum McontrolType type, enum Tdata1Value value, enum Tdata1Mode mode)
+{
+	switch (type) {
+	case SBI_DBTR_TDATA1_TYPE_MCONTROL:
+		return gen_tdata1_mcontrol(mode, value);
+	case SBI_DBTR_TDATA1_TYPE_MCONTROL6:
+		return gen_tdata1_mcontrol6(mode, value);
+	default:
+		return 0;
+	}
+}
+
+static struct sbiret sbi_debug_num_triggers(unsigned long trig_tdata1)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS, trig_tdata1, 0, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_set_shmem_raw(unsigned long shmem_phys_lo,
+				      unsigned long shmem_phys_hi,
+				      unsigned long flags)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM, shmem_phys_lo,
+			 shmem_phys_hi, flags, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_set_shmem(void *shmem)
+{
+	phys_addr_t p = virt_to_phys(shmem);
+
+	return sbi_debug_set_shmem_raw(lower_32_bits(p), upper_32_bits(p), 0);
+}
+
+static struct sbiret sbi_debug_read_triggers(unsigned long trig_idx_base,
+				      unsigned long trig_count)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_READ, trig_idx_base,
+			 trig_count, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_install_triggers(unsigned long trig_count)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL, trig_count, 0, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_update_triggers(unsigned long trig_count)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UPDATE, trig_count, 0, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_uninstall_triggers(unsigned long trig_idx_base,
+					   unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UNINSTALL, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_enable_triggers(unsigned long trig_idx_base,
+					unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_ENABLE, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_disable_triggers(unsigned long trig_idx_base,
+					 unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_DISABLE, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+static bool dbtr_install_trigger(struct sbi_dbtr_shmem_entry *shmem, void *tdata2,
+				 unsigned long tdata1)
+{
+	struct sbiret sbi_ret;
+	bool ret;
+
+	shmem->data.tdata1 = tdata1;
+	shmem->data.tdata2 = (unsigned long)tdata2;
+
+	sbi_ret = sbi_debug_install_triggers(1);
+	ret = sbiret_report_error(&sbi_ret, SBI_SUCCESS, "sbi_debug_install_triggers");
+	if (ret)
+		install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
+
+	return ret;
+}
+
+static bool dbtr_uninstall_trigger(void)
+{
+	struct sbiret ret;
+
+	install_exception_handler(EXC_BREAKPOINT, NULL);
+
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	return sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+}
+
+static unsigned long dbtr_test_num_triggers(void)
+{
+	struct sbiret ret;
+	unsigned long tdata1 = 0;
+	/* sbi_debug_num_triggers will return trig_max in sbiret.value when trig_tdata1 == 0 */
+
+	/* should be at least one trigger. */
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
+
+	if (ret.value == 0)
+		report_fail("sbi_debug_num_triggers: Returned 0 triggers available");
+	else
+		report_pass("sbi_debug_num_triggers: Returned %lu triggers available", ret.value);
+
+	return ret.value;
+}
+
+static enum McontrolType dbtr_test_type(unsigned long *num_trig)
+{
+	struct sbiret ret;
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
+
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
+	if (ret.value > 0) {
+		report_pass("sbi_debug_num_triggers: Returned %lu mcontrol6 triggers available",
+			    ret.value);
+		*num_trig = ret.value;
+		return tdata1;
+	}
+
+	tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL;
+
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
+	*num_trig = ret.value;
+	if (ret.value > 0) {
+		report_pass("sbi_debug_num_triggers: Returned %lu mcontrol triggers available",
+			    ret.value);
+		return tdata1;
+	}
+
+	report_fail("sbi_debug_num_triggers: Returned 0 mcontrol(6) triggers available");
+
+	return SBI_DBTR_TDATA1_TYPE_NONE;
+}
+
+static struct sbiret dbtr_test_save_install_uninstall(struct sbi_dbtr_shmem_entry *shmem,
+						      enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("save_trigger");
+
+	shmem->data.tdata1 = gen_tdata1(type, VALUE_STORE, MODE_S | MODE_S);
+	shmem->data.tdata2 = (unsigned long)&test;
+
+	ret = sbi_debug_install_triggers(1);
+	if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers")) {
+		report_prefix_pop();
+		return ret;
+	}
+
+	install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
+
+	report(do_save(&test), "triggered");
+
+	if (do_load(&test))
+		report_fail("triggered by load");
+
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+
+	if (do_save(&test))
+		report_fail("triggered after uninstall");
+
+	install_exception_handler(EXC_BREAKPOINT, NULL);
+	report_prefix_pop();
+
+	return ret;
+}
+
+static void dbtr_test_update(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("update_trigger");
+
+	if (!dbtr_install_trigger(shmem, NULL, gen_tdata1(type, VALUE_NONE, MODE_NONE))) {
+		report_prefix_pop();
+		return;
+	}
+
+	shmem->id.idx = 0;
+	shmem->data.tdata1 = gen_tdata1(type, VALUE_STORE, MODE_S);
+	shmem->data.tdata2 = (unsigned long)&test;
+
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_update_triggers");
+
+	report(do_save(&test), "triggered");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_load(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+
+	report_prefix_push("load_trigger");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_LOAD, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	report(do_load(&test), "triggered");
+
+	if (do_save(&test))
+		report_fail("triggered by save");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_disable_enable(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("sbi_debug_disable_triggers");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	ret = sbi_debug_disable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_disable_triggers");
+
+	if (do_save(&test)) {
+		report_fail("should not trigger");
+
+		dbtr_uninstall_trigger();
+		report_prefix_pop();
+		report_skip("sbi_debug_enable_triggers: no disable");
+
+		return;
+	}
+
+	report_pass("should not trigger");
+
+	report_prefix_pop();
+	report_prefix_push("sbi_debug_enable_triggers");
+
+	ret = sbi_debug_enable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_enable_triggers");
+
+	report(do_save(&test), "triggered");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_exec(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+
+	report_prefix_push("exec_trigger");
+	/* check if loads and saves trigger exec */
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_EXECUTE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	if (do_load(&test))
+		report_fail("triggered by load");
+
+	if (do_save(&test))
+		report_fail("triggered by save");
+
+	dbtr_uninstall_trigger();
+
+	/* Check if exec works */
+	if (!dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+	report(do_exec(), "exec trigger");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_read(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	const unsigned long tstatus_expected = SBI_DBTR_TRIG_STATE_S | SBI_DBTR_TRIG_STATE_MAPPED;
+	const unsigned long tdata1 = gen_tdata1(type, VALUE_STORE, MODE_S);
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("sbi_debug_read_triggers");
+	if (!dbtr_install_trigger(shmem, &test, tdata1)) {
+		report_prefix_pop();
+		return;
+	}
+
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers");
+
+	report(shmem->data.tdata1 == tdata1, "tdata1 expected: 0x%016lx, found: 0x%016lx",
+	       tdata1, shmem->data.tdata1);
+	report(shmem->data.tdata2 == ((unsigned long)&test),
+	       "tdata2 expected: 0x%016lx, found: 0x%016lx", ((unsigned long)&test),
+	       shmem->data.tdata2);
+	report(shmem->data.tstate == tstatus_expected, "tstate expected: 0x%016lx, found: 0x%016lx",
+	       tstatus_expected, shmem->data.tstate);
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void check_exec(unsigned long base)
+{
+	struct sbiret ret;
+
+	report(do_exec(), "exec triggered");
+
+	ret = sbi_debug_uninstall_triggers(base, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+}
+
+static void dbtr_test_multiple(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type,
+			       unsigned long num_trigs)
+{
+	static unsigned long test[2];
+	struct sbiret ret;
+	bool have_three = num_trigs > 2;
+
+	if (num_trigs < 2)
+		return;
+
+	report_prefix_push("test_multiple");
+
+	if (!dbtr_install_trigger(shmem, &test[0], gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+	if (!dbtr_install_trigger(shmem, &test[1], gen_tdata1(type, VALUE_LOAD, MODE_S)))
+		goto error;
+	if (have_three &&
+	    !dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S))) {
+		ret = sbi_debug_uninstall_triggers(1, 1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+		goto error;
+	}
+
+	report(do_save(&test[0]), "save triggered");
+
+	if (do_load(&test[0]))
+		report_fail("save triggered by load");
+
+	report(do_load(&test[1]), "load triggered");
+
+	if (do_save(&test[1]))
+		report_fail("load triggered by save");
+
+	if (have_three)
+		check_exec(2);
+
+	ret = sbi_debug_uninstall_triggers(1, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+
+	if (do_load(&test[1]))
+		report_fail("load triggered after uninstall");
+
+	report(do_save(&test[0]), "save triggered");
+
+	if (!have_three &&
+	    dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S)))
+		check_exec(1);
+
+error:
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+
+	install_exception_handler(EXC_BREAKPOINT, NULL);
+	report_prefix_pop();
+}
+
+static void dbtr_test_multiple_types(struct sbi_dbtr_shmem_entry *shmem, unsigned long type)
+{
+	static unsigned long test;
+
+	report_prefix_push("dbtr_test_multiple_types");
+
+	/* check if loads and saves trigger exec */
+	if (!dbtr_install_trigger(shmem, &test,
+			     gen_tdata1(type, VALUE_EXECUTE | VALUE_LOAD | VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	report(do_load(&test), "load trigger");
+
+	report(do_save(&test), "save trigger");
+
+	dbtr_uninstall_trigger();
+
+	/* Check if exec works */
+	if (!dbtr_install_trigger(shmem, exec_call,
+			     gen_tdata1(type, VALUE_EXECUTE | VALUE_LOAD | VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	report(do_exec(), "exec trigger");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_disable_uninstall(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("disable uninstall");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	ret = sbi_debug_disable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_disable_triggers");
+
+	dbtr_uninstall_trigger();
+
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	report(do_save(&test), "triggered");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_uninstall_enable(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("uninstall enable");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+	dbtr_uninstall_trigger();
+
+	ret = sbi_debug_enable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_enable_triggers");
+
+	install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
+
+	report(!do_save(&test), "should not trigger");
+
+	install_exception_handler(EXC_BREAKPOINT, NULL);
+	report_prefix_pop();
+}
+
+static void dbtr_test_uninstall_update(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("uninstall update");
+	if (!dbtr_install_trigger(shmem, NULL, gen_tdata1(type, VALUE_NONE, MODE_NONE))) {
+		report_prefix_pop();
+		return;
+	}
+
+	dbtr_uninstall_trigger();
+
+	shmem->id.idx = 0;
+	shmem->data.tdata1 = gen_tdata1(type, VALUE_STORE, MODE_S);
+	shmem->data.tdata2 = (unsigned long)&test;
+
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_FAILURE, "sbi_debug_update_triggers");
+
+	install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
+
+	report(!do_save(&test), "should not trigger");
+
+	install_exception_handler(EXC_BREAKPOINT, NULL);
+	report_prefix_pop();
+}
+
+static void dbtr_test_disable_read(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	const unsigned long tstatus_expected = SBI_DBTR_TRIG_STATE_S | SBI_DBTR_TRIG_STATE_MAPPED;
+	const unsigned long tdata1 = gen_tdata1(type, VALUE_STORE, MODE_NONE);
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("disable_read");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	ret = sbi_debug_disable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_disable_triggers");
+
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers");
+
+	report(shmem->data.tdata1 == tdata1, "tdata1 expected: 0x%016lx, found: 0x%016lx",
+	       tdata1, shmem->data.tdata1);
+	report(shmem->data.tdata2 == ((unsigned long)&test),
+	       "tdata2 expected: 0x%016lx, found: 0x%016lx",
+	       ((unsigned long)&test), shmem->data.tdata2);
+	report(shmem->data.tstate == tstatus_expected, "tstate expected: 0x%016lx, found: 0x%016lx",
+	       tstatus_expected, shmem->data.tstate);
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+void check_dbtr(void)
+{
+	static struct sbi_dbtr_shmem_entry shmem[RV_MAX_TRIGGERS] = {};
+	unsigned long num_trigs;
+	enum McontrolType trig_type;
+	struct sbiret ret;
+
+	report_prefix_push("dbtr");
+
+	if (!sbi_probe(SBI_EXT_DBTR)) {
+		report_skip("extension not available");
+		report_prefix_pop();
+		return;
+	}
+
+	if (__sbi_get_imp_id() == SBI_IMPL_OPENSBI &&
+	    __sbi_get_imp_version() < sbi_impl_opensbi_mk_version(1, 6)) {
+		report_skip("OpenSBI < v1.7 detected, skipping tests");
+		report_prefix_pop();
+		return;
+	}
+
+	num_trigs = dbtr_test_num_triggers();
+	if (!num_trigs)
+		goto error;
+
+	trig_type = dbtr_test_type(&num_trigs);
+	if (trig_type == SBI_DBTR_TDATA1_TYPE_NONE)
+		goto error;
+
+	ret = sbi_debug_set_shmem(shmem);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem");
+
+	ret = dbtr_test_save_install_uninstall(&shmem[0], trig_type);
+	/* install or uninstall failed */
+	if (ret.error != SBI_SUCCESS)
+		goto error;
+
+	dbtr_test_load(&shmem[0], trig_type);
+	dbtr_test_exec(&shmem[0], trig_type);
+	dbtr_test_read(&shmem[0], trig_type);
+	dbtr_test_disable_enable(&shmem[0], trig_type);
+	dbtr_test_update(&shmem[0], trig_type);
+	dbtr_test_multiple_types(&shmem[0], trig_type);
+	dbtr_test_multiple(shmem, trig_type, num_trigs);
+	dbtr_test_disable_uninstall(&shmem[0], trig_type);
+	dbtr_test_uninstall_enable(&shmem[0], trig_type);
+	dbtr_test_uninstall_update(&shmem[0], trig_type);
+	dbtr_test_disable_read(&shmem[0], trig_type);
+
+error:
+	report_prefix_pop();
+}
diff --git a/riscv/sbi-tests.h b/riscv/sbi-tests.h
index d5c4ae70..6a227745 100644
--- a/riscv/sbi-tests.h
+++ b/riscv/sbi-tests.h
@@ -99,6 +99,7 @@ static inline bool env_enabled(const char *env)
 
 void sbi_bad_fid(int ext);
 void check_sse(void);
+void check_dbtr(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* _RISCV_SBI_TESTS_H_ */
diff --git a/riscv/sbi.c b/riscv/sbi.c
index edb1a6be..5bd496d0 100644
--- a/riscv/sbi.c
+++ b/riscv/sbi.c
@@ -1561,6 +1561,7 @@ int main(int argc, char **argv)
 	check_susp();
 	check_sse();
 	check_fwft();
+	check_dbtr();
 
 	return report_summary();
 }
-- 
2.43.0


