Return-Path: <linux-kselftest+bounces-36214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F869AF043E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA0189DE94
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C601C5D6A;
	Tue,  1 Jul 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FSby0eR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89778F5D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400053; cv=none; b=btftqcnxfvK0koGwtU0buDd45RiQIR6zdtT9GmloWEzhIcHJyn4/rRXqBtXBd0FycuTCyyZAQ+h05fVVJfoG/g7Myn9jCLH4OMYQ0RyvoX4P8eVyBCk2JfyOs7dtH/ckRCEZ0XQNtDiLpfZ2vVzxESr3gyyFykGLOFPQEdjLXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400053; c=relaxed/simple;
	bh=WcVFOiELnw+PnEd91G3I1oqBykOfj/UPfk3tS8mhf3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgzSUIUPQGqqqsCC/JuB5aR0hXSCHF4kRaPmQTWmhshVokUqLlEBbnAyT7eSxmbtIflfY8XPyJHSyYuSn5GrXvcJV/hkSCffrgDgtVFrwKCCcveIrbyN4ftiaQMDqaDR7ub9ZnnVH0S2ZzsFIv/J3X9O8J+0rF2WHDlo6CAvONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FSby0eR7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so61195446d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751400049; x=1752004849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gT9KU2DHUO6wiBS867W/RUbF9POiOZDT89LSKeAocM=;
        b=FSby0eR7v+PORjIgd/LHGTeSoedcRdGkma/iPdHAHalFqnkhqJnvRbgBStieNRhxqg
         08xu4mLh7SjdafQ3bQsPtFOOB8R7NfTCz8BML+WKx2xD0tUB/JLUz5AKtSWwy0AVh62N
         gftkdT0p6pwrm/v9COCT59ajbKnJhdMYZKURSd+rWxENucTCFr8iYoRxfUtUDm3d215B
         q/oE5HsC2pwmTDDaPFzwwaKdGh//ueIynLVHYB53S9kshHxJEsYkdqgUs23QvtJhsKNp
         rDgJ4qlWCL3kQFC2VGjQ/LnB9RaSjItcX8riZL8tfKwtulqerMhmOL0hJeG/5PmfBD3d
         dXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751400049; x=1752004849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gT9KU2DHUO6wiBS867W/RUbF9POiOZDT89LSKeAocM=;
        b=nHdhd+AiVIcefGW9cZLaKOh/JqgjilWa7q8KYnqakgM+jR1R/2YFl5Qm+0f93ERxzl
         qw40bl7TcHeuTIWKn4V+Z2MU47gT8TxbunvOzECRaXtGhUa2SQgYKHHfqNtg16NB3lQY
         ZOIFuuF6A/hMlA6KQBwhM/efBarUtAj7m2hCXfF+X6/h4AuO+jMRd70VoJocz3paKFLp
         sldx0FSEj6rAVGCI297lnCQNe8hNXz6GiekZw3fVZeziFW7biYPorKGp/k8nG5ecZKlO
         d0vP9mESQ59Pf3cvMpR8q1eHZ+xG0KsQQbUra5Hjzu70fMyqdj5Vi72X/B+CvhBMwXAg
         DGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAbvvcGjUozN0Ulz9F4uXHeqjnkEwGyDAiHSnVHNuELwFLHdk3sFvmAUFdF9/bEQQxH55V/L1knZgQn5yqox4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaDcPy+GKCUPL4/LsdKYSBXno89vy+hu0t2xgK9fSg1S+qFT3
	/+D8MLJbvuC3ZFG6plwGXRw1vnpiB18GfB5hsaE9OX/lpLMU1O8suiD4lBNWUbj/tg1fOtIcchf
	iSfQc
X-Gm-Gg: ASbGncuacQu4YZmGJbny8BSn2lBt1VokHALLV9mvU4t//Ysd2+vCMJWOtmh9iTfT4iU
	xgk3ssEg3Brp+PzpYNR7PxPw52HYN0qQC1jQB1iuNKQHhVJH+sKugm39PmYo70br96A04YyctF9
	lvOH3cXc0w4Q8SlkE04/9+1v5dd89hV3QotR3WyLj9XKi4RT7JG3b6ESjqiyBo3ZJnsxGUmtNH3
	JEERmMV1NLqCwMjEF7f3zoFOuB8wHnxhGRw8WgeccJAE4NxefuckrArB/zq9mJrbKbKzmuffCsr
	/dDa+LKZj8UwyrVeNQeUqlcXzg860tGPdOfMuDle+2M8ioxgWOCDgj0dFOtbumBDGwJuqWl7C2E
	=
X-Google-Smtp-Source: AGHT+IEp4tCCTAHKP7uN0eNNNAIstlCM+dsjw2VFF/VJEG98xLU4caRT8sIiJfsWLQ5cP1SsouYB9g==
X-Received: by 2002:a05:6214:5a08:b0:6ed:19d1:212f with SMTP id 6a1803df08f44-6ffed7a5801mr318145296d6.5.1751400048671;
        Tue, 01 Jul 2025 13:00:48 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com ([96.224.57.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e4305sm89176786d6.66.2025.07.01.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 13:00:48 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>
Subject: [kvm-unit-tests PATCH v8] riscv: sbi: Add SBI Debug Triggers Extension tests
Date: Tue,  1 Jul 2025 13:00:47 -0700
Message-ID: <20250701200047.1367077-1-jesse@rivosinc.com>
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
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
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
V4 -> V5:
 - Sort includes
 - Add kfail for update triggers
V5 -> V6:
 - Add assert in gen_tdata1
 - Add prefix to dbtr_test_type
 - Add TRIG_STATE_DMODE
 - Add TRIG_STATE_RESERVED
 - Align function paramaters with opening parenthesis
 - Change OpenSBI < v1.7 to < v1.5
 - Constantly use spaces in prefix rather than _
 - Export split_phys_addr
 - Fix MCONTROL_U and MCONTROL_M mix up
 - Fix swapped VU and VS
 - Move /* to own line
 - Print type in dbtr_test_type
 - Remove _BIT suffix from macros
 - Remove duplicate MODE_S
 - Remove spaces before include
 - Rename tdata1,2 to trigger and control in dbtr_install_trigger
 - Report skip in dbtr_test_multiple
 - Report variables in info not pass or fail
 - s/save/store/g
 - sbi_debug_set_shmem use split_phys_addr
 - Use if (!report(... in dbtr_test_disable_enable
V6 -> V7:
 - Alphabetize Makefile
 - Only print read info on failure
 - Remove return after assert
 - Remove unnecessary OpenSBI version check
 - Rename error to exit_test in check_dbtr
 - Use prefix in dbtr_test_num_triggers and dbtr_test_type
V7 -> V8:
 - Add mcontrol_size mcontrol6_size
 - Cast McontrolType to int for assert
 - Set trigger size to 32BIT using mcontrol_size
Debug triggers allow traps on different access sizes, which was set to
any. QEMU was triggering on a 32BIT access next to the trigger address
causing an erroneous trap. Set the size to 32BITs to avoid this.
---
 lib/riscv/asm/sbi.h |   1 +
 riscv/Makefile      |   1 +
 riscv/sbi-dbtr.c    | 867 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/sbi-tests.h   |   2 +
 riscv/sbi.c         |   3 +-
 5 files changed, 873 insertions(+), 1 deletion(-)
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
index 11e68eae..9309ac12 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -18,6 +18,7 @@ tests += $(TEST_DIR)/sieve.$(exe)
 all: $(tests)
 
 $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-asm.o
+$(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-dbtr.o
 $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-fwft.o
 $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-sse.o
 
diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
new file mode 100644
index 00000000..13f64015
--- /dev/null
+++ b/riscv/sbi-dbtr.c
@@ -0,0 +1,867 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SBI DBTR testsuite
+ *
+ * Copyright (C) 2025, Rivos Inc., Jesse Taube <jesse@rivosinc.com>
+ */
+
+#include <libcflat.h>
+#include <bitops.h>
+
+#include <asm/io.h>
+#include <asm/processor.h>
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
+#define SBI_DBTR_TRIG_STATE_RESERVED		GENMASK(7, 6)
+
+#define SBI_DBTR_TRIG_STATE_HW_TRIG_IDX_SHIFT		8
+#define SBI_DBTR_TRIG_STATE_HW_TRIG_IDX(trig_state)	(trig_state >> SBI_DBTR_TRIG_STATE_HW_TRIG_IDX_SHIFT)
+
+#define SBI_DBTR_TDATA1_TYPE_SHIFT		(__riscv_xlen - 4)
+#define SBI_DBTR_TDATA1_DMODE			BIT_UL(__riscv_xlen - 5)
+
+#define SBI_DBTR_TDATA1_MCONTROL6_LOAD		BIT(0)
+#define SBI_DBTR_TDATA1_MCONTROL6_STORE		BIT(1)
+#define SBI_DBTR_TDATA1_MCONTROL6_EXECUTE	BIT(2)
+#define SBI_DBTR_TDATA1_MCONTROL6_U		BIT(3)
+#define SBI_DBTR_TDATA1_MCONTROL6_S		BIT(4)
+#define SBI_DBTR_TDATA1_MCONTROL6_M		BIT(6)
+#define SBI_DBTR_TDATA1_MCONTROL6_SIZE_SHIFT	16
+#define SBI_DBTR_TDATA1_MCONTROL6_SIZE_MASK	0x7
+#define SBI_DBTR_TDATA1_MCONTROL6_SELECT	BIT(21)
+#define SBI_DBTR_TDATA1_MCONTROL6_VU		BIT(23)
+#define SBI_DBTR_TDATA1_MCONTROL6_VS		BIT(24)
+
+#define SBI_DBTR_TDATA1_MCONTROL_LOAD		BIT(0)
+#define SBI_DBTR_TDATA1_MCONTROL_STORE		BIT(1)
+#define SBI_DBTR_TDATA1_MCONTROL_EXECUTE	BIT(2)
+#define SBI_DBTR_TDATA1_MCONTROL_U		BIT(3)
+#define SBI_DBTR_TDATA1_MCONTROL_S		BIT(4)
+#define SBI_DBTR_TDATA1_MCONTROL_M		BIT(6)
+#define SBI_DBTR_TDATA1_MCONTROL_SIZELO_SHIFT	16
+#define SBI_DBTR_TDATA1_MCONTROL_SIZELO_MASK	0x3
+#define SBI_DBTR_TDATA1_MCONTROL_SELECT		BIT(19)
+#define SBI_DBTR_TDATA1_MCONTROL_SIZEHI_SHIFT	21
+#define SBI_DBTR_TDATA1_MCONTROL_SIZEHI_MASK	0x3
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
+enum Tdata1Size {
+	SIZE_ANY = 0,
+	SIZE_8BIT,
+	SIZE_16BIT,
+	SIZE_32BIT,
+	SIZE_48BIT,
+	SIZE_64BIT,
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
+static bool do_store(void *tdata2)
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
+static unsigned long mcontrol_size(enum Tdata1Size mode)
+{
+	unsigned long ret = 0;
+
+	ret |= ((mode >> 2) & SBI_DBTR_TDATA1_MCONTROL_SIZEHI_MASK)
+		<< SBI_DBTR_TDATA1_MCONTROL_SIZEHI_SHIFT;
+	ret |= (mode & SBI_DBTR_TDATA1_MCONTROL_SIZELO_MASK)
+		<< SBI_DBTR_TDATA1_MCONTROL_SIZELO_SHIFT;
+
+	return ret;
+}
+
+static unsigned long mcontrol6_size(enum Tdata1Size mode)
+{
+	return (mode & SBI_DBTR_TDATA1_MCONTROL6_SIZE_MASK)
+		<< SBI_DBTR_TDATA1_MCONTROL6_SIZE_SHIFT;
+}
+
+static unsigned long gen_tdata1_mcontrol(enum Tdata1Mode mode, enum Tdata1Value value)
+{
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL;
+
+	if (value & VALUE_LOAD)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_LOAD;
+
+	if (value & VALUE_STORE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_STORE;
+
+	if (value & VALUE_EXECUTE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_EXECUTE;
+
+	if (mode & MODE_M)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_M;
+
+	if (mode & MODE_U)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_U;
+
+	if (mode & MODE_S)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_S;
+
+	return tdata1;
+}
+
+static unsigned long gen_tdata1_mcontrol6(enum Tdata1Mode mode, enum Tdata1Value value)
+{
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
+
+	if (value & VALUE_LOAD)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_LOAD;
+
+	if (value & VALUE_STORE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_STORE;
+
+	if (value & VALUE_EXECUTE)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_EXECUTE;
+
+	if (mode & MODE_M)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_M;
+
+	if (mode & MODE_U)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_U;
+
+	if (mode & MODE_S)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_S;
+
+	if (mode & MODE_VU)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_VU;
+
+	if (mode & MODE_VS)
+		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_VS;
+
+	return tdata1;
+}
+
+static unsigned long gen_tdata1(enum McontrolType type, enum Tdata1Value value, enum Tdata1Mode mode)
+{
+	switch (type) {
+	case SBI_DBTR_TDATA1_TYPE_MCONTROL:
+		return gen_tdata1_mcontrol(mode, value) | mcontrol_size(SIZE_32BIT);
+	case SBI_DBTR_TDATA1_TYPE_MCONTROL6:
+		return gen_tdata1_mcontrol6(mode, value) | mcontrol6_size(SIZE_32BIT);
+	default:
+		assert_msg(false, "Invalid mcontrol type: %u", (int)type);
+	}
+}
+
+static struct sbiret sbi_debug_num_triggers(unsigned long trig_tdata1)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS, trig_tdata1, 0, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_set_shmem_raw(unsigned long shmem_phys_lo,
+					     unsigned long shmem_phys_hi,
+					     unsigned long flags)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM, shmem_phys_lo,
+			 shmem_phys_hi, flags, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_set_shmem(void *shmem)
+{
+	unsigned long base_addr_lo, base_addr_hi;
+
+	split_phys_addr(virt_to_phys(shmem), &base_addr_hi, &base_addr_lo);
+	return sbi_debug_set_shmem_raw(base_addr_lo, base_addr_hi, 0);
+}
+
+static struct sbiret sbi_debug_read_triggers(unsigned long trig_idx_base,
+					     unsigned long trig_count)
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
+						  unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UNINSTALL, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_enable_triggers(unsigned long trig_idx_base,
+					       unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_ENABLE, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+static struct sbiret sbi_debug_disable_triggers(unsigned long trig_idx_base,
+						unsigned long trig_idx_mask)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_DISABLE, trig_idx_base,
+			 trig_idx_mask, 0, 0, 0, 0);
+}
+
+static bool dbtr_install_trigger(struct sbi_dbtr_shmem_entry *shmem, void *trigger,
+				 unsigned long control)
+{
+	struct sbiret sbi_ret;
+	bool ret;
+
+	shmem->data.tdata1 = control;
+	shmem->data.tdata2 = (unsigned long)trigger;
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
+	report_prefix_push("available triggers");
+
+	/* should be at least one trigger. */
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
+
+	if (ret.value == 0) {
+		report_fail("Returned 0 triggers available");
+	} else {
+		report_pass("Returned triggers available");
+		report_info("Returned %lu triggers available", ret.value);
+	}
+
+	report_prefix_pop();
+	return ret.value;
+}
+
+static enum McontrolType dbtr_test_type(unsigned long *num_trig)
+{
+	struct sbiret ret;
+	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
+
+	report_prefix_push("test type");
+	report_prefix_push("sbi_debug_num_triggers");
+
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "mcontrol6");
+	*num_trig = ret.value;
+	if (ret.value > 0) {
+		report_pass("Returned mcontrol6 triggers available");
+		report_info("Returned %lu mcontrol6 triggers available",
+			    ret.value);
+		report_prefix_popn(2);
+		return tdata1;
+	}
+
+	tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL;
+
+	ret = sbi_debug_num_triggers(tdata1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "mcontrol");
+	*num_trig = ret.value;
+	if (ret.value > 0) {
+		report_pass("Returned mcontrol triggers available");
+		report_info("Returned %lu mcontrol triggers available",
+			    ret.value);
+		report_prefix_popn(2);
+		return tdata1;
+	}
+
+	report_fail("Returned 0 mcontrol(6) triggers available");
+	report_prefix_popn(2);
+
+	return SBI_DBTR_TDATA1_TYPE_NONE;
+}
+
+static struct sbiret dbtr_test_store_install_uninstall(struct sbi_dbtr_shmem_entry *shmem,
+						      enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+
+	report_prefix_push("store trigger");
+
+	shmem->data.tdata1 = gen_tdata1(type, VALUE_STORE, MODE_S);
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
+	report(do_store(&test), "triggered");
+
+	if (do_load(&test))
+		report_fail("triggered by load");
+
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
+
+	if (do_store(&test))
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
+	bool kfail;
+
+	report_prefix_push("update trigger");
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
+	/*
+	 * Known broken update_triggers.
+	 * https://lore.kernel.org/opensbi/aDdp1UeUh7GugeHp@ghost/T/#t
+	 */
+	kfail = __sbi_get_imp_id() == SBI_IMPL_OPENSBI &&
+		__sbi_get_imp_version() < sbi_impl_opensbi_mk_version(1, 7);
+	report_kfail(kfail, do_store(&test), "triggered");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_load(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+
+	report_prefix_push("load trigger");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_LOAD, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	report(do_load(&test), "triggered");
+
+	if (do_store(&test))
+		report_fail("triggered by store");
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
+	report_prefix_push("disable trigger");
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	ret = sbi_debug_disable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_disable_triggers");
+
+	if (!report(!do_store(&test), "should not trigger")) {
+		dbtr_uninstall_trigger();
+		report_prefix_pop();
+		report_skip("enable trigger: no disable");
+
+		return;
+	}
+
+	report_prefix_pop();
+	report_prefix_push("enable trigger");
+
+	ret = sbi_debug_enable_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_enable_triggers");
+
+	report(do_store(&test), "triggered");
+
+	dbtr_uninstall_trigger();
+	report_prefix_pop();
+}
+
+static void dbtr_test_exec(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+
+	report_prefix_push("exec trigger");
+	/* check if loads and stores trigger exec */
+	if (!dbtr_install_trigger(shmem, &test, gen_tdata1(type, VALUE_EXECUTE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	if (do_load(&test))
+		report_fail("triggered by load");
+
+	if (do_store(&test))
+		report_fail("triggered by store");
+
+	dbtr_uninstall_trigger();
+
+	/* Check if exec works */
+	if (!dbtr_install_trigger(shmem, exec_call, gen_tdata1(type, VALUE_EXECUTE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+	report(do_exec(), "triggered");
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
+	report_prefix_push("read trigger");
+	if (!dbtr_install_trigger(shmem, &test, tdata1)) {
+		report_prefix_pop();
+		return;
+	}
+
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers");
+
+	if (!report(shmem->data.tdata1 == tdata1, "tdata1 expected: 0x%016lx", tdata1))
+		report_info("tdata1 found: 0x%016lx", shmem->data.tdata1);
+	if (!report(shmem->data.tdata2 == ((unsigned long)&test), "tdata2 expected: 0x%016lx",
+		    (unsigned long)&test))
+		report_info("tdata2 found: 0x%016lx", shmem->data.tdata2);
+	if (!report(shmem->data.tstate == tstatus_expected, "tstate expected: 0x%016lx", tstatus_expected))
+		report_info("tstate found: 0x%016lx", shmem->data.tstate);
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
+	if (num_trigs < 2) {
+		report_skip("test multiple");
+		return;
+	}
+
+	report_prefix_push("test multiple");
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
+	report(do_store(&test[0]), "store triggered");
+
+	if (do_load(&test[0]))
+		report_fail("store triggered by load");
+
+	report(do_load(&test[1]), "load triggered");
+
+	if (do_store(&test[1]))
+		report_fail("load triggered by store");
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
+	report(do_store(&test[0]), "store triggered");
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
+	report_prefix_push("test multiple types");
+
+	/* check if loads and stores trigger exec */
+	if (!dbtr_install_trigger(shmem, &test,
+			     gen_tdata1(type, VALUE_EXECUTE | VALUE_LOAD | VALUE_STORE, MODE_S))) {
+		report_prefix_pop();
+		return;
+	}
+
+	report(do_load(&test), "load triggered");
+
+	report(do_store(&test), "store triggered");
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
+	report(do_exec(), "exec triggered");
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
+	report(do_store(&test), "triggered");
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
+	report(!do_store(&test), "should not trigger");
+
+	install_exception_handler(EXC_BREAKPOINT, NULL);
+	report_prefix_pop();
+}
+
+static void dbtr_test_uninstall_update(struct sbi_dbtr_shmem_entry *shmem, enum McontrolType type)
+{
+	static unsigned long test;
+	struct sbiret ret;
+	bool kfail;
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
+	/*
+	 * Known broken update_triggers.
+	 * https://lore.kernel.org/opensbi/aDdp1UeUh7GugeHp@ghost/T/#t
+	 */
+	kfail = __sbi_get_imp_id() == SBI_IMPL_OPENSBI &&
+		__sbi_get_imp_version() < sbi_impl_opensbi_mk_version(1, 7);
+	ret = sbi_debug_update_triggers(1);
+	sbiret_kfail_error(kfail, &ret, SBI_ERR_FAILURE, "sbi_debug_update_triggers");
+
+	install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
+
+	report(!do_store(&test), "should not trigger");
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
+	report_prefix_push("disable read");
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
+	if (!report(shmem->data.tdata1 == tdata1, "tdata1 expected: 0x%016lx", tdata1))
+		report_info("tdata1 found: 0x%016lx", shmem->data.tdata1);
+	if (!report(shmem->data.tdata2 == ((unsigned long)&test), "tdata2 expected: 0x%016lx",
+		    (unsigned long)&test))
+		report_info("tdata2 found: 0x%016lx", shmem->data.tdata2);
+	if (!report(shmem->data.tstate == tstatus_expected, "tstate expected: 0x%016lx", tstatus_expected))
+		report_info("tstate found: 0x%016lx", shmem->data.tstate);
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
+		goto exit_test;
+	}
+
+	num_trigs = dbtr_test_num_triggers();
+	if (!num_trigs)
+		goto exit_test;
+
+	trig_type = dbtr_test_type(&num_trigs);
+	if (trig_type == SBI_DBTR_TDATA1_TYPE_NONE)
+		goto exit_test;
+
+	ret = sbi_debug_set_shmem(shmem);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem");
+
+	ret = dbtr_test_store_install_uninstall(&shmem[0], trig_type);
+	/* install or uninstall failed */
+	if (ret.error != SBI_SUCCESS)
+		goto exit_test;
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
+exit_test:
+	report_prefix_pop();
+}
diff --git a/riscv/sbi-tests.h b/riscv/sbi-tests.h
index d5c4ae70..c1ebf016 100644
--- a/riscv/sbi-tests.h
+++ b/riscv/sbi-tests.h
@@ -97,8 +97,10 @@ static inline bool env_enabled(const char *env)
 	return s && (*s == '1' || *s == 'y' || *s == 'Y');
 }
 
+void split_phys_addr(phys_addr_t paddr, unsigned long *hi, unsigned long *lo);
 void sbi_bad_fid(int ext);
 void check_sse(void);
+void check_dbtr(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* _RISCV_SBI_TESTS_H_ */
diff --git a/riscv/sbi.c b/riscv/sbi.c
index edb1a6be..3b8aadce 100644
--- a/riscv/sbi.c
+++ b/riscv/sbi.c
@@ -105,7 +105,7 @@ static int rand_online_cpu(prng_state *ps)
 	return cpu;
 }
 
-static void split_phys_addr(phys_addr_t paddr, unsigned long *hi, unsigned long *lo)
+void split_phys_addr(phys_addr_t paddr, unsigned long *hi, unsigned long *lo)
 {
 	*lo = (unsigned long)paddr;
 	*hi = 0;
@@ -1561,6 +1561,7 @@ int main(int argc, char **argv)
 	check_susp();
 	check_sse();
 	check_fwft();
+	check_dbtr();
 
 	return report_summary();
 }
-- 
2.43.0


