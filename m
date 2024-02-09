Return-Path: <linux-kselftest+bounces-4385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C784F054
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 07:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF97FB2550E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59265BD7;
	Fri,  9 Feb 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="P6tXWZWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC85651BA
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460866; cv=none; b=eEXEY0c+nd3Y03LLA4TVp0Er0n6m284fKMd9GhDaTRMrAMcwfcqfcIjtYBsoeFuFZ/qnfRvt/vkHQnz82nZS1NkHoq1ablvzH8iz9MJRVjWEybfLLLRb+Kj/JSqzrG5X2YkbKMslo5Yz/BqT0ITBbST5anLDbhByNdCCmNuhwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460866; c=relaxed/simple;
	bh=9q5u5mn2yt3TNWv2o6zK1dMR/MK4vyDvOyRaiZvPzD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swj63auQC7qEzB01PzF0LHu2OdUxbjhdTiqyc+MNEUmN/Lb7wj3JU82zQGFX9sKTwsOYOpF5olhV6RXA2mZZ+MlfvlbpcxBOtazTe1rmcMAuqtdG6yI+M0h2NzJ62rnizP71uTBpopy/x477cvXJG6JV32FlR7B93n2uyYrjlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=P6tXWZWL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a383016f428so59912666b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 22:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1707460862; x=1708065662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST8e7AXP20QlvDbKLGY7HjIR6vrJd80LvNJ9Brmy7H4=;
        b=P6tXWZWL6g8FW3AHtq5QqTwYfpX/NUhnajcF6IfCGJ++H/2F2npan26fQDhHyWLVwZ
         z6ADMDmm8XjeyaMt/qo2hY8x9sOYmyNXTHSOkKBaZ6SnDN4NT+86trVxn29LuMdQmy3T
         P0LVHNGO+AwpHik5+cpAwbZ6rXun7bsJjlJZJR8W3ODDP8LZT0eIM170zxSPDmodKHAF
         kbn6QhS/4ZAlLKaGG0T2xFMR479RwXL1up+MDIsGJNA/DwipeqS8KMM2QEnwbHGgRz9e
         4/rNvbGvTQcp64ION4lX8FBJb5kyPbKmO7Mz54doyDTsPBm3rqXeGC/oh1nGNlf4Orvq
         LtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460862; x=1708065662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST8e7AXP20QlvDbKLGY7HjIR6vrJd80LvNJ9Brmy7H4=;
        b=YaBnPAt5PPxeB2GQK7z4ls0QhQp6IGj3vCzzPmkeNCp12qNts/9yRTMBGW4jShyAPf
         KCZHBOWcywtk73d3gtgvZN938SnZaoPEQXsWzo7KkZ5FSIONh6qZTQjRYMGa9jDEDt2v
         cB1jz2w50xCi07Nipu5mvl4wGgNb1dTp9nK6GK04wBDzTx2kl+wNAQiAuu74WSDYEyFj
         A6epUbZikg0zbnHcZ7bbMnKNfOHjQrAbDNybHrtfiGJQw8byHOgojUxdafn6IL/OyJ2Y
         xdFm53qvWxecVi9ikEBibbMxicIq0/AkEBJzFPAPKP82VGnAr3JswXzE9Dafcvh60goS
         M0KA==
X-Forwarded-Encrypted: i=1; AJvYcCWGAkufnPA/aMNGybv7zk3W6l8qEOFRFslI6DPW8QVNuRXqgfE2sxuL13Cz5h/34beunQ0QbJp4JCjaAfula5xfWjoAgD42EbM62sx0cf97
X-Gm-Message-State: AOJu0YzjRLwtc+g/TAxcfT+FF1rdsCAMmlw0+CMxEK6E+FgVBQz0Ax6z
	FwSTSsd4iy4IcO/Ki9ZNm9BxSYxFFftCiydxz7yA8s3BJDWbowwqMg0/VcGbAqM=
X-Google-Smtp-Source: AGHT+IHJxpP7wNCT0XP54IBN7nE37NyEnMgUpbvOnsyakzsvJGztY1XpZVbrFW4xhEKC6uRrNdPefA==
X-Received: by 2002:a17:906:22cf:b0:a3b:bf5d:1089 with SMTP id q15-20020a17090622cf00b00a3bbf5d1089mr512293eja.20.1707460862356;
        Thu, 08 Feb 2024 22:41:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5OzmNE8LiMqHmaGw/QPWfvFxV8RhGPBp+rnFG+Na0Q3cHsxEhfqQL2QspBYEjTxncL+jeqmpc6BHhKbUGQZLQZewRKoXY1iAMbJcBSUMim5GOBuHcYcmKRDq5LzkFF6pZijFFDjIK8pAotOIwKg4LdT0fZ+tybBjyb2deghtcEZIiJYGnnjQpRS2cdoLe1GXXpm0bIub3MmnoQfwMvOhFsJ+xC4expH1Xe/5YbvIap8/82wHazrs6ceuEcXYYrVo2IIOEYrUaQ5886DYbYfgRhdO4MVOiVA5XGUcekIznv+7nUHELZh4ciUWoHnNCTVyrY2LtrZJfrq2HFEmD+J25f95+AowlS8ktKhqRDUa3jSiC+GGBlx8KqnuugRTdlEIKFP9UBFx+lCkhTIRI+oo15JlyrlMgkMPkJVmGprlVWHKV8DBzuecYZF1dHRVXC0En4/fvC5F2Lg/LTEoTWh3Bg/sTR8Ody5b/Fk8beJnWo3NKZGIj3O+LrSJCrw6UCUvaLdkwn3ijLipnwx6VJn2gYbJBXsvgsoDCgF6d8C8TDj7YVwANKq3wuS+EAwwIwrOVpXo3AoynYhcchjB1OcU44v5hBT9B8ltomg+oHTA+Aw3TmTg7vsQAdohx2ELbWvwoirRoXWCFh2fAHNKNZCRxTPT8j0p9CAz4YOF/3u7ioq5R9mOoYpRc1oJBrCWWay3i4/NF2QF0I9Ud+Pa8ZrP9d+YZhffxiopRD2lR/p+rQwmx6bpWQTFFlaZfIcQp4EcVo1wrzjEu9pQRlh0XH0Y/fV6vlIV/bDTEUDkm2hoNVaZwOXC7V1JSvdIVLW4Lpi81Oj+Bv3c4InNxAnMWrhiz4N6nwyqjeu5ta/UeHehdMQ==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a370a76d3a0sm441180ejc.123.2024.02.08.22.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:41:01 -0800 (PST)
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
Subject: [RFC PATCH v2 4/6] RISC-V: Implement prctl call to set/get the memory consistency model
Date: Fri,  9 Feb 2024 07:40:48 +0100
Message-ID: <20240209064050.2746540-5-christoph.muellner@vrull.eu>
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

We can use the PR_{S,G}ET_MEMORY_CONSISTENCY_MODEL prctl calls to change
the memory consistency model at run-time if we have Ssdtso.
This patch registers RISCV_WMO and RISCV_TSO as valid arguments
for these prctl calls and implements the glue code to switch
between these.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 .../mm/dynamic-memory-consistency-model.rst   | 12 +++-
 arch/riscv/include/asm/processor.h            |  7 ++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/dtso.c                      | 67 +++++++++++++++++++
 include/uapi/linux/prctl.h                    |  2 +
 5 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/dtso.c

diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/Documentation/mm/dynamic-memory-consistency-model.rst
index 1fce855a1fad..c8188c174e27 100644
--- a/Documentation/mm/dynamic-memory-consistency-model.rst
+++ b/Documentation/mm/dynamic-memory-consistency-model.rst
@@ -73,4 +73,14 @@ Supported memory consistency models
 This section defines the memory consistency models which are supported
 by the prctl interface.
 
-<none>
+RISC-V
+------
+
+RISC-V uses RVWMO (RISC-V weak memory ordering) as default memory consistency
+model. TSO (total store ordering) is another specified model and provides
+additional ordering guarantees. Switching user-mode processes from RVWMO to TSO
+is possible when the Ssdtso extension is available.
+
+* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO`: RISC-V weak memory ordering (default).
+
+* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO`: RISC-V total store ordering.
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index a8509cc31ab2..05e05fddc94d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -184,6 +184,13 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#ifdef CONFIG_RISCV_ISA_SSDTSO
+extern int dtso_set_memory_consistency_model(unsigned long arg);
+extern int dtso_get_memory_consistency_model(void);
+#define SET_MEMORY_CONSISTENCY_MODEL(arg)	dtso_set_memory_consistency_model(arg)
+#define GET_MEMORY_CONSISTENCY_MODEL()		dtso_get_memory_consistency_model()
+#endif /* CONIG_RISCV_ISA_SSDTSO */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..85f7291da498 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
+obj-$(CONFIG_RISCV_ISA_SSDTSO)	+= dtso.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
diff --git a/arch/riscv/kernel/dtso.c b/arch/riscv/kernel/dtso.c
new file mode 100644
index 000000000000..591d5f9de0f5
--- /dev/null
+++ b/arch/riscv/kernel/dtso.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024 Christoph Muellner <christoph.muellner@vrull.eu>
+ */
+
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/prctl.h>
+
+#include <asm/cpu.h>
+#include <asm/dtso.h>
+
+#include <trace/events/ipi.h>
+
+int dtso_set_memory_consistency_model(unsigned long arg)
+{
+	int cpu;
+	unsigned long cur_model = get_memory_consistency_model(current);
+	unsigned long new_model;
+
+	switch (arg) {
+	case PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO:
+		new_model = RISCV_MEMORY_CONSISTENCY_MODEL_WMO;
+		break;
+	case PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO:
+		new_model = RISCV_MEMORY_CONSISTENCY_MODEL_TSO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* No change requested. */
+	if (cur_model == new_model)
+		return 0;
+
+	/* Enabling TSO only works if DTSO is available. */
+	if (new_model == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO && !has_dtso())
+		return -EINVAL;
+
+	/* Switching TSO->WMO is not allowed. */
+	if (new_model == RISCV_MEMORY_CONSISTENCY_MODEL_WMO)
+		return -EINVAL;
+
+	/* Set the new model in the task struct. */
+	set_memory_consitency_model(current, new_model);
+
+	/*
+	 * We need to reschedule all threads of the current process.
+	 * Let's do this by rescheduling all CPUs.
+	 * This is stricter than necessary, but since this call is
+	 * not expected to happen frequently the impact is low.
+	 */
+	for_each_cpu(cpu, cpu_online_mask)
+		smp_send_reschedule(cpu);
+
+	return 0;
+}
+
+int dtso_get_memory_consistency_model(void)
+{
+	unsigned long cur_model = get_memory_consistency_model(current);
+
+	if (cur_model == RISCV_MEMORY_CONSISTENCY_MODEL_TSO)
+		return PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO;
+
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
2.43.0


