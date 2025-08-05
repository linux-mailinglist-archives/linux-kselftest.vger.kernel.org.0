Return-Path: <linux-kselftest+bounces-38322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA9B1BB0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959E3169DDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792D23771E;
	Tue,  5 Aug 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="L2NB6Dj5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3729A333
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422813; cv=none; b=MXIAX6pIyhpazWsFZt6On00iWA4XLiXC+EMNurnp+RksgevMHiKho2aS/Uyk9+GKirtHOVU/1o/jlXKdxHOwjyYvuLhct5F66y5ylvmXp1jeH2e4GdmAGXdLT6RMwmnagNjag74DcjR+laW85xVeWVlL4vx6GAJFoEycnw3eing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422813; c=relaxed/simple;
	bh=uyTuacP70BrJ2Os1lYqDvLJH/NGpV9gy074HUg8RPQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQrtN/tM146WKqQS1qgQE7dGSm8r+cRuXd55iAQqjGFYN/yM89zuGh0jQTYJ53ZWCD/azU34xlsC5RYqX+Ayr29Z/ND4mMpRdNzP6moQnhqG2l1D9YbxxOV7dEEXIoPr6ya7hRylzRx0X2hbXMG7epUZHuVVZeLGulSim4EmX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=L2NB6Dj5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e32cf22fdfso540783285a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422810; x=1755027610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thXWESjgb/asehL5NdNra0dnr/Mi+exiNBPp9wa9z9w=;
        b=L2NB6Dj5spK3TO6SM1iX7tOxmR9RXtucwrDLjI4av/F2VEmWaC6n57iHI9gggVeWev
         jl2MxLtp7Ddz6jorqu1HuphAkDlfRnZe3PyCfifnlhh+UTziRRGtjy8boPkeX/L4A15W
         jQaMXZdIZCkfdnUPasCKxa/i17ceLUiMfdqan6KZtM3tTweT7Cwdp91I2R1v49IZkSwq
         DBXeq5RpIoEM3xsgdx9Vn0tAeDVdRHsDiXxG/1CjW4VJYcHEFvkgi8du4RVIObnqx5/L
         hDZoXvLCTIG9d/szSGQ2YOHLLcfNcW8k7pipuP3gFy18H96UG+MN8KHFeRqPFMfwNRnK
         7bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422810; x=1755027610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thXWESjgb/asehL5NdNra0dnr/Mi+exiNBPp9wa9z9w=;
        b=BSqZuRkNbSJ9IRn48ZT3lXALc9raiACA9tPak0F2tW89Vkn7OytpvNJoaFtFWcptbA
         pUZcoB2g1Pw+j0Bqwh2ajYEuygh99+CgAvNrYN3LL5kxYMGxZdkUfY6rv+T24cw5mxNo
         QrBHKvjgp+9TgxOuvCU6+2P+A7nvuAqT4Sna0ZPxRygJIwNqNcCdDi461cOTfHxWXeNK
         5QQfNB52p80gjjwPijk+apP9rBQLKBnqCoBDyPnl+Yi9o5GHozrYvRCqlgACMHe/sq90
         GuAkPmqNKHtXUiMt7ZBrxFc2Ysvn+riAEmzYYplIDHGvS3WjUNgbWZbPHSNXAsJ7ArXH
         a0kA==
X-Forwarded-Encrypted: i=1; AJvYcCXW0Hy2tKp9mbWOSXq1E7gQ1vHxeIHbeB8B4RxMbyxLSDLXp19JEtyMlS+/ipFJ2EPQmENsO3uQxFJZ9HNzZlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwikEif6N/O7bGqLnfbGb3JI0+flxpwXcOnoqpySdMKQzGpwHX/
	DG7xZLfBxERiunbZ8lSSZhdFqKa6r72w9WgTsHXmQy2drnPUXaafBRY1TcMt2G61zbA=
X-Gm-Gg: ASbGncv6ttyeaMLUlIrRSwIE05OGpMZDFa88Oo+1vj7Ln7PHCVn0bYsZjRC+yim43c2
	LRP5wf9LH2h7lWCcszRwgZuG787yfhH/f0X0gP4p/hetubh4jJ86DwRJHKFu//RFDehopRF7sXd
	HFNnbb9tw7cUROCTOeKVPHkLiXgJ9E70ZRU+Nv6WtiXVWITllknaRH7AZ3uGYI2WTjEDyxRFUCS
	gJiFPjHTY+ICQ33IlVXpxpnWKMYH+KiOo72dZ6812xhEPn6Itqz8rSCJM0ZKScwVXP3Cihn7u59
	o62j8i7WgMVj+Ui07ksbHKw1yxW/CftT/TbGJvyYqKy/5Sbri98p/iC96i1AgJpYUn9/106Ulcf
	xtH/JaVWtjhU2BWv5nHhakR1xTj394Kb+/6XctWVC5Q/Q6UXKu1b6FLa7hw4fVEAOcvNeluW2z5
	VLVWkKrj/ssY+bzk1b
X-Google-Smtp-Source: AGHT+IHrWQTDjfjzvi15pRX0IO+g2I3D2NOE+Jn4xNMsUSUmEfPtUaNSg147K8LghQ8X7ApzfEv/sg==
X-Received: by 2002:a05:620a:15a5:b0:7e6:8147:e683 with SMTP id af79cd13be357-7e814e1cd24mr62137585a.47.1754422809200;
        Tue, 05 Aug 2025 12:40:09 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:08 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley  <conor.dooley@microchip.com>,
	Deepak Gupta  <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/8] riscv: hw_breakpoint: Use icount for single stepping
Date: Tue,  5 Aug 2025 12:39:52 -0700
Message-ID: <20250805193955.798277-6-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805193955.798277-1-jesse@rivosinc.com>
References: <20250805193955.798277-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sdtrig RISC-V ISA extension does not have a resume flag for
returning to and executing the instruction at the breakpoint.
To avoid skipping the instruction or looping, it is necessary to remove
the hardware breakpoint and single step. Use the icount feature of
Sdtrig to accomplish this. Use icount as default with an option to allow
software-based single stepping when hardware or SBI does not have
icount functionality, as it may cause unwanted side effects when reading
the instruction from memory.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
OpenSBI implementation of sbi_debug_read_triggers does not return the
updated CSR values. There needs to be a check for working
sbi_debug_read_triggers before this works.

https://lists.riscv.org/g/tech-prs/message/1476

RFC -> V1:
 - Add dbtr_mode to rv_init_icount_trigger
 - Add icount_triggered to check which breakpoint was triggered
 - Fix typo: s/affects/effects
 - Move HW_BREAKPOINT_COMPUTE_STEP to Platform type
---
 arch/riscv/Kconfig                |  11 ++
 arch/riscv/kernel/hw_breakpoint.c | 179 +++++++++++++++++++++++++++---
 2 files changed, 172 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fd8b62cdc6f5..37f01ed199f3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -546,6 +546,17 @@ config RISCV_COMBO_SPINLOCKS
 
 endchoice
 
+config HW_BREAKPOINT_COMPUTE_STEP
+	bool "Allow computing hardware breakpoint step address"
+	default n
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Select this option if hardware breakpoints are desired, but
+	  hardware or SBI does not have icount functionality. This may cause
+	  unwanted side effects when reading the instruction from memory.
+
+	  If unsure, say N.
+
 config RISCV_ALTERNATIVE
 	bool
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
index 3f96e744a711..1e70ef9e6867 100644
--- a/arch/riscv/kernel/hw_breakpoint.c
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -20,6 +20,7 @@
 #define DBTR_TDATA1_DMODE		BIT_UL(__riscv_xlen - 5)
 
 #define DBTR_TDATA1_TYPE_MCONTROL	(2UL << DBTR_TDATA1_TYPE_SHIFT)
+#define DBTR_TDATA1_TYPE_ICOUNT		(3UL << DBTR_TDATA1_TYPE_SHIFT)
 #define DBTR_TDATA1_TYPE_MCONTROL6	(6UL << DBTR_TDATA1_TYPE_SHIFT)
 
 #define DBTR_TDATA1_MCONTROL6_LOAD		BIT(0)
@@ -62,6 +63,14 @@
 	(FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD, lo) | \
 	 FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD, hi))
 
+#define DBTR_TDATA1_ICOUNT_U			BIT(6)
+#define DBTR_TDATA1_ICOUNT_S			BIT(7)
+#define DBTR_TDATA1_ICOUNT_PENDING		BIT(8)
+#define DBTR_TDATA1_ICOUNT_M			BIT(9)
+#define DBTR_TDATA1_ICOUNT_COUNT_FIELD		GENMASK(23, 10)
+#define DBTR_TDATA1_ICOUNT_VU			BIT(25)
+#define DBTR_TDATA1_ICOUNT_VS			BIT(26)
+
 enum dbtr_mode {
 	DBTR_MODE_U = 0,
 	DBTR_MODE_S,
@@ -79,6 +88,7 @@ static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_dbtr_shmem);
 
 /* number of debug triggers on this cpu . */
 static int dbtr_total_num __ro_after_init;
+static bool have_icount __ro_after_init;
 static unsigned long dbtr_type __ro_after_init;
 static unsigned long dbtr_init __ro_after_init;
 
@@ -129,6 +139,7 @@ static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
 static void init_sbi_dbtr(void)
 {
 	struct sbiret ret;
+	unsigned long dbtr_count = 0;
 
 	/*
 	 * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
@@ -143,6 +154,25 @@ static void init_sbi_dbtr(void)
 		return;
 	}
 
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+		DBTR_TDATA1_TYPE_ICOUNT, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect icount triggers. error: %ld.\n",
+			__func__, ret.error);
+	} else if (!ret.value) {
+		if (IS_ENABLED(CONFIG_HW_BREAKPOINT_COMPUTE_STEP)) {
+			pr_warn("%s: No icount triggers available. "
+				"Falling-back to computing single step address.\n", __func__);
+		} else {
+			pr_err("%s: No icount triggers available.\n", __func__);
+			dbtr_total_num = 0;
+			return;
+		}
+	} else {
+		dbtr_count = ret.value;
+		have_icount = true;
+	}
+
 	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
 			DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
 	if (ret.error) {
@@ -151,7 +181,7 @@ static void init_sbi_dbtr(void)
 	} else if (!ret.value) {
 		pr_warn("%s: No mcontrol6 triggers available.\n", __func__);
 	} else {
-		dbtr_total_num = ret.value;
+		dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
 		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL6;
 		return;
 	}
@@ -166,7 +196,7 @@ static void init_sbi_dbtr(void)
 		pr_err("%s: No mcontrol triggers available.\n", __func__);
 		dbtr_total_num = 0;
 	} else {
-		dbtr_total_num = ret.value;
+		dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
 		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL;
 	}
 }
@@ -320,6 +350,36 @@ static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
 	return 0;
 }
 
+static int rv_init_icount_trigger(struct arch_hw_breakpoint *hw, enum dbtr_mode mode)
+{
+	unsigned long tdata1 = DBTR_TDATA1_TYPE_ICOUNT;
+
+	/* Step one instruction */
+	tdata1 |= FIELD_PREP(DBTR_TDATA1_ICOUNT_COUNT_FIELD, 1);
+
+	switch (mode) {
+	case DBTR_MODE_U:
+		tdata1 |= DBTR_TDATA1_ICOUNT_U;
+		break;
+	case DBTR_MODE_S:
+		tdata1 |= DBTR_TDATA1_ICOUNT_S;
+		break;
+	case DBTR_MODE_VS:
+		tdata1 |= DBTR_TDATA1_ICOUNT_VS;
+		break;
+	case DBTR_MODE_VU:
+		tdata1 |= DBTR_TDATA1_ICOUNT_VU;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hw->tdata1 = tdata1;
+	hw->tdata2 = 0;
+
+	return 0;
+}
+
 int hw_breakpoint_arch_parse(struct perf_event *bp,
 			     const struct perf_event_attr *attr,
 			     struct arch_hw_breakpoint *hw)
@@ -372,24 +432,28 @@ static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
 	/* Remove breakpoint even if return error as not to loop */
 	arch_uninstall_hw_breakpoint(event);
 
-	ret = get_insn_nofault(regs, regs->epc, &insn);
-	if (ret < 0)
-		return ret;
+	if (have_icount) {
+		rv_init_icount_trigger(bp, DBTR_MODE_U);
+	} else {
+		ret = get_insn_nofault(regs, regs->epc, &insn);
+		if (ret < 0)
+			return ret;
 
-	next_addr = get_step_address(regs, insn);
+		next_addr = get_step_address(regs, insn);
 
-	ret = get_insn_nofault(regs, next_addr, &insn);
-	if (ret < 0)
-		return ret;
+		ret = get_insn_nofault(regs, next_addr, &insn);
+		if (ret < 0)
+			return ret;
 
-	bp_insn.bp_type = HW_BREAKPOINT_X;
-	bp_insn.bp_addr = next_addr;
-	/* Get the size of the intruction */
-	bp_insn.bp_len = GET_INSN_LENGTH(insn);
+		bp_insn.bp_type = HW_BREAKPOINT_X;
+		bp_insn.bp_addr = next_addr;
+		/* Get the size of the intruction */
+		bp_insn.bp_len = GET_INSN_LENGTH(insn);
 
-	ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
-	if (ret)
-		return ret;
+		ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
+		if (ret)
+			return ret;
+	}
 
 	ret = arch_install_hw_breakpoint(event);
 	if (ret)
@@ -400,6 +464,79 @@ static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
 	return 0;
 }
 
+/**
+ * icount_triggered - Check if event's icount was triggered.
+ * @event: Perf event to check
+ *
+ * Check the given perf event's icount breakpoint was triggered.
+ *
+ * Returns:	1 if icount was triggered.
+ *		0 if icount was not triggered.
+ *		negative on failure.
+ */
+static int icount_triggered(struct perf_event *event)
+{
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(&sbi_dbtr_shmem);
+	struct sbiret ret;
+	struct perf_event **slot;
+	unsigned long tdata1;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return -ENOENT;
+	}
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+			      *this_cpu_ptr(&ecall_lock_flags));
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
+			i, 1, 0, 0, 0, 0);
+	tdata1 = shmem->data.tdata1;
+
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+				   *this_cpu_ptr(&ecall_lock_flags));
+	if (ret.error) {
+		pr_warn("%s: failed to read trigger. error: %ld\n", __func__, ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	/*
+	 * The RISC-V Debug Specification
+	 * Tim Newsome, Paul Donahue (Ventana Micro Systems)
+	 * Version 1.0, Revised 2025-02-21: Ratified
+	 * 5.7.13. Instruction Count (icount, at 0x7a1)
+	 * When count is 1 and the trigger matches, then pending becomes set.
+	 * In addition count will become 0 unless it is hard-wired to 1.
+	 * When pending is set, the trigger fires just before any further
+	 * instructions are executed in a mode where the trigger is enabled.
+	 * As the trigger fires, pending is cleared. In addition, if count is
+	 * hard-wired to 1 then m, s, u, vs, and vu are all cleared.
+	 */
+	if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) == 0)
+		return 1;
+
+	if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) != 1)
+		return 0;
+
+	if (tdata1 & DBTR_TDATA1_ICOUNT_U)
+		return 0;
+	if (tdata1 & DBTR_TDATA1_ICOUNT_S)
+		return 0;
+	if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
+		return 0;
+	if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
+		return 0;
+	return 1;
+}
+
 /*
  * HW Breakpoint/watchpoint handler
  */
@@ -460,7 +597,10 @@ static int hw_breakpoint_handler(struct pt_regs *regs)
 
 		if (bp->in_callback) {
 			expecting_callback = true;
-			if (regs->epc != bp->next_addr) {
+			if (have_icount) {
+				if (icount_triggered(event) != 1)
+					continue;
+			} else if (regs->epc != bp->next_addr) {
 				continue;
 			}
 
@@ -477,7 +617,10 @@ static int hw_breakpoint_handler(struct pt_regs *regs)
 
 	}
 
-	if (expecting_callback) {
+	if (expecting_callback && have_icount) {
+		pr_err("%s: in_callback was set, but icount was not triggered, epc (%lx).\n",
+		       __func__, regs->epc);
+	} else if (expecting_callback) {
 		pr_err("%s: in_callback was set, but epc (%lx) was not at next address(%lx).\n",
 		       __func__, regs->epc, bp->next_addr);
 	}
-- 
2.43.0


