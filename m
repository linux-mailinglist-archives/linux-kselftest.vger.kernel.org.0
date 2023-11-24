Return-Path: <linux-kselftest+bounces-499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47AA7F6CD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D3028194A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C9B63D5;
	Fri, 24 Nov 2023 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="ETzqhdXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C1D6E
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so2150731a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700810532; x=1701415332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyHjshVZY4a+CzgGKu86RdRFHE9Gyk/gNKjRroh1RbA=;
        b=ETzqhdXi3jJHeyflpyjXWZAHLbBIRj36vUutURfKifa/kwoAXFwgtv+yC9zbisCQsu
         o3hrVZuZmXin6GgNe1n4+3opXe1XMa/QbFn/YGgxX+6ES3TIV3Gfv5ru9IbvsUY7cFvt
         weAtYQLrkywn5zcn43OUW0efN4lGfPrRIP4yVUFBh3iuCDwEdv2koR7jWTGV35vpsYB+
         IxGEet++UtXe8D4UPmCXmhqgzQzUQ2slfJDZ7P11TM/5T9JSxtsbdEkom4HOuDfDnbGB
         axTTYKX7O9q52CqggSd25tvGUX4miqMQXdJEso7ewU17FE7UxNlLSRdTDyDEpStA9Miw
         XILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700810532; x=1701415332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyHjshVZY4a+CzgGKu86RdRFHE9Gyk/gNKjRroh1RbA=;
        b=Lgo5/FjaDbytbN4NBP649Ng6px/uWMFT29I229mic4jtzNpI5Wfm7kLV9iIkGn0imy
         MkzeTPCp+QjWeeBo1MZq8hjGHKAA+l6s4rp9Z6FNt64NJh+kN92oOaI7e/9bZ16OAryl
         wqtjcXSgA0V3nrT7sb1TXz/lBcQg2PcAxD9eMfLzH69k/QsH+3Snb7KpxL6auX3XS5SU
         ZBoqAWE6U+AG0Qe+t2t8Fm0BC/UIbUPQ/GsAprK3ikfjM31T7wDoGV2zf5n/4yvSSTxT
         PeoBMWvemLqPPiBt4w+iZIGJ13HZGB2mPKaH7u3I2SiLApQDQNsSL2GOOlNquKMetLnn
         n/Eg==
X-Gm-Message-State: AOJu0Yw6xOmXKSFjFwh0F2N/SBCN7T6ogb/ouivuBGu5xtnXk3wUOQOm
	urq0n20BbrDgTpW9LgJ5xPOlNg==
X-Google-Smtp-Source: AGHT+IEeR8RiraoHcQMfKVQPMc/bI/tKyEPjsNFqwM2sa2syPi4of5FlqT3IwZAKP2ce7aPUm/rHLQ==
X-Received: by 2002:a17:906:651:b0:9fe:81a:c258 with SMTP id t17-20020a170906065100b009fe081ac258mr1199022ejb.26.1700810532654;
        Thu, 23 Nov 2023 23:22:12 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b00992f2befcbcsm1709930eji.180.2023.11.23.23.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:22:12 -0800 (PST)
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
Subject: [RFC PATCH 4/5] RISC-V: Implement prctl call to set/get the memory consistency model
Date: Fri, 24 Nov 2023 08:21:41 +0100
Message-ID: <20231124072142.2786653-5-christoph.muellner@vrull.eu>
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

We can use the PR_{S,G}ET_MEMORY_CONSISTENCY_MODEL prctl calls to change
the memory consistency model at run-time if we have Ssdtso.
This patch registers RISCV_WMO and RISCV_TSO as valid arguments
for these prctl calls and implements the glue code to switch
between these.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 .../mm/dynamic-memory-consistency-model.rst   | 18 ++++++++++
 arch/riscv/include/asm/processor.h            |  7 ++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/dtso.c                      | 33 +++++++++++++++++++
 include/uapi/linux/prctl.h                    |  2 ++
 5 files changed, 61 insertions(+)
 create mode 100644 arch/riscv/kernel/dtso.c

diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/Documentation/mm/dynamic-memory-consistency-model.rst
index 21675b41ec84..4a6107a4b71f 100644
--- a/Documentation/mm/dynamic-memory-consistency-model.rst
+++ b/Documentation/mm/dynamic-memory-consistency-model.rst
@@ -56,3 +56,21 @@ Two prctl calls are defined to get/set the active memory consistency model:
     to the given model. If the architecture does not support dynamic
     memory consistency models or does not support the provided model, then
     -1 is returned, and errno is set to EINVAL.
+
+Supported memory consistency models
+===================================
+
+This section defines the memory consistency models which are supported
+by the prctl interface.
+
+RISC-V
+------
+
+RISC-V uses RVWMO (RISC-V weak memory ordering) as default memory consistency
+model. TSO (total store ordering) is another specified model and provides
+additional ordering guarantees. Switching from RVWMO to TSO (and back) is
+possible when the Ssdtso extension is available.
+
+* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO`: RISC-V weak memory ordering (default).
+
+* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO`: RISC-V total store ordering.
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 79cc5e6377b8..b0c19ddb2cfb 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -146,6 +146,13 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#ifdef CONFIG_RISCV_ISA_SSDTSO
+#define SET_MEMORY_CONSISTENCY_MODEL(arg)	dtso_set_memory_ordering(arg)
+#define GET_MEMORY_CONSISTENCY_MODEL()		dtso_get_memory_ordering()
+extern int dtso_set_memory_consistency_model(unsigned long arg);
+extern int dtso_get_memory_consistency_model(void);
+#endif /* CONIG_RISCV_ISA_SSDTSO */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..17cf74ac8e21 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
+obj-$(CONFIG_RISCV_ISA_SSDTSO)	+= dtso.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
diff --git a/arch/riscv/kernel/dtso.c b/arch/riscv/kernel/dtso.c
new file mode 100644
index 000000000000..fcf7e2e80362
--- /dev/null
+++ b/arch/riscv/kernel/dtso.c
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023 Christoph Muellner <christoph.muellner@vrull.eu>
+ */
+
+#include <linux/export.h>
+#include <linux/prctl.h>
+#include <asm/dtso.h>
+
+int riscv_set_memory_consistency_model(unsigned long arg)
+{
+	switch (arg) {
+	case PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO:
+		dtso_disable();
+		break;
+	case PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO:
+		if (!has_dtso())
+			return -EINVAL;
+		dtso_enable();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int riscv_get_memory_consistency_model(void)
+{
+	if (has_dtso() && dtso_is_enabled())
+		return PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO;
+	return PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO;
+}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 579662731eaa..20264bdc3092 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -308,5 +308,7 @@ struct prctl_mm_map {
 
 #define PR_SET_MEMORY_CONSISTENCY_MODEL		71
 #define PR_GET_MEMORY_CONSISTENCY_MODEL		72
+# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO	1
+# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO	2
 
 #endif /* _LINUX_PRCTL_H */
-- 
2.41.0


