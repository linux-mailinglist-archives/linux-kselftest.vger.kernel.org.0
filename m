Return-Path: <linux-kselftest+bounces-496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B07F6CCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 08:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931631C20952
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91254420;
	Fri, 24 Nov 2023 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="fkF9OyAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3AD6C
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso211673266b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700810526; x=1701415326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ48+YrsFa7qeiwW9XToPWJsnyGNFxWvEVuNMJnE/C8=;
        b=fkF9OyAJeqoprYldXn5+ppk72A3HYUVLet48J1cFIrOJfy4UOK/H1NRtQ4ZXJhyg/1
         DTJeQjwH6aaAZuz3QVrkbkK7FrNl0Ym+bOaC8oodl7fvvDfU8qe0QywQ7AgiH+90UN7T
         eidnvBAIQMRp16FrtFzCCq3XBC2si/5XuOyzt5N76NWKyg4wOM3d17DOWVssjKhoN/Ja
         SbfFiZ/gahHRwt4OoSu2Jouz7STJRji1mHUrUWLlptez0jaeqAU9+8ZrKEGW4ZVVi6WG
         iJU2k7O8iBCAPkvmHcpiLtzH77e4IK5snFaKl/hPY70MDe1fXoOR8Lp7TIxrSq4VmOdz
         h12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700810526; x=1701415326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZ48+YrsFa7qeiwW9XToPWJsnyGNFxWvEVuNMJnE/C8=;
        b=AlOFhFaGGtZCeuy6/j2KHSIWVkl4vSi+SI22cN0rtNAwSAssw9lLlstognsmfnNU62
         xJ9yeSRlyGWNKZsNUi8xSruyoK4Yz6GP4CKqObp+UhzS3WgU5SLXJHIw2OQ3/G7f07T8
         ORIli3toqBbVbqNXn9HniFYNRk9zXhlWhGhsfKHx/lsRe2SOZ6a19zzetfrVKQruwb5u
         030LjDmxFVyBSmzuXaa3pJW5prlNCb8W6ePXXLqGY5lxN423Sk9GqJ6MvqBKiBXNuPz/
         50MdAKTTGQlXY3z7ggUWLBku2SgTtChir00ZirKQVVTMNzqEeeQEBzQ0IbYCVvxMMg5u
         qIgg==
X-Gm-Message-State: AOJu0YzJdDULgv0qYF/4/rEUecU1iIdqeCUYnpeO5GxFtaeYgkM8a0uw
	bZw7V8oz9gyXmwyAqFZ6O5ulHg==
X-Google-Smtp-Source: AGHT+IGrxBHMPl0kbFz5aJ0kbrWM+mllmiLaiB9I2FJCwXD18VcETZ/Dnt6zPPorDkdAcgvZjQLlKw==
X-Received: by 2002:a17:906:583:b0:a00:893f:58cf with SMTP id 3-20020a170906058300b00a00893f58cfmr1233875ejn.54.1700810526424;
        Thu, 23 Nov 2023 23:22:06 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b00992f2befcbcsm1709930eji.180.2023.11.23.23.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:22:05 -0800 (PST)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
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
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH 1/5] RISC-V: Add basic Ssdtso support
Date: Fri, 24 Nov 2023 08:21:38 +0100
Message-ID: <20231124072142.2786653-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

Ssdtso is a RISC-V ISA extension, which allows to switch the memory
consistency model from RVWMO to TSO (and back) at runtime.
The active model is controlled by a DTSO bit in the {m,h,s}envcfg CSRs
(per-hart state).

TSO is a stronger memory ordering than RVWMO, which means that
executing software that was written for RVWMO can also run under TSO
without causing memory consistency issues.
Since RVWMO is the default model, switching to TSO is safe.

The patch introduces Ssdtso basic support:
* define the relevant bits
* register the the extension in hwcap/cpufeatures
* extend thread_struct to keep the state across context switches
* add the relevant code to store/restore the DTSO state

Following the pattern of existing code, this patch also introduces
a Kconfig symbol ('RISCV_ISA_SSDTSO') to disable Ssdtso support.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/Kconfig                 | 10 ++++
 arch/riscv/include/asm/csr.h       |  1 +
 arch/riscv/include/asm/dtso.h      | 74 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/hwcap.h     |  1 +
 arch/riscv/include/asm/processor.h |  1 +
 arch/riscv/include/asm/switch_to.h |  3 ++
 arch/riscv/kernel/cpufeature.c     |  1 +
 arch/riscv/kernel/process.c        |  4 ++
 8 files changed, 95 insertions(+)
 create mode 100644 arch/riscv/include/asm/dtso.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..c62718fa8e7f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -457,6 +457,16 @@ config RISCV_ISA_C
 
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
index 306a19a5509c..2689ad6b2b60 100644
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
index 000000000000..f8a758c45e05
--- /dev/null
+++ b/arch/riscv/include/asm/dtso.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023 Christoph Muellner <christoph.muellner@vrull.eu>
+ */
+
+#ifndef __ASM_RISCV_DTSO_H
+#define __ASM_RISCV_DTSO_H
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
+static inline bool dtso_is_enabled(void)
+{
+	if (has_dtso())
+		return csr_read(CSR_SENVCFG) & ENVCFG_DTSO;
+	return 0;
+}
+
+static inline void dtso_disable(void)
+{
+	if (has_dtso())
+		csr_clear(CSR_SENVCFG, ENVCFG_DTSO);
+}
+
+static inline void dtso_enable(void)
+{
+	if (has_dtso())
+		csr_set(CSR_SENVCFG, ENVCFG_DTSO);
+}
+
+static inline void dtso_save(struct task_struct *task)
+{
+	task->thread.dtso_ena = dtso_is_enabled();
+}
+
+static inline void dtso_restore(struct task_struct *task)
+{
+	if (task->thread.dtso_ena)
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
+	dtso_save(prev);
+	dtso_restore(next);
+}
+
+#else /* ! CONFIG_RISCV_ISA_SSDTSO */
+
+static __always_inline bool has_dtso(void) { return false; }
+static __always_inline bool dtso_is_enabled(void) { return false; }
+#define dtso_disable() do { } while (0)
+#define dtso_enable() do { } while (0)
+#define dtso_save(task) do { } while (0)
+#define dtso_restore(task) do { } while (0)
+#define __switch_to_dtso(prev, next) do { } while (0)
+
+#endif /* CONFIG_RISCV_ISA_SSDTSO */
+
+#endif /* ! __ASM_RISCV_DTSO_H */
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 06d30526ef3b..cbf924d6dfb7 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -57,6 +57,7 @@
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_SMSTATEEN		43
 #define RISCV_ISA_EXT_ZICOND		44
+#define RISCV_ISA_EXT_SSDTSO		45
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..79cc5e6377b8 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -84,6 +84,7 @@ struct thread_struct {
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
+	bool dtso_ena; /* Dynamic TSO enable */
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index f90d8e42f3c7..f07180a3b533 100644
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
@@ -81,6 +82,8 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	if (has_dtso())					\
+		__switch_to_dtso(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..381ba02689ca 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -181,6 +181,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssdtso, RISCV_ISA_EXT_SSDTSO),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4f21d970a129..65462b675740 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -172,6 +172,10 @@ void flush_thread(void)
 	kfree(current->thread.vstate.datap);
 	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
 #endif
+#ifdef CONFIG_RISCV_ISA_SSDTSO
+	/* Reset DTSO state */
+	current->thread.dtso_ena = false;
+#endif
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
-- 
2.41.0


