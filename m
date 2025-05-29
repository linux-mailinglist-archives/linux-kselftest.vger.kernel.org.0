Return-Path: <linux-kselftest+bounces-34013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C069AC845C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 00:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AB67B3C4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F5211A0E;
	Thu, 29 May 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sgMuN+KB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641D21FF38
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558176; cv=none; b=GazuNgNETHbHUehnB4ZwNOcgfM+jZCTFfWGI2FrRbEfEREm5Os/rbzmEjgtF75lJr0FCXM4AEGuNfuuAbiENTOIc9yiK7B/lxUf8FGXebv3PeGJvV7jv5JhRc5Wfu931YVgoqMbHi7I0TM+6EsnISJMolbNPEslG1eXZpr7E9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558176; c=relaxed/simple;
	bh=QXwZHC8jGS2yNxSwM/XAuavVrjnxapkuFKCnM5YQ4Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mzu0aeS0brJ/rcL34CSs/A5Q6qU9TsveUrkFm66YAb+DWnQx33qh5VCpvu17dZjk5bcTEQUgt9UxIvslRcCi1rSkug/7IrO3L5DTk6NcBuRKZdKqva4zYbSZDUnnC5SyUJV1y42diEJiFMBZZOl1zDWFWfmSU9cMatz/NSGvy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sgMuN+KB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6face1d58dcso6535856d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748558172; x=1749162972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gS4tu82Oi7QMzDoJWrZXxyZhnP2tsauNo8v5AOyinKg=;
        b=sgMuN+KB5OCs2DxT5sEi3XPRbdTD+4fAllx10f99ji/Ax827UTUMvmdeiP1ppne8Ag
         8z19zF2ul3k+LtKMGZJZXeGIIiuHg/Ch/gpNXDp6c0U07eU7OkrWrQUjR09om1hgIpG3
         9ZVtllsf9TVLPFgtn3BvEpJbCRRNR/yiifYGrkrEe7Rrp4ahEYaMRAgxI0xhxl4y+UWc
         vNkSCege9nrX5h2TjVwskKo1tCowRwDMT5A1o/NyJd3RECRafljMeeCw5Ru5UiPUsuOQ
         XjDBa5jcB8qgVbqlU/i74eekZ91/qd5lR1YrS1SfF4Ik1n2PWGd6GrhhEC+vtwkKN65+
         QHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748558172; x=1749162972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS4tu82Oi7QMzDoJWrZXxyZhnP2tsauNo8v5AOyinKg=;
        b=KSF8evLaqSLi85g880dAhxxfrTra1Hhl3j0f7BYxzohFAtCAvJRbtQC/SdQKDMil9q
         fNuaZjdCWho+JUzySPOtER8urR06hJlpGRbya6OcCvxTCBVHvGdIApdsBHcGard7Onbo
         p9ODJHkKXRgz9MfT5xFLkRG3tVdNoDkLWH90Ybg9bgaJL6sR3yf0Tx28Ij2+z9bIRbT1
         G66iCj9jK47arLtuqV7whHAz5pYEbSS8bdLXbkeUkwqxosVwjbAePgJETzR1II6GtTfh
         fX/mrl3iVOl6Fim1+gMA79su3ymFfdPN3uaikqzgoMdAr2IfRUY9d36k2wCfsy32YaWZ
         YU6g==
X-Forwarded-Encrypted: i=1; AJvYcCXEXhwiwuqYtq/6aUgYeDezLMWjkaJEd1yBiVI7t507ktrK8s1nLwlt61Pueffff2QmgDEqXs6amB7c52cMQ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMq1NinfQ2S7Le4B+bvd1oPypwHd9I39/4Y5fyXYR3ZG7CLPl
	rnUR0t/AHEFz/MjtGx9rOkutuL4QjEwM5wwDr41fH//QI4QwgV3ue2OijeVzw/JL1so=
X-Gm-Gg: ASbGnct+ofoKzqqeU4oUXanAh0YpECWnQJZ0SAlXcqNlY0a6QeE2n12olIMMmeb9sE6
	ldP4yJ9ZbrW+sgCmQAyc2rfgk9p0Pvr8HqT6AvOcvBNtmxZHQJEbpFvgwDEM8yLz0lgCOyOLPm3
	qjh4d5SjzJJwoCi1a9+2lT8oHjOcrxjKuKIqwcO0WwpMEdLnSJF1lH+ax+017BdQRWx/lxr/rY4
	wJvvq/k4sZbWMrUpXY2E50IjcxkwGNDW2Pb1xxUlY9mCH9urjaTs1Mb7xHZ7Qc+Q49xyAGjJy2r
	m0eXuVUaY1687P5Z6MXmV2iPrNTgKYwaZoePVL/OyOkJJRrwTPYUjIaKFdL6nbJ/19dvjVe+/sh
	mxlN3a4mIRzq6aZ9FxiDwzqaMQ3pbAy7Jwsf48A==
X-Google-Smtp-Source: AGHT+IHv/pm8C6Vg1DlmbMpGzYmwn15dUZmVj+OGH1eB8tYAsdCAdHs/VwzEpAF3q+1/MeeENuZ7iA==
X-Received: by 2002:a05:6214:c62:b0:6fa:ce21:cad with SMTP id 6a1803df08f44-6faceba0587mr25686446d6.18.1748558172150;
        Thu, 29 May 2025 15:36:12 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-224-24.bstnma.fios.verizon.net. [108.26.224.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4d02esm14208586d6.42.2025.05.29.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 15:36:11 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>
Subject: [kvm-unit-tests PATCH] riscv: sbi: Add SBI Debug Triggers Extension tests
Date: Thu, 29 May 2025 15:36:10 -0700
Message-ID: <20250529223611.644410-1-jesse@rivosinc.com>
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
 lib/riscv/asm/sbi.h |  28 ++
 lib/riscv/sbi.c     |  58 ++++
 riscv/Makefile      |   1 +
 riscv/sbi-dbtr.c    | 703 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/sbi-tests.h   |   1 +
 riscv/sbi.c         |   1 +
 6 files changed, 792 insertions(+)
 create mode 100644 riscv/sbi-dbtr.c

diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
index a5738a5c..ce19ab89 100644
--- a/lib/riscv/asm/sbi.h
+++ b/lib/riscv/asm/sbi.h
@@ -51,6 +51,7 @@ enum sbi_ext_id {
 	SBI_EXT_SUSP = 0x53555350,
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_SSE = 0x535345,
+	SBI_EXT_DBTR = 0x44425452,
 };
 
 enum sbi_ext_base_fid {
@@ -125,6 +126,17 @@ enum sbi_ext_fwft_fid {
 
 #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
 
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
 enum sbi_ext_sse_fid {
 	SBI_EXT_SSE_READ_ATTRS = 0,
 	SBI_EXT_SSE_WRITE_ATTRS,
@@ -282,6 +294,22 @@ static inline bool sbi_sse_event_is_global(uint32_t event_id)
 	return !!(event_id & SBI_SSE_EVENT_GLOBAL_BIT);
 }
 
+struct sbiret sbi_debug_num_triggers(unsigned long trig_tdata1);
+struct sbiret sbi_debug_set_shmem(void *shmem);
+struct sbiret sbi_debug_set_shmem_raw(unsigned long shmem_phys_lo,
+				      unsigned long shmem_phys_hi,
+				      unsigned long flags);
+struct sbiret sbi_debug_read_triggers(unsigned long trig_idx_base,
+				      unsigned long trig_count);
+struct sbiret sbi_debug_install_triggers(unsigned long trig_count);
+struct sbiret sbi_debug_update_triggers(unsigned long trig_count);
+struct sbiret sbi_debug_uninstall_triggers(unsigned long trig_idx_base,
+					   unsigned long trig_idx_mask);
+struct sbiret sbi_debug_enable_triggers(unsigned long trig_idx_base,
+					unsigned long trig_idx_mask);
+struct sbiret sbi_debug_disable_triggers(unsigned long trig_idx_base,
+					 unsigned long trig_idx_mask);
+
 struct sbiret sbi_sse_read_attrs_raw(unsigned long event_id, unsigned long base_attr_id,
 				     unsigned long attr_count, unsigned long phys_lo,
 				     unsigned long phys_hi);
diff --git a/lib/riscv/sbi.c b/lib/riscv/sbi.c
index 2959378f..39c0d3bd 100644
--- a/lib/riscv/sbi.c
+++ b/lib/riscv/sbi.c
@@ -32,6 +32,64 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 	return ret;
 }
 
+struct sbiret sbi_debug_num_triggers(unsigned long trig_tdata1)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS, trig_tdata1, 0, 0, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_set_shmem(void *shmem)
+{
+	phys_addr_t p = virt_to_phys(shmem);
+
+	return sbi_debug_set_shmem_raw(lower_32_bits(p), upper_32_bits(p), 0);
+}
+
+struct sbiret sbi_debug_set_shmem_raw(unsigned long shmem_phys_lo,
+				      unsigned long shmem_phys_hi,
+				      unsigned long flags)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM, shmem_phys_lo,
+			 shmem_phys_hi, flags, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_read_triggers(unsigned long trig_idx_base,
+				      unsigned long trig_count)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_READ, trig_idx_base,
+			 trig_count, 0, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_install_triggers(unsigned long trig_count)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL, trig_count, 0, 0, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_update_triggers(unsigned long trig_count)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UPDATE, trig_count, 0, 0, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_uninstall_triggers(unsigned long trig_idx_base,
+					   unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UNINSTALL, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_enable_triggers(unsigned long trig_idx_base,
+					unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_ENABLE, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+struct sbiret sbi_debug_disable_triggers(unsigned long trig_idx_base,
+					 unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_DISABLE, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
 struct sbiret sbi_sse_read_attrs_raw(unsigned long event_id, unsigned long base_attr_id,
 				     unsigned long attr_count, unsigned long phys_lo,
 				     unsigned long phys_hi)
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
index 00000000..e557aae1
--- /dev/null
+++ b/riscv/sbi-dbtr.c
@@ -0,0 +1,703 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SBI DBTR testsuite
+ *
+ * Copyright (C) 2025, Rivos Inc., Jesse Taube <jesse@rivosinc.com>
+ */
+
+#include <asm/io.h>
+
+#include "sbi-tests.h"
+
+#define INSN_LEN(insn)			((((insn) & 0x3) < 0x3) ? 2 : 4)
+
+#if __riscv_xlen == 64
+#define SBI_DBTR_SHMEM_INVALID_ADDR	0xFFFFFFFFFFFFFFFFUL
+#elif __riscv_xlen == 32
+#define SBI_DBTR_SHMEM_INVALID_ADDR	0xFFFFFFFFUL
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define RV_MAX_TRIGGERS     32
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
+typedef enum {
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
+} McontrolType;
+
+typedef enum {
+	VALUE_NONE =	0,
+	VALUE_LOAD =	BIT(0),
+	VALUE_STORE =	BIT(1),
+	VALUE_EXECUTE =	BIT(2),
+} Tdata1Value;
+
+typedef enum {
+	MODE_NONE =	0,
+	MODE_M =	BIT(0),
+	MODE_U =	BIT(1),
+	MODE_S =	BIT(2),
+	MODE_VU =	BIT(3),
+	MODE_VS =	BIT(4),
+} Tdata1Mode;
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
+// Expected to be leaf function as not to disrupt frame-pointer
+static __attribute__((naked)) void exec_call(void)
+{
+	// skip over nop when triggered instead of ret.
+	asm volatile ("nop\n"
+		      "nop\n"
+		      "ret\n");
+}
+
+static void dbtr_exception_handler(struct pt_regs *regs)
+{
+	dbtr_handled = true;
+
+	/* Reading may cause a fault, skip over two nops if compressed, one if not */
+	if ((void *)regs->epc == exec_call) {
+		regs->epc += 4;
+		return;
+	}
+
+	/* WARNING: Skips over the trapped intruction */
+	regs->epc += INSN_LEN(readw((void *)regs->epc));
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
+static unsigned long gen_tdata1_mcontrol(Tdata1Mode mode, Tdata1Value value)
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
+static unsigned long gen_tdata1_mcontrol6(Tdata1Mode mode, Tdata1Value value)
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
+static unsigned long gen_tdata1(McontrolType type, Tdata1Value value, Tdata1Mode mode)
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
+
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
+
+	//sbi_debug_num_triggers will return trig_max in sbiret.value when trig_tdata1 == 0
+	unsigned long tdata1 = 0;
+
+	// should be atleast one trigger.
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
+
+	if (ret.value == 0)
+		report_fail("sbi_debug_num_triggers: Returned 0 triggers avalible");
+	else
+		report_pass("sbi_debug_num_triggers: Returned %lu triggers avalible", ret.value);
+
+	return ret.value;
+}
+
+static McontrolType dbtr_test_type(unsigned long *num_trig)
+{
+	struct sbiret ret;
+
+	//sbi_debug_num_triggers will return trig_max in sbiret.value when trig_tdata1 == 0
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
+
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
+	if (ret.value > 0) {
+		report_pass("sbi_debug_num_triggers: Returned %lu mcontrol6 triggers avalible",
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
+		report_pass("sbi_debug_num_triggers: Returned %lu mcontrol triggers avalible",
+			    ret.value);
+		return tdata1;
+	}
+
+	report_fail("sbi_debug_num_triggers: Returned 0 mcontrol(6) triggers avalible");
+
+	return SBI_DBTR_TDATA1_TYPE_NONE;
+}
+
+static struct sbiret dbtr_test_save_install_uninstall(struct sbi_dbtr_shmem_entry *shmem,
+						      McontrolType type)
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
+	if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers"))
+		return ret;
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
+static void dbtr_test_update(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("update_trigger");
+
+	dbtr_install_trigger(shmem, NULL, gen_tdata1(type, VALUE_NONE, MODE_NONE));
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
+static void dbtr_test_load(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+
+	report_prefix_push("load_trigger");
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_LOAD, MODE_S) | 1);
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
+static void dbtr_test_disable_enable(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("sbi_debug_disable_triggers");
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S));
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
+static void dbtr_test_exec(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+
+	report_prefix_push("exec_trigger");
+	/* check if loads and saves trigger exec */
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_EXECUTE, MODE_S));
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
+	dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S));
+	report(do_exec(), "exec trigger");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_read(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	const unsigned long tstatus_expected = SBI_DBTR_TRIG_STATE_S | SBI_DBTR_TRIG_STATE_MAPPED;
+	const unsigned long tdata1 = gen_tdata1(type, VALUE_STORE, MODE_S);
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("sbi_debug_read_triggers");
+	dbtr_install_trigger(shmem, &test, tdata1);
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
+		struct sbiret ret;
+
+		report(do_exec(), "exec triggered");
+
+		ret = sbi_debug_uninstall_triggers(base, 1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+}
+
+static void dbtr_test_multiple(struct sbi_dbtr_shmem_entry *shmem, McontrolType type,
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
+	dbtr_install_trigger(shmem, &test[0], gen_tdata1(type, VALUE_STORE, MODE_S));
+	dbtr_install_trigger(shmem, &test[1], gen_tdata1(type, VALUE_LOAD, MODE_S));
+	if (have_three)
+		dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S));
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
+	if (!have_three) {
+		dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S));
+		check_exec(1);
+	}
+
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
+	dbtr_install_trigger(shmem, &test,
+			     gen_tdata1(type, VALUE_EXECUTE | VALUE_LOAD | VALUE_STORE, MODE_S));
+
+	report(do_load(&test), "load trigger");
+
+	report(do_save(&test), "save trigger");
+
+	dbtr_uninstall_trigger();
+
+	/* Check if exec works */
+	dbtr_install_trigger(shmem, exec_call,
+			     gen_tdata1(type, VALUE_EXECUTE | VALUE_LOAD | VALUE_STORE, MODE_S));
+
+	report(do_exec(), "exec trigger");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_disable_unistall(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("disable uninstall");
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S));
+
+	ret = sbi_debug_disable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_disable_triggers");
+
+	dbtr_uninstall_trigger();
+
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S));
+
+	report(do_save(&test), "triggered");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_unistall_enable(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("uninstall enable");
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S));
+
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
+static void dbtr_test_unistall_update(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("uninstall update");
+	dbtr_install_trigger(shmem, NULL, gen_tdata1(type, VALUE_NONE, MODE_NONE));
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
+static void dbtr_test_disable_read(struct sbi_dbtr_shmem_entry *shmem, McontrolType type)
+{
+	const unsigned long tstatus_expected = SBI_DBTR_TRIG_STATE_S | SBI_DBTR_TRIG_STATE_MAPPED;
+	const unsigned long tdata1 = gen_tdata1(type, VALUE_STORE, MODE_NONE);
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("disable_read");
+	dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S));
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
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+void check_dbtr(void)
+{
+	static struct sbi_dbtr_shmem_entry shmem[RV_MAX_TRIGGERS] = {};
+	unsigned long num_trigs;
+	McontrolType trig_type;
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
+		return;
+
+	trig_type = dbtr_test_type(&num_trigs);
+	if (trig_type == SBI_DBTR_TDATA1_TYPE_NONE)
+		return;
+
+	ret = sbi_debug_set_shmem(shmem);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem");
+
+	ret = dbtr_test_save_install_uninstall(&shmem[0], trig_type);
+	/* install or unistall failed */
+	if (ret.error != SBI_SUCCESS)
+		return;
+
+	dbtr_test_load(&shmem[0], trig_type);
+	dbtr_test_exec(&shmem[0], trig_type);
+	dbtr_test_read(&shmem[0], trig_type);
+	dbtr_test_disable_enable(&shmem[0], trig_type);
+	dbtr_test_update(&shmem[0], trig_type);
+	dbtr_test_multiple_types(&shmem[0], trig_type);
+	dbtr_test_multiple(shmem, trig_type, num_trigs);
+	dbtr_test_disable_unistall(&shmem[0], trig_type);
+	dbtr_test_unistall_enable(&shmem[0], trig_type);
+	dbtr_test_unistall_update(&shmem[0], trig_type);
+	dbtr_test_disable_read(&shmem[0], trig_type);
+
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


