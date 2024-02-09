Return-Path: <linux-kselftest+bounces-4384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93E84F052
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 07:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328841C23D5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4265BCA;
	Fri,  9 Feb 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="EzJmaNkv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A04657D4
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460865; cv=none; b=DB+X5W77dZb5ZoL4454bMOFfas8/rpWpFiJhT2K7xDw2mhnKuBxuqvdgP+nA/aOfjY4nsy3ZsPCdFuIx3+wy1vkT+J+n0hFmfBm09hV0QeprAxr4jICPM0LVMfrmmpzWnEmaiCi8Bv6WI1fkpjdWEUFvOL408xxqHct+ve7e6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460865; c=relaxed/simple;
	bh=uU0PO3OZf2iUz0gGhE0y9kQtipSBlOMMES8f3o99Jp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVBjuFl9dW0IUjqXE3MBEf0WUtq7baV5+ZJvDSO6YMU4YtRzeJTlWGQ/tEw1BHYs7xORcPNcNAc3uUE4xcBBUiONXGoIuTjnSljrOg/fn2eQPtcCJugc97HVzR4kCswrYcc8laG2MXQYpgeD3wed+iEz8weRIYiRLVlbBSexXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=EzJmaNkv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so78994466b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 22:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1707460860; x=1708065660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Iy+qb8cqxclx2b4u4iSMkolO0A5gDplvFNecdg0ef0=;
        b=EzJmaNkv78fjYfXOcvcx0CeYhMxaz2ligpdFFkx+tA4xXxpSDcRxzPhLXmzzhOYVrZ
         XORjP5Gjm366mkfHS4H9t8JHTNio7Af2cHm9acDukzzAm446D+L2t6xnh2k8H3d6A4U9
         x543gy5sfddYkFiBFVvUHm+RZbh6hUy6NM9ysNz7y9QkF1DN+Lh0hrXP2ZqufT/YUMZX
         w3/gpFXVf2RMh+iNTy4rSd2q1qQPwXSjryAJjykvO3WaNTot0mOUJogq2VJGEVH2cD15
         IuHQvlO08RirGxzFvKU8dTbmx9a49SzVIc1Wx1PbTc0sPU4sX9pDVRBrCZibq84EkFnk
         gAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460860; x=1708065660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Iy+qb8cqxclx2b4u4iSMkolO0A5gDplvFNecdg0ef0=;
        b=DaDdvKCuhHCqjgKQzIpztUPZRl3SiMpk2G5t+bjYZ7NmqjPxgnwJHGwPY2X3AENvbs
         r0Xpm5QzwEEwoUhxkKJ93ha//hXB1WjokiMeOlwSLnaP+prShf8o289FymZ9d/uPsnJO
         61b8Tmw4RdgN221N9ZHsFkOXn353UgTmBIdX0NjCODDR51t0lW6XddjAH1cEYqNXidTa
         N5xeX16zEAH5pszPwGyd9HEIp5gLpc5sVdc5OF9A8ACEsbuU1+dZihvPOti6zzfz8JTW
         w/hc4WyfcLNF+2ZsjY5Z5ieKqDp0T2zwiuJ1bWatpqS7x92XIcznNzL32d2iT4btsic5
         Jc7A==
X-Gm-Message-State: AOJu0YwANud2HOB6WXMZQK+wYZ/sg0Q5G3/38GsSj+ezb+b/bihViCXc
	t3bNxGBH2iMrP7gIUMJYvvNk0EKqnd+2DBhPxpNcD2TUb2OC2GYl5caYe+SfvAMFNEdV+C8a21V
	9o04=
X-Google-Smtp-Source: AGHT+IGWG9nd+Kfmz7RZ7epqow+tvQ3hOS+FSn8n3iqZKNodfZG8lzKrxgzFpIiKDWC28PJLXwIyaw==
X-Received: by 2002:a17:906:4a45:b0:a37:625d:397d with SMTP id a5-20020a1709064a4500b00a37625d397dmr485869ejv.44.1707460860511;
        Thu, 08 Feb 2024 22:41:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX71W5p9A9pSxDne91E1S+4dp8HZwpU0zSjneWfoUp5Vt++iXRw5L1lGgzZko6taQEC94C0rij3mTasjZ0imQ33SelhsJS8vXg4MFZtDCv3a9Gu1ybl3KXUIVa/k6uPIBveTIa7wX2YUYYpaN/AncLrj6jhN7f4uDuH3v0+HXBHBXVavl0bmm2QP2neV+G7RfmU6WvDDb68V6ZsmTsUexb0+hxKOgQTUyOGKVs/ElNaFdvJpmrYOWVlHO/+fINXm02jH5erk/ApvVYwhuWTS83Z1B2DnGQy50tkRqCxt4mvAZptPoEZCqEd6XOTmHSOSzwz3AsaNcBpM4dGGBcNxAsOghL32JGvy6vXlrPeegNpxjHokJdnMSwPOyx7T8mEdpY0CuITCe+uhB2WiyuEJ3NZEysAY/GF2uFXej92BT6tDCuuFJJ4uEwVNTsD9De0/gTCETvzUMtB0D0KUoCuMGitSAdyiKvG0doTkND9n9FXzJ3Nle8XkRSutC6b6qdobtfR0tbHInlRn9BG9rEjmMisBCVeW4ZHYzTUS3iMwDwLxFTyrHfHtpuzOUWPvLrcMUgHOMqGTbJRM+8NNjzOr/cX6QKD5lg3uGrTc4TWWFgxvJM2dVt9n3YpvTQ2QGbVPL6BvDdbUEfkLaq+86GBL0CjzxWC0Kj9KubMYkgcqf6gmMYCY8MPnSvP3UBJU8na4T4zRLNMQtPrpqC+kX3yyoGzBNXpldu4u9aoCrp+KpWj/EZtCX057UdjBZclhwV+K+RRcmRfBL3EInLWnKOO9xfh9FMp9OsQqlp4hK6GphEw5217o/PLI9FDc6/pJl5Jv8xPfNoOB3RtxRkwBx541UsO373RLlu50htB1kQEZIushg==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a370a76d3a0sm441180ejc.123.2024.02.08.22.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:40:59 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Brendan Sweeney <turtwig@utexas.edu>,
	Andrew Waterman <andrew@sifive.com>,
	Brendan Sweeney <brs@berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Hans Boehm <hboehm@google.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH v2 3/6] RISC-V: Enable dynamic memory consistency model support with Ssdtso
Date: Fri,  9 Feb 2024 07:40:47 +0100
Message-ID: <20240209064050.2746540-4-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
References: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch implements dynamic memory consistency switching on RISC-V
using the Ssdtso ISA extension.

Ssdtso is a RISC-V ISA extension, which allows to switch the memory
consistency model of less privileged modes from RVWMO to TSO at runtime.
The active model is controlled by a DTSO bit in the {m,h,s}envcfg CSRs
(per-hart state).

TSO is a stronger memory ordering than RVWMO, which means that
executing software that was written for RVWMO can also run under TSO
without causing memory consistency issues.
Since RVWMO is the default model, switching to TSO is safe.

The patch introduces Ssdtso basic support:
* enable dynamic memory consistency switching if Ssdtso support is
  enabled in the kernel config
* define the relevant envcfg bits
* add the relevant code to store/restore the DTSO state
* register the the extension in hwcap/cpufeatures
* extend task_struct to keep the state across context switches
* add a Kconfig symbol to disable Ssdtso support

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/Kconfig                 | 11 ++++
 arch/riscv/include/asm/csr.h       |  1 +
 arch/riscv/include/asm/dtso.h      | 97 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/hwcap.h     |  1 +
 arch/riscv/include/asm/switch_to.h |  3 +
 arch/riscv/kernel/asm-offsets.c    |  3 +
 arch/riscv/kernel/cpufeature.c     |  1 +
 7 files changed, 117 insertions(+)
 create mode 100644 arch/riscv/include/asm/dtso.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..1b26797e7cdd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_DYNAMIC_MEMORY_CONSISTENCY_MODEL if RISCV_ISA_SSDTSO
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
@@ -480,6 +481,16 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSDTSO
+	bool "Ssdtso extension support for dynamic TSO memory ordering"
+	default y
+	help
+	  Adds support to dynamically detect the presence of the Ssdtso
+	  ISA-extension and allows user-space processes to activate/deactivate
+	  the TSO memory ordering model at run-time.
+
+	  If you don't know what to do here, say Y.
+
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 510014051f5d..83e5737d720d 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -194,6 +194,7 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_DTSO			(_AC(1, UL) << 8)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
diff --git a/arch/riscv/include/asm/dtso.h b/arch/riscv/include/asm/dtso.h
new file mode 100644
index 000000000000..25f9bb30884e
--- /dev/null
+++ b/arch/riscv/include/asm/dtso.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023 Christoph Muellner <christoph.muellner@vrull.eu>
+ */
+
+#ifndef __ASM_RISCV_DTSO_H
+#define __ASM_RISCV_DTSO_H
+
+#define RISCV_MEMORY_CONSISTENCY_MODEL_WMO     0
+#define RISCV_MEMORY_CONSISTENCY_MODEL_TSO     1
+
+#ifdef CONFIG_RISCV_ISA_SSDTSO
+
+#include <linux/sched/task_stack.h>
+#include <asm/cpufeature.h>
+#include <asm/csr.h>
+
+static __always_inline bool has_dtso(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSDTSO);
+}
+
+static __always_inline bool has_ztso(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_ZTSO);
+}
+
+static inline bool dtso_is_enabled(void)
+{
+	if (has_dtso())
+		return csr_read(CSR_SENVCFG) & ENVCFG_DTSO;
+	return 0;
+}
+
+static inline void dtso_disable(void)
+{
+	if (has_dtso() && !has_ztso())
+		csr_clear(CSR_SENVCFG, ENVCFG_DTSO);
+}
+
+static inline void dtso_enable(void)
+{
+	if (has_dtso() && !has_ztso())
+		csr_set(CSR_SENVCFG, ENVCFG_DTSO);
+}
+
+static inline unsigned long get_memory_consistency_model(
+		struct task_struct *task)
+{
+	return task->memory_consistency_model;
+}
+
+static inline void set_memory_consitency_model(struct task_struct *task,
+		unsigned long model)
+{
+	task->memory_consistency_model = model;
+}
+
+static inline void dtso_restore(struct task_struct *task)
+{
+	unsigned long cur_model = get_memory_consistency_model(task);
+
+	if (cur_model == RISCV_MEMORY_CONSISTENCY_MODEL_TSO)
+		dtso_enable();
+	else
+		dtso_disable();
+}
+
+static inline void __switch_to_dtso(struct task_struct *prev,
+				    struct task_struct *next)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(prev);
+
+	/*
+	 * We don't need to save the DTSO bit, because we don't expect it to
+	 * change. So any mechanism that changes the DTSO bit, needs to take
+	 * care to write to task->memory_consistency_model (and reschedule
+	 * all threads of the process).
+	 */
+
+	dtso_restore(next);
+}
+
+#else /* ! CONFIG_RISCV_ISA_SSDTSO */
+
+static __always_inline bool has_dtso(void) { return false; }
+static __always_inline bool dtso_is_enabled(void) { return false; }
+#define dtso_disable() do { } while (0)
+#define dtso_enable() do { } while (0)
+#define dtso_restore(task) do { } while (0)
+#define __switch_to_dtso(prev, next) do { } while (0)
+
+#endif /* CONFIG_RISCV_ISA_SSDTSO */
+
+#endif /* ! __ASM_RISCV_DTSO_H */
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5340f818746b..88740f419d13 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,6 +80,7 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_SSDTSO		74
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7efdb0584d47..bedf7fe12c1d 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -9,6 +9,7 @@
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
 #include <asm/vector.h>
+#include <asm/dtso.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -80,6 +81,8 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	if (has_dtso())					\
+		__switch_to_dtso(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a03129f40c46..b5dc39788c41 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -80,6 +80,9 @@ void asm_offsets(void)
 #ifdef CONFIG_STACKPROTECTOR
 	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
 #endif
+#ifdef CONFIG_DYNAMIC_MEMORY_CONSISTENCY_MODEL
+	OFFSET(TASK_MEM_CONSISTENCY_MODEL, task_struct, memory_consistency_model);
+#endif
 
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 	OFFSET(PT_EPC, pt_regs, epc);
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..b63d6b699238 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -303,6 +303,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssdtso, RISCV_ISA_EXT_SSDTSO),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
-- 
2.43.0


