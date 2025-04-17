Return-Path: <linux-kselftest+bounces-31052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02796A91BEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F2419E499B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298424A06C;
	Thu, 17 Apr 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XAbYuEv6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F4245020
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892686; cv=none; b=jVcDkcuKx+KK0AWtPvSXB7aYdRvdtqKowlNEwISgZHnLgH7lZoERggeVAQzN7Nf2ewNJHPmKd9YBGr+q+0zfqwtiBbhEKmLqxFd5oPe+9ZgmD1JtFxee4NC3ZHoJEc0vSaWB8MLbYKJlxtiVuzzZyuU/VVdu8vBywgK7COlM9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892686; c=relaxed/simple;
	bh=rbdsRD0AuDfdqVGoo+Md0aUA1Wflf8NIwMFM/Sb6wIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtKaNtsw+a94/m1DGXs3JRwnT++mrJU4sdN4C6xfFJEG2dsFbmHc50Ectd35a6vYcqMhpVs81X6AY5D4uKodh/1utW/o9f01kHWVFTHG+Db1Xp5bOxnhCz3UdrB+CfJHx5xgSj9g+mJ2PSFRIF8aqgCBJ1tUuIP0kZ0wtsj7ZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XAbYuEv6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so7404435ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892684; x=1745497484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZffLnUvyDxY5lnr7nm4ZxhnqMm5pHoMLqJFCY6yvcnE=;
        b=XAbYuEv6VwYQ4ypK/XHXKi+ezIXrA5F/9jh+DBA5vjpeP7eUKLO7jmNLUMC/Tnqe6H
         XZUnXfCGY8QdDAYBkxL2Ir0msIfRcmgj4ZKqXi9o8jUucH2sHBP6PRleVVMKXEsqvFGJ
         3wZLYwjpPGQ7LTxKbOp+MEnXXmeje/aiydcoxyXQ34Xmu9IL7h2hdW274QbjGIAUI9uM
         70zKbaTYbqueWlORefbNKdmuOBAKCCJFLeqYIPRbtQYCs/JZWwBntf4mD52Y5FhCwpgu
         PwdPmi2mzG/qrSINDh9rQPor8mzNo4/+dd+tFECPuBRoneapMbddCmVHZhx6g0yClGyP
         ynLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892684; x=1745497484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZffLnUvyDxY5lnr7nm4ZxhnqMm5pHoMLqJFCY6yvcnE=;
        b=aTtKVJLXruwBdwA7GnK4e8nSBX5GNX0hAqKuu4mksdr8T8/hAhpT9hyH3R9HbqakRd
         V6L7wVUUw/JtwDykmjYIA11/HNEGoDGkJFRWSXnvD5n4td9EdZypBr+i2yp/aB2nxfzp
         17sJnX3CG4LkSrR3/LaRJR/AjQ7DwuFE/W7UjJorPfYSi6qKs739qewK+FxNqJUzlzY+
         sed/Ju4PS0tDlc2VgwNg3lQmCzrScvNnqCXknI4x7kQSbiS25mYvbdiacQcVEsQ/9rhA
         DcW/r/i/JBO51m/wHdct+33hZUoMEATBjZLiAo0ekurC2PCtvmW/EIyCZhhNhl38XDwu
         t3ag==
X-Forwarded-Encrypted: i=1; AJvYcCVFWQnbOpOkb3i+W+OE0XXsK6N3s1QM7vcKqPk1+DCGUB3QkKx7XdQD+CDSO/MlZRkn/JtTZJj3NudWX4fA124=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtdgc9GCUBEO1FtDxRcNnOGKdqPqEBIJsKlhslhsfOI9jxwlW1
	pFWJwyoG2M82XdN6DKacAErlAFfQHeemMxXCK9VoUxHUW4ZukIrgXn6iiLnjDOg=
X-Gm-Gg: ASbGncv0KHTDchYvKB8VcdoIh1DgGq/YnHVMg7m0XslKEauQHrvosiofkUInap4Y3Vb
	WJqWteQksRXodio2j5LiNCstNLksXfMzxkw4fdaghC2lKpU4J1HTn/1bYYd2rYyEdzOgXgBj5ej
	jsgG8pptlUgcJaB80D2YuzuZJwFjLfBHGaxYNx25xzNkzswnx7aVyotFgO8q0yUrFVCPb6Unmbe
	+EYkD7/OmkpXkNpUlgs4ElZAHq8ky1Pq1AJ2eGkCSZLNdepWcFb4eeSLbpQkZu4EBXSNPVecwVT
	AWAO9jp+G17vnMtM+uSkb0LgMeRXcro2o6VgBUwGmw==
X-Google-Smtp-Source: AGHT+IGh/BYwkefJ9AAON/g15uIjE6Ad6rojhY99Eh6G81EOlK8D2lFOXm78WPt4vUtVQfXYtoHamQ==
X-Received: by 2002:a17:903:2f83:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22c358c5d8fmr81179515ad.11.1744892683747;
        Thu, 17 Apr 2025 05:24:43 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:24:43 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 05/13] riscv: misaligned: request misaligned exception from SBI
Date: Thu, 17 Apr 2025 14:19:52 +0200
Message-ID: <20250417122337.547969-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417122337.547969-1-cleger@rivosinc.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the kernel can handle misaligned accesses in S-mode, request
misaligned access exception delegation from SBI. This uses the FWFT SBI
extension defined in SBI version 3.0.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h        |  3 +-
 arch/riscv/kernel/traps_misaligned.c       | 71 +++++++++++++++++++++-
 arch/riscv/kernel/unaligned_access_speed.c |  8 ++-
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index f56b409361fb..dbe5970d4fe6 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -67,8 +67,9 @@ void __init riscv_user_isa_enable(void);
 	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
 bool __init check_unaligned_access_emulated_all_cpus(void);
+void unaligned_access_init(void);
+int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
-void check_unaligned_access_emulated(struct work_struct *work __always_unused);
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 97c674d7d34f..058a69c30181 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -16,6 +16,7 @@
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
 #include <asm/cpufeature.h>
+#include <asm/sbi.h>
 #include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
@@ -629,7 +630,7 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -640,6 +641,13 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	__asm__ __volatile__ (
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
+}
+
+static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
+{
+	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
+
+	check_unaligned_access_emulated(NULL);
 
 	/*
 	 * If unaligned_ctl is already set, this means that we detected that all
@@ -648,9 +656,10 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	 */
 	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED))) {
 		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 bool __init check_unaligned_access_emulated_all_cpus(void)
@@ -682,4 +691,60 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
 {
 	return false;
 }
+static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_RISCV_SBI
+
+static bool misaligned_traps_delegated;
+
+static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
+{
+	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
+	    misaligned_traps_delegated) {
+		pr_crit("Misaligned trap delegation non homogeneous (expected delegated)");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void unaligned_access_init(void)
+{
+	int ret;
+
+	ret = sbi_fwft_local_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0);
+	if (ret)
+		return;
+
+	misaligned_traps_delegated = true;
+	pr_info("SBI misaligned access exception delegation ok\n");
+	/*
+	 * Note that we don't have to take any specific action here, if
+	 * the delegation is successful, then
+	 * check_unaligned_access_emulated() will verify that indeed the
+	 * platform traps on misaligned accesses.
+	 */
+}
+#else
+void unaligned_access_init(void) {}
+
+static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
+{
+	return 0;
+}
 #endif
+
+int cpu_online_unaligned_access_init(unsigned int cpu)
+{
+	int ret;
+
+	ret = cpu_online_sbi_unaligned_setup(cpu);
+	if (ret)
+		return ret;
+
+	return cpu_online_check_unaligned_access_emulated(cpu);
+}
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 585d2dcf2dab..a64d51a8da47 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -236,6 +236,11 @@ arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
 
 static int riscv_online_cpu(unsigned int cpu)
 {
+	int ret = cpu_online_unaligned_access_init(cpu);
+
+	if (ret)
+		return ret;
+
 	/* We are already set since the last check */
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN) {
 		goto exit;
@@ -248,7 +253,6 @@ static int riscv_online_cpu(unsigned int cpu)
 	{
 		static struct page *buf;
 
-		check_unaligned_access_emulated(NULL);
 		buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
 		if (!buf) {
 			pr_warn("Allocation failure, not measuring misaligned performance\n");
@@ -439,6 +443,8 @@ static int __init check_unaligned_access_all_cpus(void)
 {
 	int cpu;
 
+	unaligned_access_init();
+
 	if (unaligned_scalar_speed_param == RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN &&
 	    !check_unaligned_access_emulated_all_cpus()) {
 		check_unaligned_access_speed_all_cpus();
-- 
2.49.0


